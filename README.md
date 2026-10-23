# Resep Makanan

## Deskripsi Singkat
Resep Makanan adalah aplikasi mobile berbasis Flutter untuk melihat dan mencari resep masakan. Data resep diambil secara langsung (dinamis) dari API publik [TheMealDB](https://www.themealdb.com/api.php), mulai dari nama masakan, foto, kategori, asal negara, daftar bahan, hingga langkah memasak.

Aplikasi ini dibuat sebagai tugas Ujian Tengah Semester (UTS) mata kuliah Pemrograman Mobile.

## Fitur Utama
- **Halaman Home**: menampilkan daftar *Featured recipes* (geser horizontal) dan satu resep *Recommended* yang dipilih acak setiap aplikasi dibuka.
- **Halaman Pencarian**: mencari resep berdasarkan nama masakan dan menampilkan hasilnya dalam bentuk grid beserta jumlah resep yang ditemukan.
- **Halaman Detail**: menampilkan foto, kategori, asal negara, jumlah bahan, daftar bahan beserta takarannya, dan langkah-langkah memasak.
- **Penanganan kondisi data**: menggunakan `FutureBuilder` untuk menampilkan kondisi *loading* (indikator berputar), *success* (data tampil), dan *error* (pesan kesalahan).

## Teknologi dan Package
| Teknologi / Package | Kegunaan |
|---|---|
| Flutter | Framework pembuatan aplikasi mobile |
| Dart | Bahasa pemrograman |
| [`http`](https://pub.dev/packages/http) | Mengirim permintaan HTTP ke API TheMealDB |
| [TheMealDB API](https://www.themealdb.com/api.php) | Sumber data resep |

## Struktur Folder
```
lib/
├── main.dart                  # Titik awal aplikasi
├── constants.dart             # Warna utama aplikasi
├── models/
│   └── meal.dart              # Class model (JSON -> objek Dart)
├── services/
│   └── api_service.dart       # Permintaan HTTP ke API
├── pages/
│   ├── home_page.dart         # Halaman Home
│   ├── search_page.dart       # Halaman Pencarian
│   └── detail_page.dart       # Halaman Detail
└── widgets/
    └── meal_card.dart         # Kartu resep (dipakai ulang)
```

## Langkah Menjalankan Aplikasi

### 1. Persiapan (hanya sekali)
Pastikan perangkat sudah memiliki:
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Git](https://git-scm.com/downloads)
- [Android Studio](https://developer.android.com/studio) (beserta Android SDK dan plugin Flutter & Dart)

Cek bahwa instalasi sudah benar dengan menjalankan perintah berikut di terminal, lalu pastikan tidak ada tanda silang (X) pada bagian Flutter dan Android toolchain:
```bash
flutter doctor
```

### 2. Ambil project dari GitHub
```bash
git clone https://github.com/naylafarhani01-blip/uts_mobile.git
cd uts_mobile
```


### 3. Pasang dependensi
```bash
flutter pub get
```

### 4. Siapkan emulator Android
1. Buka **Android Studio**.
2. Pilih **More Actions -> Virtual Device Manager** (atau menu **Tools -> Device Manager**).
3. Klik **Create Device**, pilih perangkat (misalnya *Pixel 6*), lalu klik **Next**.
4. Pilih sistem image Android (misalnya versi terbaru), klik **Download** jika belum ada, lalu **Next -> Finish**.
5. Klik tombol **Play** pada emulator yang baru dibuat dan tunggu sampai layar HP virtual muncul.

### 5. Jalankan aplikasi
Pastikan komputer terhubung ke internet (aplikasi mengambil data dari API), lalu cek emulator sudah terdeteksi:
```bash
flutter devices
```
Jalankan aplikasi:
```bash
flutter run
```
Kalau ada lebih dari satu perangkat, pilih emulator Android dari daftar yang muncul, atau tentukan langsung dengan `flutter run -d <id-perangkat>`.

Proses *build* pertama bisa memakan waktu beberapa menit. Setelah selesai, aplikasi akan terpasang dan terbuka otomatis di emulator.

### Alternatif: lewat Android Studio
1. Pilih **File -> Open**, lalu buka folder project.
2. Tunggu proses *indexing* selesai, lalu klik **Pub get** jika muncul.
3. Pilih emulator pada daftar perangkat di toolbar atas.
4. Klik tombol **Run** (ikon segitiga hijau) atau tekan `Shift + F10`.

### Menjalankan di HP fisik (opsional)
1. Aktifkan **Developer options** dan **USB debugging** di HP, lalu hubungkan ke komputer dengan kabel USB.
2. Jalankan `flutter devices` untuk memastikan HP terdeteksi, lalu `flutter run`.

## Catatan
- Aplikasi membutuhkan koneksi internet. Izin internet sudah ditambahkan di `android/app/src/main/AndroidManifest.xml`.
- Disarankan menjalankan di emulator atau HP Android. Jika dijalankan di Chrome (web), gambar bisa gagal dimuat karena pembatasan CORS pada browser.

## Sumber Data
Data resep disediakan oleh [TheMealDB](https://www.themealdb.com/).
