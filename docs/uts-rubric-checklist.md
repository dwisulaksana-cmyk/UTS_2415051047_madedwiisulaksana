# UTS Rubric Checklist - Explore Ormawa Undiksha

Dokumen ini memetakan persyaratan Ujian Tengah Semester (UTS) Pemrograman Mobile dengan implementasi pada aplikasi Explore Ormawa Undiksha.

## 1. Identitas Proyek

- Nama aplikasi: Explore Ormawa Undiksha
- Nama mahasiswa: Made Dwi Sulaksana
- NIM: 2415051047
- Program studi: Pendidikan Teknik Informatika
- Kelas: PTI 5B
- Framework: Flutter
- Backend: Supabase

## 2. Pemetaan Persyaratan dan Implementasi

| No. | Persyaratan | Implementasi | Lokasi Kode |
|---|---|---|---|
| 1 | Minimal enam layar fungsional | Home, katalog, detail, tambah, edit, tersimpan, dan profil | `lib/screens/` |
| 2 | Navigasi antarhalaman | Navigasi utama menggunakan NavigationBar dan NavigationRail | `lib/screens/main_navigation_screen.dart` |
| 3 | Pengiriman data antarhalaman | Data organisasi diteruskan ke halaman detail | `lib/screens/ormawa_list_screen.dart` |
| 4 | Penggunaan ListView atau GridView | Katalog organisasi ditampilkan dengan tata letak daftar/grid | `lib/screens/ormawa_list_screen.dart` |
| 5 | Komponen yang dapat digunakan kembali | Widget kartu, filter kategori, layout responsif, dan tampilan status | `lib/widgets/` |
| 6 | Tampilan responsif | Layout menyesuaikan lebar layar | `lib/widgets/responsive_layout.dart` |
| 7 | Integrasi REST API | Mengambil katalog organisasi dari Supabase REST API | `lib/services/ormawa_api_service.dart` |
| 8 | Konversi JSON ke model Dart | Data katalog dipetakan ke model organisasi | `lib/models/ormawa_model.dart` |
| 9 | Integrasi database | Data organisasi tersimpan dikelola melalui Supabase | `lib/services/saved_ormawa_db_service.dart` |
| 10 | Operasi CRUD | Tambah, baca, ubah, dan hapus data organisasi tersimpan | `lib/providers/saved_ormawa_provider.dart` |
| 11 | State management | Provider dan ChangeNotifier untuk mengelola state aplikasi | `lib/providers/` |
| 12 | Pemisahan arsitektur | Model, service, repository, provider, screen, dan widget dipisahkan | `lib/` |
| 13 | Validasi form | Form tambah dan edit memiliki validasi input | `lib/screens/add_saved_ormawa_screen.dart`, `lib/screens/edit_saved_ormawa_screen.dart` |
| 14 | Loading, error, dan empty state | Tampilan kondisi pemuatan, kesalahan, dan data kosong | `lib/widgets/state_view_widget.dart` |
| 15 | Konfigurasi environment | Kredensial Supabase dibaca dari file `.env` | `lib/main.dart` |
| 16 | Dokumentasi proyek | README berisi identitas, fitur, teknologi, arsitektur, dan petunjuk penggunaan | `README.md` |
| 17 | Dokumentasi database | Struktur tabel dan operasi CRUD dijelaskan | `docs/database-schema.md` |
| 18 | Dokumentasi pengujian | Skenario pengujian manual tersedia | `docs/manual-testing-checklist.md` |
| 19 | Version control | Proyek dikelola menggunakan Git dan GitHub | Repository GitHub |

## 3. Struktur Arsitektur

Alur pengelolaan data aplikasi:

1. Screen menerima interaksi pengguna.
2. Provider mengelola state dan memanggil repository atau service.
3. Repository mengelola akses data katalog.
4. Service berkomunikasi dengan REST API atau Supabase.
5. Model mengubah data JSON menjadi objek Dart.
6. Provider memperbarui state agar UI menampilkan data terbaru.

## 4. Daftar File Utama

- `lib/models/`: model data aplikasi.
- `lib/services/`: komunikasi API dan database.
- `lib/repositories/`: pengelolaan akses data.
- `lib/providers/`: state management.
- `lib/screens/`: halaman aplikasi.
- `lib/widgets/`: komponen UI yang dapat digunakan kembali.
- `lib/constants/`: konstanta aplikasi.
- `docs/`: dokumentasi pendukung proyek.

## 5. Catatan Verifikasi

Dokumen ini merupakan pemetaan implementasi berdasarkan struktur dan kode proyek. Status akhir setiap persyaratan tetap perlu dicocokkan dengan rubrik resmi dosen, demonstrasi aplikasi, dan bukti pengujian.

Checklist pengujian manual tersedia pada `docs/manual-testing-checklist.md`. Isi status pengujian berdasarkan hasil aktual dan lengkapi dengan tangkapan layar jika diperlukan.
