CLONE REPOSITORY :
git clone https://github.com/hasimazari24/app_clustering_ahc.git
cd app_clustering_ahc

Buat lingkungan virtual:
python -m venv myenv

active env utk install library di dalam environtment ini:
di gitbash : source ./myenv/Scripts/activate
di cmd : .\myenv\Scripts\activate
mematikan : deactivate

Install dependencies:
pip install -r requirements.txt

jalankan flask :
python -m flask run

kalau error terkait werkzeug, turunkan versinya:
pip uninstall werkzeug
pip install werkzeug==2.2.2
