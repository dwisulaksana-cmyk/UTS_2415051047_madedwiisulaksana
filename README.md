# Explore Ormawa Undiksha

Aplikasi mobile berbasis Flutter untuk eksplorasi katalog Organisasi Kemahasiswaan (BEM, MPM, HMJ, dan UKM) di lingkungan Universitas Pendidikan Ganesha (Undiksha) serta pengelolaan daftar minat pendaftaran mahasiswa.

## Identitas Mahasiswa
- **Nama:** Made Dwi Sulaksana
- **NIM:** 2415051047
- **Kelas:** PTI 5B
- **Mata Kuliah:** Pemrograman Mobile (UTS)

## Fitur Utama
1. **Katalog Ormawa (REST API GET):** Menampilkan daftar BEM, MPM, HMJ, dan UKM Undiksha secara dinamis dari endpoint Supabase REST API lengkap dengan fitur pencarian (*search*) dan penyaringan kategori (*filter*).
2. **Manajemen Daftar Minat (CRUD Backend Database):** Mahasiswa dapat menyimpan Ormawa yang diminati beserta divisi tujuan, tingkat prioritas (1–5), dan catatan motivasi, serta memperbarui atau menghapus data langsung pada database Supabase PostgreSQL.
3. **Detail Informasi Organisasi:** Menampilkan deskripsi lengkap, lingkup fakultas/universitas, visi kegiatan, media sosial resmi, dan status *open recruitment*.
4. **Responsive Layout (Compact & Wide):** Antarmuka adaptif menggunakan `LayoutBuilder` dan `MediaQuery` yang menyesuaikan susunan grid (1 kolom pada layar *compact* `< 600px` dan 2–3 kolom pada layar *wide* `≥ 600px`) serta navigasi (`NavigationBar` pada HP dan `NavigationRail` pada tablet/desktop).

## Arsitektur Aplikasi
Aplikasi menerapkan pemisahan tanggung jawab (*Separation of Concerns*) dengan alur data:
`UI (Screens & Widgets) → State Management (Provider) → Repository → Services (REST API & Supabase DB) → Models`

- `lib/models/`: Representasi model data (`OrmawaModel`, `SavedOrmawaModel`).
- `lib/services/`: Layer komunikasi eksternal (`OrmawaApiService` via `http`, `SavedOrmawaDbService` via `supabase_flutter`).
- `lib/repositories/`: Abstraksi sumber data (`OrmawaRepository`).
- `lib/providers/`: Manajemen state reaktif berbasis `ChangeNotifier` (`OrmawaProvider`, `SavedOrmawaProvider`).
- `lib/screens/`: 7 layar fungsional aplikasi (`HomeScreen`, `OrmawaListScreen`, `OrmawaDetailScreen`, `AddSavedOrmawaScreen`, `EditSavedOrmawaScreen`, `SavedOrmawaScreen`, `ProfileScreen`).
- `lib/widgets/`: Komponen UI modular dan responsif (`OrmawaCard`, `CategoryFilterChip`, `StateViewWidget`, `ResponsiveLayout`).

## Backend & REST API
- **Backend as a Service:** Supabase (PostgreSQL & PostgREST)
- **REST API Endpoint:** `https://mjjzkepqaiynjojxkufh.supabase.co/rest/v1/ormawa`
- **Database Table (CRUD):** `saved_ormawa`

## Cara Menjalankan Proyek
1. Clone repository ini:
   ```bash
   git clone [https://github.com/dwisulaksana-cmyk/UTS_2415051047_madedwiisulaksana.git](https://github.com/dwisulaksana-cmyk/UTS_2415051047_madedwiisulaksana.git)