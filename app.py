from flask import Flask, jsonify, redirect, render_template, request, session
from flaskext.mysql import MySQL
from flask_bcrypt import Bcrypt
import pandas as pd
import numpy as np
from scipy.cluster.hierarchy import dendrogram, linkage, cophenet
from scipy.spatial.distance import pdist
from sklearn.metrics import silhouette_score
from sklearn.cluster import AgglomerativeClustering
import geopandas as gpd
import io
import matplotlib.pyplot as plt
from datetime import datetime
import os

# Initialize Flask app
app = Flask(__name__)
app.secret_key = 'secret_bingitzz'

# Initialize MySQL
mysql = MySQL()

# Configure MySQL
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'db_datamining_ahc'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'

# Initialize MySQL connection
mysql.init_app(app)
conn = mysql.connect()

# Define routes
@app.route('/')
def index():
    return render_template('home.html')

@app.route('/login', methods=['POST', 'GET'])
def login():
    try:
        if request.method == 'POST':
            bcrypt = Bcrypt()
            _username = request.json['username']  # Mengakses nilai username dari JSON
            _password = request.json['password']  # Mengakses nilai password dari JSON
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM users WHERE username=%s", (_username,))
            user = cursor.fetchone()
            cursor.close()

            if user:
                if bcrypt.check_password_hash(user[2], _password):
                    session['logged_in'] = True
                    session['id_user'] = user[0]
                    session['username'] = user[1]
                    session['fullname'] = user[4]

                    return jsonify({'message': "Login Berhasil"}), 200
                else:
                    return jsonify({'error': 'Login Gagal! Periksa kembali username dan password!'}), 400
            else:
                return jsonify({'error': 'Login Gagal! Periksa kembali username dan password!'}), 400
        
        if not session.get("logged_in") :
            return render_template('login.html')
        else :
            return redirect("/login")
        
    except Exception as e:
        return jsonify({'error': str(e)}), 400

@app.route('/get-session')
def get_session():
    # Mendapatkan nilai session
    username = session.get('username', None)
    return f'Username dari session adalah: {username}'

@app.route('/logout')
def logout():
    session.clear()
    return redirect('/login')

@app.route('/data-user')
def datauser():
    if not session.get("logged_in") :
        return redirect("/login")
    else :
        cursor = conn.cursor()
        cursor.execute("select * from users")
        user = cursor.fetchall()
        return render_template("data-user.html", users=user)

@app.route('/add-user', methods=["POST"])
def adduser():
    try:
        _username = request.json.get("username")
        _password = request.json.get("password")
        _email = request.json.get("email")
        _fullname = request.json.get("fullname")
        cursor = conn.cursor()
        cursor.execute("SELECT COUNT(*) FROM users WHERE username=%s or email=%s",(_username, _email))
        row_count = cursor.fetchone()[0]
        if row_count == 0 :
            bcrypt = Bcrypt()
            passhashed = bcrypt.generate_password_hash(_password)
            cursor.execute("INSERT INTO users(username, password, email, fullname) VALUES (%s, %s, %s, %s)", (_username, passhashed, _email, _fullname))
            conn.commit()
            cursor.close()
            return jsonify({'message': 'Berhasil menambhkan user baru'}), 200
        else :
            return jsonify({'error':'Username atau Email sudah digunakan user lain!'}), 400
    except Exception as e:
        return jsonify({'error': str(e)}), 400

