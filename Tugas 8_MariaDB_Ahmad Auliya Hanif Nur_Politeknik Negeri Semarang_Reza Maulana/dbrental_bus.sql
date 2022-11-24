-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 19 Okt 2022 pada 18.04
-- Versi server: 10.4.21-MariaDB
-- Versi PHP: 7.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbrental_bus`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `kendaraan`
--

CREATE TABLE `kendaraan` (
  `id` int(11) NOT NULL,
  `nopol` varchar(20) NOT NULL,
  `idmerek` int(11) NOT NULL,
  `tipe` varchar(20) NOT NULL,
  `tahunrakit` varchar(5) NOT NULL,
  `seat` int(11) NOT NULL,
  `fasilitas` text NOT NULL,
  `foto` varchar(45) DEFAULT NULL,
  `status` enum('Bebas','Jalan') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `kendaraan`
--

INSERT INTO `kendaraan` (`id`, `nopol`, `idmerek`, `tipe`, `tahunrakit`, `seat`, `fasilitas`, `foto`, `status`) VALUES
(1, 'B 1111 VGA', 1, 'NKR 55 CO', '2011', 11, 'Reclining seats,LCD,Multimedia player,Toilet', NULL, 'Jalan'),
(2, 'B 2222 VGA', 2, 'Dutro Bus 130 MDBL', '2011', 20, 'Reclining seats,LCD', 'B 2222 VGA.jpg', 'Bebas'),
(3, 'B 3333 VGA', 2, 'R 260', '2011', 43, 'Reclining seats,Foot rests,LCD,Multimedia player,Wireless microphone,Koneksi wifi', 'B 3333 VGA.jpg', 'Jalan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `merek`
--

CREATE TABLE `merek` (
  `id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `merek`
--

INSERT INTO `merek` (`id`, `nama`) VALUES
(2, 'Hino'),
(1, 'Isuzu'),
(4, 'MAN'),
(5, 'Mercedes Benz'),
(3, 'Scania');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `alamat` text NOT NULL,
  `telepon` varchar(15) NOT NULL,
  `email` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pelanggan`
--

INSERT INTO `pelanggan` (`id`, `nama`, `alamat`, `telepon`, `email`) VALUES
(1, 'Budi', 'Tanah Baru Depok', '123456', ''),
(2, 'Ani', 'Lenteng Agung', '123654', ''),
(3, 'Dewi', 'Srengseng Sawah', '321456', ''),
(4, 'Siti', 'Kelapa Dua Wetan', '654321', ''),
(5, 'Deden', 'Bambu Apus', '876543', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sopir`
--

