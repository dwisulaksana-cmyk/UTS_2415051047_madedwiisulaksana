# Explore Ormawa Undiksha

Aplikasi mobile berbasis Flutter untuk membantu mahasiswa mengeksplorasi organisasi kemahasiswaan di lingkungan Universitas Pendidikan Ganesha (Undiksha). Aplikasi ini menyediakan katalog organisasi, informasi detail, serta fitur pengelolaan daftar organisasi yang diminati mahasiswa.

## Identitas Mahasiswa

- **Nama:** Made Dwi Sulaksana
- **NIM:** 2415051047
- **Kelas:** PTI 5B
- **Program Studi:** Pendidikan Teknik Informatika
- **Mata Kuliah:** Pemrograman Mobile (UTS)
- **Universitas:** Universitas Pendidikan Ganesha

## Fitur Utama

1. **Beranda:** Menampilkan halaman utama dan ringkasan informasi organisasi.
2. **Katalog Ormawa:** Mengambil data organisasi secara dinamis melalui REST API Supabase.
3. **Pencarian dan Filter:** Memudahkan pencarian organisasi berdasarkan nama, singkatan, fakultas, dan kategori.
4. **Detail Organisasi:** Menampilkan informasi organisasi, deskripsi, visi, fakultas, media sosial, dan status open recruitment.
5. **Daftar Ormawa Tersimpan:** Menampilkan organisasi yang diminati mahasiswa.
6. **Tambah dan Edit Data:** Menyimpan serta memperbarui pilihan organisasi, divisi tujuan, prioritas, dan catatan.
7. **Hapus Data:** Menghapus data organisasi dari daftar minat dengan konfirmasi.
8. **Profil Mahasiswa:** Menampilkan informasi profil mahasiswa.
9. **Responsive Layout:** Menyesuaikan tampilan dan navigasi pada perangkat dengan ukuran layar berbeda.
10. **State Management:** Mengelola data, proses loading, dan pesan kesalahan menggunakan Provider.

## Teknologi yang Digunakan

| Teknologi | Kegunaan |
|---|---|
| Flutter | Framework pengembangan aplikasi |
| Dart | Bahasa pemrograman |
| Provider | State management |
| HTTP | Komunikasi dengan REST API |
| Supabase | Backend dan database PostgreSQL |
| flutter_dotenv | Pengelolaan konfigurasi environment |

## Arsitektur Aplikasi

Aplikasi menggunakan pemisahan tanggung jawab (*Separation of Concerns*) agar kode lebih terstruktur dan mudah dikembangkan.

Alur pengelolaan data:

`UI (Screens & Widgets) -> Provider -> Repository -> Services -> REST API / Supabase Database`

Struktur direktori utama:

```text
lib/
├── constants/
│   └── app_constants.dart
├── models/
│   ├── ormawa_model.dart
│   └── saved_ormawa_model.dart
├── providers/
│   ├── ormawa_provider.dart
│   └── saved_ormawa_provider.dart
├── repositories/
│   └── ormawa_repository.dart
├── screens/
│   ├── home_screen.dart
│   ├── main_navigation_screen.dart
│   ├── ormawa_list_screen.dart
│   ├── ormawa_detail_screen.dart
│   ├── add_saved_ormawa_screen.dart
│   ├── edit_saved_ormawa_screen.dart
│   ├── saved_ormawa_screen.dart
│   └── profile_screen.dart
├── services/
│   ├── ormawa_api_service.dart
│   └── saved_ormawa_db_service.dart
└── widgets/
    ├── category_filter_chip.dart
    ├── ormawa_card.dart
    ├── responsive_layout.dart
    └── state_view_widget.dart
```

## Backend dan Database

Aplikasi menggunakan Supabase sebagai layanan backend.

- **Backend:** Supabase
- **Database:** PostgreSQL
- **REST API:** Supabase REST API (PostgREST)
- **Endpoint katalog:** `https://mjjzkepqaiynjojxkufh.supabase.co/rest/v1/ormawa`
- **Tabel katalog:** `ormawa`
- **Tabel data tersimpan:** `saved_ormawa`

Operasi data pada tabel `saved_ormawa` meliputi:

- **Create:** Menambahkan organisasi ke daftar minat.
- **Read:** Mengambil daftar organisasi yang tersimpan.
- **Update:** Memperbarui informasi organisasi tersimpan.
- **Delete:** Menghapus organisasi dari daftar minat.

## Responsive Design

Tampilan aplikasi menyesuaikan ukuran layar perangkat.

- **Compact:** Menggunakan navigasi bawah (`NavigationBar`) dan tampilan katalog yang menyesuaikan layar ponsel.
- **Wide:** Menggunakan navigasi samping (`NavigationRail`) dan susunan katalog berbentuk grid.

## Persyaratan Sistem

- Flutter SDK yang sesuai dengan batas versi pada `pubspec.yaml`.
- Dart SDK versi `3.13.2` atau yang kompatibel.
- Android Studio atau Visual Studio Code.
- Emulator Android atau perangkat Android.
- Koneksi internet untuk mengakses layanan Supabase.

## Cara Menjalankan Proyek

### 1. Clone Repository

```bash
git clone https://github.com/dwisulaksana-cmyk/UTS_2415051047_madedwiisulaksana.git
```

### 2. Masuk ke Direktori Proyek

```bash
cd UTS_2415051047_madedwiisulaksana
```

### 3. Instal Dependensi

```bash
flutter pub get
```

### 4. Konfigurasi Environment

Buat file `.env` pada direktori utama proyek dengan konfigurasi berikut:

```env
SUPABASE_URL=https://mjjzkepqaiynjojxkufh.supabase.co
SUPABASE_ANON_KEY=MASUKKAN_SUPABASE_ANON_KEY
```

Ganti `MASUKKAN_SUPABASE_ANON_KEY` dengan anon key atau publishable key milik proyek Supabase yang digunakan.

**Penting:** Jangan mengunggah file `.env` atau secret key ke repository publik. Jangan pernah menggunakan `service_role` key pada aplikasi Flutter.

### 5. Jalankan Aplikasi

```bash
flutter run
```

## Pemeriksaan Kode

Untuk memeriksa kemungkinan kesalahan dan peringatan pada kode:

```bash
flutter analyze
```

## Repository

Source code aplikasi dapat diakses melalui:

[GitHub - Explore Ormawa Undiksha](https://github.com/dwisulaksana-cmyk/UTS_2415051047_madedwiisulaksana)