@app.route('/edit-user/<_id>', methods=["POST", "GET"])
def edituser(_id):
    if request.method == 'POST':
        _username = request.json.get("username")
        _password = request.json.get("password")
        _email = request.json.get("email")
        _fullname = request.json.get("fullname")
        cursor = conn.cursor()
        cursor.execute("SELECT COUNT(*) FROM users WHERE username=%s AND id != %s",(_username, _id))
        usernamecek = cursor.fetchone()[0]

        cursor.execute("SELECT COUNT(*) FROM users WHERE email=%s AND id != %s",(_email, _id))
        emailcek = cursor.fetchone()[0]

        if usernamecek >0 :
            return jsonify({'error':'Username sudah digunakan user lain!'}), 400
        elif emailcek > 0 :
            return jsonify({'error':'E-mail sudah digunakan user lain!'}), 400
        else :
            bcrypt = Bcrypt()
            if _password!= "" :
                passhashed = bcrypt.generate_password_hash(_password)
                cursor.execute("UPDATE users SET username=%s, password=%s, email=%s, fullname=%s WHERE id=%s", (_username, passhashed, _email, _fullname, _id))
                conn.commit()
            else :
                cursor.execute("UPDATE users SET username=%s, email=%s, fullname=%s WHERE id=%s", (_username, _email, _fullname, _id))
                conn.commit()
            cursor.close()
            return jsonify({'message': 'Berhasil memperbaharui user'}), 200
    else :
        cursor = conn.cursor()
        cursor.execute("select * from users where id=%s", _id)
        user = cursor.fetchall()
        if user:
            return jsonify({'user': user[0]})
        else:
            return jsonify({'error': 'User not found'}), 404

