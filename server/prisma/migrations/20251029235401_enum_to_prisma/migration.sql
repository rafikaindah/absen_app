/*
  Warnings:

  - You are about to drop the `user` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE `user`;

-- CreateTable
CREATE TABLE `sekolah` (
    `id_sekolah` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_sekolah` VARCHAR(255) NOT NULL,
    `alamat` VARCHAR(191) NULL,
    `telepon` VARCHAR(20) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id_sekolah`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pengguna` (
    `id_pengguna` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_lengkap` VARCHAR(255) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password_hash` VARCHAR(255) NOT NULL,
    `peran` ENUM('ADMIN', 'GURU') NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `sekolahId` INTEGER NULL,

    UNIQUE INDEX `pengguna_email_key`(`email`),
    PRIMARY KEY (`id_pengguna`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `kelas` (
    `id_kelas` INTEGER NOT NULL AUTO_INCREMENT,
    `id_sekolah` INTEGER NOT NULL,
    `nama_kelas` VARCHAR(100) NOT NULL,
    `tingkat` VARCHAR(10) NULL,

    PRIMARY KEY (`id_kelas`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `siswa` (
    `id_siswa` INTEGER NOT NULL AUTO_INCREMENT,
    `id_kelas` INTEGER NULL,
    `nis` VARCHAR(50) NULL,
    `nama_lengkap` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id_siswa`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mata_pelajaran` (
    `id_mapel` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_mapel` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id_mapel`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pendaftaran_guru` (
    `id_pendaftaran` INTEGER NOT NULL AUTO_INCREMENT,
    `id_pengguna` INTEGER NOT NULL,
    `id_sekolah` INTEGER NOT NULL,

    PRIMARY KEY (`id_pendaftaran`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jadwal_mengajar` (
    `id_jadwal` INTEGER NOT NULL AUTO_INCREMENT,
    `id_pendaftaran` INTEGER NOT NULL,
    `id_kelas` INTEGER NOT NULL,
    `id_mapel` INTEGER NOT NULL,
    `id_sekolah` INTEGER NOT NULL,
    `hari` VARCHAR(191) NOT NULL,
    `jam_mulai` DATETIME(3) NOT NULL,
    `jam_selesai` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id_jadwal`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sesi_absensi_guru` (
    `id_sesi` INTEGER NOT NULL AUTO_INCREMENT,
    `id_pengguna` INTEGER NOT NULL,
    `id_sekolah` INTEGER NOT NULL,
    `waktu_masuk` DATETIME(3) NOT NULL,
    `waktu_pulang` DATETIME(3) NULL,
    `tanggal` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id_sesi`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `absensi_siswa` (
    `id_absensi_siswa` INTEGER NOT NULL AUTO_INCREMENT,
    `id_sesi_guru` INTEGER NOT NULL,
    `id_siswa` INTEGER NOT NULL,
    `id_jadwal` INTEGER NOT NULL,
    `status` ENUM('HADIR', 'SAKIT', 'IZIN', 'ALPA') NOT NULL,
    `tanggal` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id_absensi_siswa`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jurnal_mengajar` (
    `id_jurnal` INTEGER NOT NULL AUTO_INCREMENT,
    `id_sesi_guru` INTEGER NOT NULL,
    `id_jadwal` INTEGER NOT NULL,
    `materi_diajarkan` VARCHAR(191) NULL,
    `catatan_kegiatan` VARCHAR(191) NULL,
    `timestamp` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id_jurnal`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `catatan_siswa` (
    `id_catatan` INTEGER NOT NULL AUTO_INCREMENT,
    `id_sesi_guru` INTEGER NOT NULL,
    `id_siswa` INTEGER NOT NULL,
    `jenis_catatan` VARCHAR(191) NOT NULL,
    `deskripsi` VARCHAR(191) NULL,
    `timestamp` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id_catatan`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `pengguna` ADD CONSTRAINT `pengguna_sekolahId_fkey` FOREIGN KEY (`sekolahId`) REFERENCES `sekolah`(`id_sekolah`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `kelas` ADD CONSTRAINT `kelas_id_sekolah_fkey` FOREIGN KEY (`id_sekolah`) REFERENCES `sekolah`(`id_sekolah`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `siswa` ADD CONSTRAINT `siswa_id_kelas_fkey` FOREIGN KEY (`id_kelas`) REFERENCES `kelas`(`id_kelas`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pendaftaran_guru` ADD CONSTRAINT `pendaftaran_guru_id_pengguna_fkey` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna`(`id_pengguna`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pendaftaran_guru` ADD CONSTRAINT `pendaftaran_guru_id_sekolah_fkey` FOREIGN KEY (`id_sekolah`) REFERENCES `sekolah`(`id_sekolah`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `jadwal_mengajar` ADD CONSTRAINT `jadwal_mengajar_id_pendaftaran_fkey` FOREIGN KEY (`id_pendaftaran`) REFERENCES `pendaftaran_guru`(`id_pendaftaran`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `jadwal_mengajar` ADD CONSTRAINT `jadwal_mengajar_id_kelas_fkey` FOREIGN KEY (`id_kelas`) REFERENCES `kelas`(`id_kelas`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `jadwal_mengajar` ADD CONSTRAINT `jadwal_mengajar_id_mapel_fkey` FOREIGN KEY (`id_mapel`) REFERENCES `mata_pelajaran`(`id_mapel`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `jadwal_mengajar` ADD CONSTRAINT `jadwal_mengajar_id_sekolah_fkey` FOREIGN KEY (`id_sekolah`) REFERENCES `sekolah`(`id_sekolah`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sesi_absensi_guru` ADD CONSTRAINT `sesi_absensi_guru_id_pengguna_fkey` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna`(`id_pengguna`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sesi_absensi_guru` ADD CONSTRAINT `sesi_absensi_guru_id_sekolah_fkey` FOREIGN KEY (`id_sekolah`) REFERENCES `sekolah`(`id_sekolah`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `absensi_siswa` ADD CONSTRAINT `absensi_siswa_id_sesi_guru_fkey` FOREIGN KEY (`id_sesi_guru`) REFERENCES `sesi_absensi_guru`(`id_sesi`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `absensi_siswa` ADD CONSTRAINT `absensi_siswa_id_siswa_fkey` FOREIGN KEY (`id_siswa`) REFERENCES `siswa`(`id_siswa`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `absensi_siswa` ADD CONSTRAINT `absensi_siswa_id_jadwal_fkey` FOREIGN KEY (`id_jadwal`) REFERENCES `jadwal_mengajar`(`id_jadwal`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `jurnal_mengajar` ADD CONSTRAINT `jurnal_mengajar_id_sesi_guru_fkey` FOREIGN KEY (`id_sesi_guru`) REFERENCES `sesi_absensi_guru`(`id_sesi`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `jurnal_mengajar` ADD CONSTRAINT `jurnal_mengajar_id_jadwal_fkey` FOREIGN KEY (`id_jadwal`) REFERENCES `jadwal_mengajar`(`id_jadwal`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `catatan_siswa` ADD CONSTRAINT `catatan_siswa_id_sesi_guru_fkey` FOREIGN KEY (`id_sesi_guru`) REFERENCES `sesi_absensi_guru`(`id_sesi`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `catatan_siswa` ADD CONSTRAINT `catatan_siswa_id_siswa_fkey` FOREIGN KEY (`id_siswa`) REFERENCES `siswa`(`id_siswa`) ON DELETE CASCADE ON UPDATE CASCADE;
