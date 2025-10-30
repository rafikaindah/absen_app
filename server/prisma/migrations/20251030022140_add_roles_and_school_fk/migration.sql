/*
  Warnings:

  - The values [ADMIN] on the enum `pengguna_peran` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterTable
ALTER TABLE `pengguna` MODIFY `peran` ENUM('SUPER_ADMIN', 'ADMIN_SEKOLAH', 'GURU') NOT NULL;