@app.route("/delete-user/<id_user>", methods=["POST"])
def deleteuser(id_user):
    try:
        cursor = conn.cursor()
        cursor.execute("delete from users where id=%s", id_user)
        conn.commit()
        cursor.close()

        return jsonify({'message': 'User berhasil dihapus'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 400

@app.route("/dataset")
def dataset():
    cursor = conn.cursor()
    cursor.execute("select * from dataset order by tahun asc")
    dataset = cursor.fetchall()

    dataset_content = {}
    for header in dataset:
        cursor.execute("SELECT * FROM dataset_content WHERE id_dataset = %s", (header[0]))
        dataset_content[header[0]] = cursor.fetchall()

    return render_template('dataset.html', dts=dataset, dts_content=dataset_content)

@app.route('/upload', methods=['POST'])
def upload():
    try:
         # Cek apakah file ada dan berformat CSV
        if 'file' not in request.files:
            # return jsonify({'success': False, 'message': 'Tidak ada file yang diunggah!'})
            return jsonify({'error': 'Tidak ada file yang diunggah! Silahkan pilih file terlebih dahulu!'}), 400
        file = request.files['file']
        if file.filename == '':
            return jsonify({'error': 'Tidak ada file yang dipilih!'}), 400
        if not file.filename.endswith('.csv'):
            return jsonify({'error': 'Format file salah, hanya menerima file CSV. Pastikan format file yang dipilih sudah benar!'}), 400
        
        # Memeriksa apakah file yang diunggah adalah CSV
        file = request.files['file']

        # Baca file CSV dan cek kolom yang dibutuhkan
        df = pd.read_csv(io.StringIO(file.stream.read().decode("UTF8")), sep=';')
        required_columns = ['kabupaten_kota', 'produksi_padi', 'produksi_beras']
        if not all(column in df.columns for column in required_columns):
            return jsonify({'error': 'Atribut/kolom tidak sesuai, pastikan file yang dipilih terdapat atribut kabupaten_kota, produksi_padi dan produksi_beras'}), 400

        # Simpan data ke MySQL
        cursor = conn.cursor()
        id_user = session.get("id_user")
        # Dapatkan data dari form
        _year = request.form.get('tahun')
        _source = request.form.get('sumber')
        _keterangan = request.form.get('keterangan')

        cursor.execute("INSERT INTO dataset ( tahun, sumber, created_by, keterangan) VALUES ( %s, %s, %s, %s)", (_year, _source, id_user, _keterangan))
        conn.commit()

        # mendapatkan last id
        cursor.execute("SELECT LAST_INSERT_ID()")
        result = cursor.fetchone()
        if result is None:
            raise Exception("Gagal mendapatkan id_dataset")
        
        id_dataset = result[0]

        for index, row in df.iterrows():
            cursor.execute("INSERT INTO dataset_content(id_dataset,kabupaten_kota, produksi_padi, produksi_beras, created_by) VALUES (%s, %s, %s, %s, %s)",
                    (id_dataset, row['kabupaten_kota'], row['produksi_padi'], row['produksi_beras'], id_user))

        conn.commit()
        cursor.close()

        return jsonify({'message': 'File dataset berhasil diunggah, selanjutnya Anda dapat melakukan clustering dengan dataset tersebut'}), 200

    except Exception as e:
        conn.rollback()
        return jsonify({'error': str(e)}), 400

@app.route('/hapus_data/<id_dataset>', methods=['POST'])
def hapus_data(id_dataset):
    cursor = conn.cursor()

    # Memeriksa apakah dataset sudah digunakan dalam clustering
    cursor.execute("SELECT COUNT(*) FROM clustering WHERE id=%s", id_dataset)
    row_count = cursor.fetchone()[0]

    if row_count == 0:
        # Menghapus data dari tabel dataset_content
        cursor.execute("DELETE FROM dataset_content WHERE id_dataset=%s", id_dataset)
        conn.commit()

        # Menghapus data dari tabel dataset
        cursor.execute("DELETE FROM dataset WHERE id=%s", id_dataset)
        conn.commit()

        cursor.close()
        return jsonify({'message': 'Dataset berhasil dihapus'}), 200
    else:
        cursor.close()
        return jsonify({'error': 'Dataset ini telah dilakukan clustering, silahkan hapus hasil clustering terlebih dahulu!'}), 400
    
@app.route('/edit-dataset/<_id>', methods=["POST", "GET"])
def editdataset(_id):
    if request.method == 'POST':
        _year = request.json.get('tahun')
        _source = request.json.get('sumber')
        _keterangan = request.json.get('keterangan')
        cursor = conn.cursor()
        
        cursor.execute("UPDATE dataset SET tahun=%s, sumber=%s, keterangan=%s WHERE id=%s", (_year, _source, _keterangan, _id))
        conn.commit()
        cursor.close()
        return jsonify({'message': 'Berhasil memperbaharui dataset'}), 200
    else :
        cursor = conn.cursor()
        cursor.execute("select id, tahun, sumber, keterangan from dataset where id=%s", _id)
        dataset = cursor.fetchall()
        if dataset:
            return jsonify({'dataset': dataset[0]})
        else:
            return jsonify({'error': 'Dataset not found'}), 404

@app.route('/clustering')
def clustering():
    cursor = conn.cursor()
    cursor.execute("SELECT dts.id AS dataset_id, dts.tahun, cls.id AS clustering_id, cls.total_cluster, cls.algorithm, cls.dendogram, cls.silhouette_score FROM dataset dts LEFT JOIN clustering cls ON cls.id_dataset = dts.id ORDER BY dts.tahun ASC",)
    clustering = cursor.fetchall()

    clustering_content = {}
    for header in clustering:
        cursor.execute("""
            SELECT 
                cls_c.cluster, 
                GROUP_CONCAT(dts_c.kabupaten_kota SEPARATOR ', ') AS anggota_cluster, 
                COUNT(*) AS jumlah_anggota, 
                ROUND(AVG(dts_c.produksi_padi), 2) AS rata_padi, 
                ROUND(AVG(dts_c.produksi_beras), 2) AS rata_beras, 
                cls_c.keterangan 
            FROM 
                clustering_content cls_c 
            JOIN 
                dataset_content dts_c ON dts_c.id = cls_c.id_dataset_content 
            WHERE 
                cls_c.id_clustering = %s 
            GROUP BY 
                cls_c.cluster;
            """, (header[2],))
        clustering_content[header[2]] = cursor.fetchall()

    return render_template("clustering.html", cls=clustering, cls_c=clustering_content)

@app.route('/clustering_korelasi/<id_dataset>', methods=['POST'])
def clustering_korelasi(id_dataset):
    try:
        #get the original dataset
        cursor = conn.cursor()
        cursor.execute("SELECT id, kabupaten_kota, produksi_padi, produksi_beras FROM dataset_content WHERE id_dataset=%s", id_dataset)
        data = cursor.fetchall()

        # Convert the data to a DataFrame
        df = pd.DataFrame(data, columns=['id','kabupaten_kota','produksi_padi', 'produksi_beras'])
        # Membuat DataFrame baru hanya dengan kolom 'produksi_padi' dan 'produksi_beras'
        df_numeric = df[['produksi_padi', 'produksi_beras']]
        # menghitung matriks jarak berpasangan (pairwise distance matrix
        Z = pdist(df_numeric)
        # Define different linkage methods
        linkage_methods = ['complete', 'average', 'single']
        best_method = None
        best_cophenet_corr = -1

        for method in linkage_methods:
            # Perform hierarchical/agglomerative clustering
            linked = linkage(df_numeric, method=method, metric='euclidean')

            # Compute the cophenetic correlation coefficient
            cophenet_corr, _ = cophenet(linked, Z)

            if cophenet_corr > best_cophenet_corr:
                best_cophenet_corr = cophenet_corr
                best_method = method

        id_user = session.get("id_user")
        cursor.execute("INSERT INTO clustering(id_dataset,algorithm, created_by) VALUES (%s, %s, %s)", (id_dataset, best_method, id_user))
        conn.commit()

         # mendapatkan last id
        cursor.execute("SELECT LAST_INSERT_ID()")
        result = cursor.fetchone()
        if result is None:
            raise Exception("Gagal mendapatkan id_clustering")
        
        id_clustering = result[0]

        #hasilkan dendogram
        plt.figure(figsize=(10, 7))
        # Tambahkan padding untuk memastikan keseluruhan gambar tersimpan
        kabupaten=df['kabupaten_kota'].values
        linked = linkage(df_numeric, method=best_method, metric='euclidean')
        dendrogram(linked, orientation='top', color_threshold=0, leaf_rotation=90, leaf_font_size=8, labels=kabupaten, link_color_func=lambda x: 'black')

        # Tambahkan padding untuk menghindari label yang terpotong
        plt.tight_layout()
        plt.subplots_adjust(bottom=0.3) 
        #simpan dendogram
        date_str = datetime.now().strftime('%Y%m%d')
        filename = f"dendogram-{date_str}-{id_clustering}.jpg"
        save_path = os.path.join('static', 'dendogram', filename)
        os.makedirs(os.path.dirname(save_path), exist_ok=True)
        plt.savefig(save_path, format='jpg', bbox_inches='tight')
        plt.close()

        cursor.execute("UPDATE clustering SET dendogram=%s WHERE id=%s", (filename, id_clustering))
        conn.commit()

        # Tutup koneksi
        cursor.close()
        return jsonify({'message': 'Berhasil menghitung Korelasi Cophenetic.'}), 200
    except Exception as e:
        # Rollback transaksi jika terjadi kesalahan
        conn.rollback()
        return jsonify({'error': str(e)}), 400

@app.route('/clustering_jumlah/', methods=['POST'])
def clustering_jumlah():
    try:
        id_user = session.get("id_user")
        dataform = request.form
        _jum = int(dataform['jumcuster'])
        _id_clustering = int(dataform['id-clustering'])

        if _jum <= 1 :
            raise Exception("Masukkan jumlah cluster paling tidak 2 cluster")
        
        cursor = conn.cursor()
        cursor.execute("SELECT cls.algorithm, dts_c.id AS id_dts_content, dts_c.kabupaten_kota, dts_c.produksi_padi, dts_c.produksi_beras FROM clustering cls JOIN dataset_content dts_c ON dts_c.id_dataset=cls.id_dataset WHERE cls.id=%s", _id_clustering)
        data = cursor.fetchall()

        # Convert the data to a DataFrame
        df = pd.DataFrame(data, columns=['algorithm','id_dts_content','kabupaten_kota','produksi_padi', 'produksi_beras'])
        # Membuat DataFrame baru hanya dengan kolom 'produksi_padi' dan 'produksi_beras'
        df_numeric = df[['produksi_padi', 'produksi_beras']]
        # menghitung matriks jarak berpasangan (pairwise distance matrix

        # Prediksi cluster
        cluster = AgglomerativeClustering(n_clusters=_jum, metric='euclidean', linkage=df['algorithm'].iloc[0])
        clusters = cluster.fit_predict(df_numeric)+1

        # Hitung skor siluet dan ubah menjadi tipe double
        SI = round(float(silhouette_score(df_numeric, clusters)), 4)

        if SI > 0.1:
            # Menyimpan hasil clustering ke dalam database
            cursor.execute("UPDATE clustering SET total_cluster=%s, silhouette_score=%s WHERE id=%s", (_jum, SI, _id_clustering))
            conn.commit()
            cursor.execute("DELETE FROM clustering_content WHERE id_clustering=%s", (_id_clustering))
            conn.commit()
            for idx, label in enumerate(clusters):
                # Menyimpan ke tabel clustering_content
                cursor.execute("INSERT INTO clustering_content(id_clustering,id_dataset_content, cluster, created_by) VALUES (%s, %s,%s, %s)", (_id_clustering,df.loc[idx, 'id_dts_content'], label, id_user))
                # cursor.execute("UPDATE clustering_content SET cluster=%s keterangan=%s WHERE id=%s", (label, df.loc[idx, 'id_cls_content']))
                conn.commit()
            cursor.close()
        else :
            raise Exception("Silhouette Coefficient <= 0, hasil clustering tidak disimpan")
        return jsonify({'message': 'Jumlah cluster berhasil disimpan dan clustering berhasil dilakukan.'}), 200

    except Exception as e:
        # Rollback transaksi jika terjadi kesalahan
        conn.rollback()
        return jsonify({'error': str(e)}), 400

@app.route('/clustering_keterangan/<id_clustering>', methods=['POST'])
def clustering_keterangan(id_clustering):
    try:
        _cluster = int(request.json.get('cluster'))
        _keterangan = request.json.get('keterangan')
        # Buka koneksi dan kursor menggunakan context manager
        with conn.cursor() as cursor:
            cursor.execute("UPDATE clustering_content SET keterangan=%s WHERE id_clustering=%s AND cluster=%s", (_keterangan, id_clustering, _cluster))
            conn.commit()
        return jsonify({'message': 'Berhasil mengatur keterangan.'}), 200
    except Exception as e:
        # Rollback transaksi jika terjadi kesalahan
        conn.rollback()
        return jsonify({'error': str(e)}), 400
    
@app.route('/hapus_clustering/<id_clustering>', methods=['POST'])
def hapus_clustering(id_clustering):
    try:
        # Buka koneksi dan kursor menggunakan context manager
        with conn.cursor() as cursor:
            cursor.execute("DELETE FROM clustering_content WHERE id_clustering=%s", (id_clustering))
            conn.commit()
            cursor.execute("DELETE FROM clustering WHERE id=%s", (id_clustering))
            conn.commit()
        return jsonify({'message': 'Berhasil menghapus clustering.'}), 200
    except Exception as e:
        # Rollback transaksi jika terjadi kesalahan
        conn.rollback()
        return jsonify({'error': str(e)}), 400

@app.route('/hasil-cluster')
def hasil_cluster():
    cursor = conn.cursor()
    # hasil per tahun
    cursor.execute("SELECT dts.id AS dataset_id, dts.tahun, cls.id AS clustering_id, cls.total_cluster FROM clustering cls JOIN dataset dts ON cls.id_dataset = dts.id ORDER BY dts.tahun ASC",)
    clustering = cursor.fetchall()

    clustering_content = {}
    for header in clustering:
        cursor.execute("""
            SELECT 
                cls_c.cluster, 
                GROUP_CONCAT(dts_c.kabupaten_kota SEPARATOR ', ') AS anggota_cluster, 
                COUNT(*) AS jumlah_anggota, 
                ROUND(AVG(dts_c.produksi_padi), 2) AS rata_padi, 
                ROUND(AVG(dts_c.produksi_beras), 2) AS rata_beras, 
                cls_c.keterangan 
            FROM 
                clustering_content cls_c 
            JOIN 
                dataset_content dts_c ON dts_c.id = cls_c.id_dataset_content 
            WHERE 
                cls_c.id_clustering = %s 
            GROUP BY 
                cls_c.cluster;
            """, (header[2],))
        clustering_content[header[2]] = cursor.fetchall()

    return render_template("hasil-cluster.html", cls=clustering, cls_c=clustering_content)
