# Manual Testing Checklist - Explore Ormawa Undiksha

Dokumen ini digunakan untuk mencatat pengujian fungsional aplikasi Explore Ormawa Undiksha pada emulator atau perangkat Android.

## 1. Informasi Pengujian

- Nama aplikasi: Explore Ormawa Undiksha
- Platform: Android
- Framework: Flutter
- Backend: Supabase
- Penguji: Made Dwi Sulaksana
- NIM: 2415051047

## 2. Pengujian Navigasi dan Tampilan

| No. | Skenario Pengujian | Hasil yang Diharapkan | Status |
|---|---|---|---|
| 1 | Membuka halaman Home | Halaman Home tampil dengan informasi aplikasi | Belum dicatat |
| 2 | Membuka halaman Katalog | Daftar organisasi tampil | Belum dicatat |
| 3 | Memilih salah satu organisasi | Halaman detail menampilkan informasi organisasi yang dipilih | Belum dicatat |
| 4 | Membuka halaman Tersimpan | Daftar organisasi tersimpan tampil | Belum dicatat |
| 5 | Membuka halaman Profil | Informasi profil mahasiswa tampil | Belum dicatat |
| 6 | Berpindah melalui navigasi utama | Halaman tujuan terbuka sesuai menu yang dipilih | Belum dicatat |

## 3. Pengujian API dan Katalog

| No. | Skenario Pengujian | Hasil yang Diharapkan | Status |
|---|---|---|---|
| 1 | Memuat data katalog dari REST API | Data organisasi berhasil ditampilkan | Belum dicatat |
| 2 | Menjalankan pencarian organisasi | Daftar menyesuaikan kata kunci | Belum dicatat |
| 3 | Memilih filter kategori | Daftar menampilkan kategori yang dipilih | Belum dicatat |
| 4 | Melakukan refresh katalog | Aplikasi memuat ulang data | Belum dicatat |
| 5 | Menghadapi kegagalan API | Pesan kesalahan dan opsi mencoba kembali tampil | Belum dicatat |
| 6 | Mencari data yang tidak tersedia | Tampilan data kosong ditampilkan | Belum dicatat |

## 4. Pengujian CRUD Supabase

| No. | Skenario Pengujian | Hasil yang Diharapkan | Status |
|---|---|---|---|
| 1 | Menambahkan organisasi ke daftar tersimpan | Data baru tersimpan di Supabase | Belum dicatat |
| 2 | Membuka daftar tersimpan | Data sesuai mahasiswa ditampilkan | Belum dicatat |
| 3 | Mengubah divisi tujuan | Perubahan tersimpan di database | Belum dicatat |
| 4 | Mengubah catatan dan prioritas | Data terbaru ditampilkan | Belum dicatat |
| 5 | Menghapus data tersimpan | Data terhapus setelah konfirmasi | Belum dicatat |

## 5. Pengujian Form dan Validasi

| No. | Skenario Pengujian | Hasil yang Diharapkan | Status |
|---|---|---|---|
| 1 | Mengirim form tanpa mengisi kolom wajib | Validasi menampilkan pesan kesalahan | Belum dicatat |
| 2 | Mengisi form dengan data valid | Data dapat disimpan | Belum dicatat |
| 3 | Mengubah data melalui form edit | Perubahan dapat disimpan | Belum dicatat |
| 4 | Membatalkan atau kembali dari form | Aplikasi kembali tanpa menyimpan perubahan yang belum dikonfirmasi | Belum dicatat |

## 6. Pengujian Responsivitas

| No. | Skenario Pengujian | Hasil yang Diharapkan | Status |
|---|---|---|---|
| 1 | Menampilkan aplikasi pada layar ponsel | Komponen tampil rapi tanpa overflow | Belum dicatat |
| 2 | Menampilkan aplikasi pada layar lebih lebar | Tata letak menyesuaikan ukuran layar | Belum dicatat |
| 3 | Menampilkan katalog pada ukuran layar berbeda | Jumlah kolom menyesuaikan lebar layar | Belum dicatat |

## 7. Catatan Pengujian

Isi status setiap skenario berdasarkan hasil pengujian aktual:

- Berhasil: skenario berjalan sesuai hasil yang diharapkan.
- Gagal: skenario belum berjalan sesuai hasil yang diharapkan.
- Belum dicatat: skenario belum diperiksa atau hasilnya belum didokumentasikan.

Tambahkan tanggal pengujian, perangkat yang digunakan, dan catatan kendala jika diperlukan.
