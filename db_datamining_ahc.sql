-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 21, 2024 at 09:01 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_datamining_ahc`
--

-- --------------------------------------------------------

--
-- Table structure for table `clustering`
--

CREATE TABLE `clustering` (
  `id` int(11) NOT NULL,
  `id_dataset` int(11) NOT NULL,
  `total_cluster` int(11) NOT NULL,
  `algorithm` varchar(200) NOT NULL,
  `dendogram` varchar(200) NOT NULL,
  `silhouette_score` double NOT NULL,
  `pemetaan` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clustering`
--

INSERT INTO `clustering` (`id`, `id_dataset`, `total_cluster`, `algorithm`, `dendogram`, `silhouette_score`, `pemetaan`, `created_at`, `created_by`) VALUES
(2, 2, 4, 'average', 'dendogram-20240526-2.jpg', 0.5391, '', '2024-06-12 03:48:51', 1),
(3, 3, 4, 'average', 'dendogram-20240527-3.jpg', 0.6628, 'pemetaan-20240614-3.jpg', '2024-06-14 15:03:40', 1);

-- --------------------------------------------------------

--
-- Table structure for table `clustering_content`
--

CREATE TABLE `clustering_content` (
  `id` int(11) NOT NULL,
  `id_clustering` int(11) NOT NULL,
  `id_dataset_content` int(11) NOT NULL,
  `cluster` int(11) NOT NULL,
  `keterangan` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clustering_content`
--

INSERT INTO `clustering_content` (`id`, `id_clustering`, `id_dataset_content`, `cluster`, `keterangan`, `created_at`, `created_by`) VALUES
(571, 2, 39, 3, 'Sangat Rendah', '2024-06-12 03:49:31', 1),
(572, 2, 40, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(573, 2, 41, 3, 'Sangat Rendah', '2024-06-12 03:49:31', 1),
(574, 2, 42, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(575, 2, 43, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(576, 2, 44, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(577, 2, 45, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(578, 2, 46, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(579, 2, 47, 2, 'Sedang', '2024-06-12 03:50:27', 1),
(580, 2, 48, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(581, 2, 49, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(582, 2, 50, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(583, 2, 51, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(584, 2, 52, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(585, 2, 53, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(586, 2, 54, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(587, 2, 55, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(588, 2, 56, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(589, 2, 57, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(590, 2, 58, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(591, 2, 59, 2, 'Sedang', '2024-06-12 03:50:27', 1),
(592, 2, 60, 2, 'Sedang', '2024-06-12 03:50:27', 1),
(593, 2, 61, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(594, 2, 62, 4, 'Tinggi', '2024-06-12 03:49:18', 1),
(595, 2, 63, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(596, 2, 64, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(597, 2, 65, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(598, 2, 66, 3, 'Sangat Rendah', '2024-06-12 03:49:31', 1),
(599, 2, 67, 1, 'Rendah', '2024-06-12 03:50:39', 1),
(600, 2, 68, 3, 'Sangat Rendah', '2024-06-12 03:49:31', 1),
(601, 2, 69, 3, 'Sangat Rendah', '2024-06-12 03:49:31', 1),
(602, 2, 70, 3, 'Sangat Rendah', '2024-06-12 03:49:31', 1),
(603, 2, 71, 3, 'Sangat Rendah', '2024-06-12 03:49:31', 1),
(604, 2, 72, 3, 'Sangat Rendah', '2024-06-12 03:49:31', 1),
(605, 2, 73, 3, 'Sangat Rendah', '2024-06-12 03:49:31', 1),
(606, 2, 74, 3, 'Sangat Rendah', '2024-06-12 03:49:31', 1),
(607, 2, 75, 3, 'Sangat Rendah', '2024-06-12 03:49:31', 1),
(608, 2, 76, 3, 'Sangat Rendah', '2024-06-12 03:49:31', 1),
(685, 3, 77, 3, 'Sangat Rendah', '2024-06-14 15:04:59', 1),
(686, 3, 78, 4, 'Sedang', '2024-06-14 15:04:55', 1),
(687, 3, 79, 3, 'Sangat Rendah', '2024-06-14 15:04:59', 1),
(688, 3, 80, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(689, 3, 81, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(690, 3, 82, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(691, 3, 83, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(692, 3, 84, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(693, 3, 85, 1, 'Tinggi', '2024-06-14 15:04:44', 1),
(694, 3, 86, 4, 'Sedang', '2024-06-14 15:04:55', 1),
(695, 3, 87, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(696, 3, 88, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(697, 3, 89, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(698, 3, 90, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(699, 3, 91, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(700, 3, 92, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(701, 3, 93, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(702, 3, 94, 4, 'Sedang', '2024-06-14 15:04:55', 1),
(703, 3, 95, 4, 'Sedang', '2024-06-14 15:04:55', 1),
(704, 3, 96, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(705, 3, 97, 1, 'Tinggi', '2024-06-14 15:04:44', 1),
(706, 3, 98, 1, 'Tinggi', '2024-06-14 15:04:44', 1),
(707, 3, 99, 4, 'Sedang', '2024-06-14 15:04:55', 1),
(708, 3, 100, 1, 'Tinggi', '2024-06-14 15:04:44', 1),
(709, 3, 101, 4, 'Sedang', '2024-06-14 15:04:55', 1),
(710, 3, 102, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(711, 3, 103, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(712, 3, 104, 3, 'Sangat Rendah', '2024-06-14 15:04:59', 1),
(713, 3, 105, 2, 'Rendah', '2024-06-14 15:04:51', 1),
(714, 3, 106, 3, 'Sangat Rendah', '2024-06-14 15:04:59', 1),
(715, 3, 107, 3, 'Sangat Rendah', '2024-06-14 15:04:59', 1),
(716, 3, 108, 3, 'Sangat Rendah', '2024-06-14 15:04:59', 1),
(717, 3, 109, 3, 'Sangat Rendah', '2024-06-14 15:04:59', 1),
(718, 3, 110, 3, 'Sangat Rendah', '2024-06-14 15:04:59', 1),
(719, 3, 111, 3, 'Sangat Rendah', '2024-06-14 15:04:59', 1),
(720, 3, 112, 3, 'Sangat Rendah', '2024-06-14 15:04:59', 1),
(721, 3, 113, 3, 'Sangat Rendah', '2024-06-14 15:04:59', 1),
(722, 3, 114, 3, 'Sangat Rendah', '2024-06-14 15:04:59', 1);

-- --------------------------------------------------------

--
-- Table structure for table `dataset`
--

CREATE TABLE `dataset` (
  `id` int(11) NOT NULL,
  `tahun` varchar(10) NOT NULL,
  `sumber` varchar(250) NOT NULL,
  `keterangan` varchar(200) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dataset`
--

INSERT INTO `dataset` (`id`, `tahun`, `sumber`, `keterangan`, `created_by`, `created_at`) VALUES
(2, '2022', 'https://jatim.bps.go.id/subject/53/tanaman-pangan.html', 'Produksi padi dengan kualitas GKG', 1, '2024-05-23 11:36:28'),
(3, '2021', 'https://jatim.bps.go.id/subject/53/tanaman-pangan.html', 'Produksi padi dengan kualitas GKG', 1, '2024-05-23 11:38:29');

-- --------------------------------------------------------

--
-- Table structure for table `dataset_content`
--

CREATE TABLE `dataset_content` (
  `id` int(11) NOT NULL,
  `id_dataset` int(11) NOT NULL,
  `kabupaten_kota` varchar(200) NOT NULL,
  `produksi_padi` double NOT NULL,
  `produksi_beras` double NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dataset_content`
--

INSERT INTO `dataset_content` (`id`, `id_dataset`, `kabupaten_kota`, `produksi_padi`, `produksi_beras`, `created_by`, `created_at`) VALUES
(39, 2, 'Pacitan', 90428, 52215.06, 1, '2024-05-23 11:36:28'),
(40, 2, 'Ponorogo', 359414, 207532.72, 1, '2024-05-23 11:36:28'),
(41, 2, 'Trenggalek', 115758, 66841, 1, '2024-05-23 11:36:28'),
(42, 2, 'Tulungagung', 207217, 119651.42, 1, '2024-05-23 11:36:28'),
(43, 2, 'Blitar', 215483, 124424.09, 1, '2024-05-23 11:36:28'),
(44, 2, 'Kediri', 168854, 97499.45, 1, '2024-05-23 11:36:28'),
(45, 2, 'Malang', 271607, 156831.2, 1, '2024-05-23 11:36:28'),
(46, 2, 'Lumajang', 300829, 173704.72, 1, '2024-05-23 11:36:28'),
(47, 2, 'Jember', 607371, 350708.35, 1, '2024-05-23 11:36:28'),
(48, 2, 'Banyuwangi', 462206, 266887.02, 1, '2024-05-23 11:36:28'),
(49, 2, 'Bondowoso', 238678, 137817.3, 1, '2024-05-23 11:36:28'),
(50, 2, 'Situbondo', 141628, 81778.89, 1, '2024-05-23 11:36:28'),
(51, 2, 'Probolinggo', 185413, 107060.91, 1, '2024-05-23 11:36:28'),
(52, 2, 'Pasuruan', 247256, 142770.43, 1, '2024-05-23 11:36:28'),
(53, 2, 'Sidoarjo', 194540, 112331.58, 1, '2024-05-23 11:36:28'),
(54, 2, 'Mojokerto', 281829, 162733.96, 1, '2024-05-23 11:36:28'),
(55, 2, 'Jombang', 337172, 194689.98, 1, '2024-05-23 11:36:28'),
(56, 2, 'Nganjuk', 376476, 217385.07, 1, '2024-05-23 11:36:28'),
(57, 2, 'Madiun', 401574, 231876.72, 1, '2024-05-23 11:36:28'),
(58, 2, 'Magetan', 266700, 153997.9, 1, '2024-05-23 11:36:28'),
(59, 2, 'Ngawi', 755939, 436494.35, 1, '2024-05-23 11:36:28'),
(60, 2, 'Bojonegoro', 704289, 406670.62, 1, '2024-05-23 11:36:28'),
(61, 2, 'Tuban', 498939, 288097.19, 1, '2024-05-23 11:36:28'),
(62, 2, 'Lamongan', 903882, 521919.84, 1, '2024-05-23 11:36:28'),
(63, 2, 'Gresik', 411242, 237459.53, 1, '2024-05-23 11:36:28'),
(64, 2, 'Bangkalan', 198123, 114400.05, 1, '2024-05-23 11:36:28'),
(65, 2, 'Sampang', 172494, 99601.72, 1, '2024-05-23 11:36:28'),
(66, 2, 'Pamekasan', 107649, 62158.54, 1, '2024-05-23 11:36:28'),
(67, 2, 'Sumenep', 230581, 133142.3, 1, '2024-05-23 11:36:28'),
(68, 2, 'Kota Kediri', 10198, 5888.24, 1, '2024-05-23 11:36:28'),
(69, 2, 'Kota Blitar', 5212, 3009.59, 1, '2024-05-23 11:36:28'),
(70, 2, 'Kota Malang', 10771, 6219.47, 1, '2024-05-23 11:36:28'),
(71, 2, 'Kota Probolinggo', 8104, 4679.36, 1, '2024-05-23 11:36:28'),
(72, 2, 'Kota Pasuruan', 7294, 4211.51, 1, '2024-05-23 11:36:28'),
(73, 2, 'Kota Mojokerto', 5033, 2906.13, 1, '2024-05-23 11:36:28'),
(74, 2, 'Kota Madiun', 11454, 6613.73, 1, '2024-05-23 11:36:28'),
(75, 2, 'Kota Surabaya', 8117, 4687.1, 1, '2024-05-23 11:36:28'),
(76, 2, 'Kota Batu', 6763, 3904.84, 1, '2024-05-23 11:36:28'),
(77, 3, 'Pacitan', 88117, 50880.29, 1, '2024-05-23 11:38:29'),
(78, 3, 'Ponorogo', 404665, 233661.75, 1, '2024-05-23 11:38:29'),
(79, 3, 'Trenggalek', 116456, 67244.24, 1, '2024-05-23 11:38:29'),
(80, 3, 'Tulungagung', 237917, 137378.06, 1, '2024-05-23 11:38:29'),
(81, 3, 'Blitar', 247366, 142834.27, 1, '2024-05-23 11:38:29'),
(82, 3, 'Kediri', 198222, 114457.39, 1, '2024-05-23 11:38:29'),
(83, 3, 'Malang', 273359, 157842.77, 1, '2024-05-23 11:38:29'),
(84, 3, 'Lumajang', 295076, 170382.55, 1, '2024-05-23 11:38:29'),
(85, 3, 'Jember', 615698, 355516.37, 1, '2024-05-23 11:38:29'),
(86, 3, 'Banyuwangi', 513490, 296499.51, 1, '2024-05-23 11:38:29'),
(87, 3, 'Bondowoso', 258951, 149523.79, 1, '2024-05-23 11:38:29'),
(88, 3, 'Situbondo', 151157, 87281.16, 1, '2024-05-23 11:38:29'),
(89, 3, 'Probolinggo', 190180, 109813.84, 1, '2024-05-23 11:38:29'),
(90, 3, 'Pasuruan', 264951, 152987.93, 1, '2024-05-23 11:38:29'),
(91, 3, 'Sidoarjo', 202501, 116928.41, 1, '2024-05-23 11:38:29'),
(92, 3, 'Mojokerto', 297042, 171518.24, 1, '2024-05-23 11:38:29'),
(93, 3, 'Jombang', 326827, 188716.29, 1, '2024-05-23 11:38:29'),
(94, 3, 'Nganjuk', 429311, 247892.8, 1, '2024-05-23 11:38:29'),
(95, 3, 'Madiun', 461798, 266651.51, 1, '2024-05-23 11:38:29'),
(96, 3, 'Magetan', 307280, 177429.45, 1, '2024-05-23 11:38:29'),
(97, 3, 'Ngawi', 786476, 454126.86, 1, '2024-05-23 11:38:29'),
(98, 3, 'Bojonegoro', 674002, 389182.32, 1, '2024-05-23 11:38:29'),
(99, 3, 'Tuban', 489419, 282600.18, 1, '2024-05-23 11:38:29'),
(100, 3, 'Lamongan', 792662, 457699.04, 1, '2024-05-23 11:38:29'),
(101, 3, 'Gresik', 379666, 219226.91, 1, '2024-05-23 11:38:29'),
(102, 3, 'Bangkalan', 195323, 112783.6, 1, '2024-05-23 11:38:29'),
(103, 3, 'Sampang', 195601, 112943.75, 1, '2024-05-23 11:38:29'),
(104, 3, 'Pamekasan', 96724, 55850.36, 1, '2024-05-23 11:38:29'),
(105, 3, 'Sumenep', 221979, 128175.38, 1, '2024-05-23 11:38:29'),
(106, 3, 'Kota Kediri', 9535, 5505.62, 1, '2024-05-23 11:38:29'),
(107, 3, 'Kota Blitar', 5793, 3345.17, 1, '2024-05-23 11:38:29'),
(108, 3, 'Kota Malang', 11311, 6531.42, 1, '2024-05-23 11:38:29'),
(109, 3, 'Kota Probolinggo', 8924, 5152.96, 1, '2024-05-23 11:38:29'),
(110, 3, 'Kota Pasuruan', 8305, 4795.24, 1, '2024-05-23 11:38:29'),
(111, 3, 'Kota Mojokerto', 4415, 2549.27, 1, '2024-05-23 11:38:29'),
(112, 3, 'Kota Madiun', 13506, 7798.52, 1, '2024-05-23 11:38:29'),
(113, 3, 'Kota Surabaya', 9833, 5677.59, 1, '2024-05-23 11:38:29'),
(114, 3, 'Kota Batu', 5750, 3320.29, 1, '2024-05-23 11:38:29');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(200) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `email` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `fullname`, `email`) VALUES
(1, 'admin', '$2y$10$MyCqRnewFCOsitxwIcUsF.g/fU0zOiT30/B2RTrQva.73H34QLkOe', 'Admin Sistem', 'admin@gmail.com'),
(2, 'admin02', '$2b$12$8H9CWktI2gYG.zeyrZsSA.2CA4HkcrCs/c5/mPHMhSaFfD0bEuGvO', 'Admin Sistem 02', 'admin_02@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clustering`
--
ALTER TABLE `clustering`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_dataset` (`id_dataset`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `clustering_content`
--
ALTER TABLE `clustering_content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_clustering` (`id_clustering`),
  ADD KEY `id_dataset_content` (`id_dataset_content`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `dataset`
--
ALTER TABLE `dataset`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `dataset_content`
--
ALTER TABLE `dataset_content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_dataset` (`id_dataset`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clustering`
--
ALTER TABLE `clustering`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `clustering_content`
--
ALTER TABLE `clustering_content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=799;

--
-- AUTO_INCREMENT for table `dataset`
--
ALTER TABLE `dataset`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `dataset_content`
--
ALTER TABLE `dataset_content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=229;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `clustering`
--
ALTER TABLE `clustering`
  ADD CONSTRAINT `clustering_ibfk_1` FOREIGN KEY (`id_dataset`) REFERENCES `dataset` (`id`),
  ADD CONSTRAINT `clustering_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `clustering_content`
--
ALTER TABLE `clustering_content`
  ADD CONSTRAINT `clustering_content_ibfk_1` FOREIGN KEY (`id_clustering`) REFERENCES `clustering` (`id`),
  ADD CONSTRAINT `clustering_content_ibfk_2` FOREIGN KEY (`id_dataset_content`) REFERENCES `dataset_content` (`id`),
  ADD CONSTRAINT `clustering_content_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `dataset`
--
ALTER TABLE `dataset`
  ADD CONSTRAINT `dataset_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `dataset_content`
--
ALTER TABLE `dataset_content`
  ADD CONSTRAINT `dataset_content_ibfk_1` FOREIGN KEY (`id_dataset`) REFERENCES `dataset` (`id`),
  ADD CONSTRAINT `dataset_content_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