CREATE TABLE `sopir` (
  `id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `alamat` text NOT NULL,
  `telepon` varchar(15) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `ktp` varchar(30) NOT NULL,
  `sim` varchar(30) NOT NULL,
  `status` enum('Bebas','Jalan') NOT NULL,
  `foto` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `sopir`
--

INSERT INTO `sopir` (`id`, `nama`, `alamat`, `telepon`, `email`, `ktp`, `sim`, `status`, `foto`) VALUES
(1, 'Alexander', 'Jakarta', '08181111', 'alexander@gmail.com', '12341111', '67891111', 'Jalan', '12341111.jpg'),
(2, 'Andreas', 'Bekasi', '08182222', 'andreas@gmail.com', '12342222', '67892222', 'Bebas', '12342222.jpg'),
(3, 'Bimo', 'Depok', '08183333', 'bimo@gmail.com', '12343333', '67893333', 'Jalan', '12343333.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tarif`
--

CREATE TABLE `tarif` (
  `id` int(11) NOT NULL,
  `idkendaraan` int(11) NOT NULL,
  `perhari` double NOT NULL,
  `overtime` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tarif`
--

INSERT INTO `tarif` (`id`, `idkendaraan`, `perhari`, `overtime`) VALUES
(1, 1, 1000000, 1000000),
(2, 2, 2000000, 2100000),
(3, 3, 3000000, 3300000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id` int(11) NOT NULL,
  `idpelanggan` int(11) NOT NULL,
  `idsopir` int(11) NOT NULL,
  `idkendaraan` int(11) NOT NULL,
  `tglmulai` date NOT NULL,
  `tglselesai` date NOT NULL,
  `lamasewa` int(11) NOT NULL,
  `tglovertime` date DEFAULT NULL,
  `jmlovertime` int(11) DEFAULT NULL,
  `total` double NOT NULL,
  `status` enum('Mulai','Selesai') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id`, `idpelanggan`, `idsopir`, `idkendaraan`, `tglmulai`, `tglselesai`, `lamasewa`, `tglovertime`, `jmlovertime`, `total`, `status`) VALUES
(1, 1, 1, 1, '2015-06-01', '2015-06-05', 5, NULL, NULL, 5000000, 'Selesai'),
(2, 4, 3, 2, '2015-07-01', '2015-07-03', 3, '2015-07-09', 6, 18600000, 'Selesai'),
(3, 5, 3, 3, '2015-07-27', '2015-07-31', 5, '2015-08-01', 1, 18300000, 'Mulai'),
(4, 2, 1, 1, '2015-07-19', '2015-07-23', 5, '2015-07-25', 2, 7000000, 'Mulai'),
(5, 1, 1, 1, '2015-07-05', '2015-07-08', 4, '2015-07-11', 3, 7000000, 'Mulai');

--
-- Trigger `transaksi`
--
DELIMITER $$
CREATE TRIGGER `transaksi_batal` AFTER DELETE ON `transaksi` FOR EACH ROW BEGIN
UPDATE kendaraan SET status = 'Bebas'
WHERE id = OLD.idkendaraan;
UPDATE sopir SET status = 'Bebas'
WHERE id = OLD.idsopir;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `transaksi_mulai` AFTER INSERT ON `transaksi` FOR EACH ROW BEGIN
UPDATE kendaraan SET status = 'Jalan'
WHERE id = NEW.idkendaraan;
UPDATE sopir SET status = 'Jalan'
WHERE id = NEW.idsopir;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `transaksi_selesai` AFTER UPDATE ON `transaksi` FOR EACH ROW BEGIN
UPDATE kendaraan SET status = 'Bebas'
WHERE id = OLD.idkendaraan;
UPDATE sopir SET status = 'Bebas'
WHERE id = OLD.idsopir;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `updateStatus` AFTER INSERT ON `transaksi` FOR EACH ROW BEGIN
UPDATE kendaraan SET status = 'Jalan' WHERE id = NEW.idkendaraan;
UPDATE sopir SET status = 'Jalan' WHERE id = NEW.idsopir;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `transaksi_v`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `transaksi_v` (
`id` int(11)
,`idpelanggan` int(11)
,`idsopir` int(11)
,`idkendaraan` int(11)
,`tglmulai` date
,`tglselesai` date
,`lamasewa` int(11)
,`tglovertime` date
,`jmlovertime` int(11)
,`total` double
,`status` enum('Mulai','Selesai')
,`pengemudi` varchar(45)
,`customer` varchar(45)
,`nopol` varchar(20)
,`nama` varchar(45)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `transaksi_v`
--
DROP TABLE IF EXISTS `transaksi_v`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `transaksi_v`  AS SELECT `t`.`id` AS `id`, `t`.`idpelanggan` AS `idpelanggan`, `t`.`idsopir` AS `idsopir`, `t`.`idkendaraan` AS `idkendaraan`, `t`.`tglmulai` AS `tglmulai`, `t`.`tglselesai` AS `tglselesai`, `t`.`lamasewa` AS `lamasewa`, `t`.`tglovertime` AS `tglovertime`, `t`.`jmlovertime` AS `jmlovertime`, `t`.`total` AS `total`, `t`.`status` AS `status`, `s`.`nama` AS `pengemudi`, `p`.`nama` AS `customer`, `k`.`nopol` AS `nopol`, `m`.`nama` AS `nama` FROM ((((`transaksi` `t` join `sopir` `s` on(`s`.`id` = `t`.`idsopir`)) join `pelanggan` `p` on(`p`.`id` = `t`.`idpelanggan`)) join `kendaraan` `k` on(`k`.`id` = `t`.`idkendaraan`)) join `merek` `m` on(`m`.`id` = `k`.`idmerek`)) ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `kendaraan`
--
ALTER TABLE `kendaraan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nopol_UNIQUE` (`nopol`),
  ADD KEY `fk_kendaraan_merek` (`idmerek`);

--
-- Indeks untuk tabel `merek`
--
ALTER TABLE `merek`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama_UNIQUE` (`nama`);

--
-- Indeks untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `sopir`
--
ALTER TABLE `sopir`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tarif`
--
ALTER TABLE `tarif`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tarif_kendaraan1` (`idkendaraan`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_sopir_has_kendaraan_sopir1` (`idsopir`),
  ADD KEY `fk_sopir_has_kendaraan_kendaraan1` (`idkendaraan`),
  ADD KEY `fk_transaksi_pelanggan1` (`idpelanggan`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `kendaraan`
--
ALTER TABLE `kendaraan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `merek`
--
ALTER TABLE `merek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `sopir`
--
ALTER TABLE `sopir`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tarif`
--
ALTER TABLE `tarif`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `kendaraan`
--
ALTER TABLE `kendaraan`
  ADD CONSTRAINT `fk_kendaraan_merek` FOREIGN KEY (`idmerek`) REFERENCES `merek` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ketidakleluasaan untuk tabel `tarif`
--
ALTER TABLE `tarif`
  ADD CONSTRAINT `fk_tarif_kendaraan1` FOREIGN KEY (`idkendaraan`) REFERENCES `kendaraan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `fk_sopir_has_kendaraan_kendaraan1` FOREIGN KEY (`idkendaraan`) REFERENCES `kendaraan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_sopir_has_kendaraan_sopir1` FOREIGN KEY (`idsopir`) REFERENCES `sopir` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_transaksi_pelanggan1` FOREIGN KEY (`idpelanggan`) REFERENCES `pelanggan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
