
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 1. MODEL BUKU
class Buku {
  final String judul, penulis, kategori;
  final int jumlahHalaman, stok;
  final IconData ikon;
  final Color warna;
// moh naufal demas hartono_202432013
  const Buku({
    required this.judul,
    required this.penulis,
    required this.kategori,
    required this.jumlahHalaman,
    required this.stok,
    required this.ikon,
    required this.warna,
  });
}

// 2. DATA BUKU
const daftarBuku = [
  Buku(
    judul: 'Laskar Pelangi',
    penulis: 'Andrea Hirata',
    kategori: 'Novel Indonesia',
    jumlahHalaman: 529,
    stok: 5,
    ikon: Icons.menu_book,
    warna: Color(0xFFE4F1E8),
  ),
  // moh naufal demas hartono_202432013
  Buku(
    judul: 'Atomic Habits',
    penulis: 'James Clear',
    kategori: 'Pengembangan Diri',
    jumlahHalaman: 320,
    stok: 3,
    ikon: Icons.auto_stories,
    warna: Color(0xFFFFF0D5),
  ),
  Buku(
    judul: 'Bumi',
    penulis: 'Tere Liye',
    kategori: 'Fantasi',
    jumlahHalaman: 440,
    stok: 4,
    ikon: Icons.book,
    warna: Color(0xFFFBE4EA),
  ),
  Buku(
    judul: 'The Great Gatsby',
    penulis: 'F. Scott Fitzgerald',
    kategori: 'Novel Klasik',
    jumlahHalaman: 180,
    stok: 0,
    ikon: Icons.library_books,
    warna: Color(0xFFE6EBFF),
  ),
];
// moh naufal demas hartono
// 3. MY APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Katalog Perpustakaan',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF087F5B),
          ),
          scaffoldBackgroundColor: const Color(0xFFF4F7F0),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF087F5B),
            foregroundColor: Colors.white,
          ),
        ),
        home: const HalamanUtama(),
      );
}
// moh naufal demas hartono
// 4. HALAMAN UTAMA
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  final Set<String> bukuFavorit = {};
  bool tampilFavoritSaja = false;

  void toggleFavorit(Buku buku) {
    setState(() {
      if (!bukuFavorit.add(buku.judul)) {
        bukuFavorit.remove(buku.judul);
      }
    });
  }

  void ubahFilter(bool favorit) {
    setState(() => tampilFavoritSaja = favorit);
  }
// moh naufal demas hartono
  void tampilkanDetail(Buku buku) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(buku.judul),
        content: Text(
          'Penulis: ${buku.penulis}\n'
          'Kategori: ${buku.kategori}\n'
          'Jumlah halaman: ${buku.jumlahHalaman}\n'
          'Stok: ${buku.stok} buku\n'
          'Status: ${buku.stok > 0 ? "Tersedia" : "Sedang dipinjam / habis"}\n'
          'Favorit: ${bukuFavorit.contains(buku.judul) ? "Ya" : "Tidak"}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
// moh naufal demas hartono 202432013
  @override
  Widget build(BuildContext context) {
    final bukuDitampilkan = daftarBuku
        .where((b) =>
            !tampilFavoritSaja || bukuFavorit.contains(b.judul))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Katalog Perpustakaan',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: const [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 12),
              child: Text(
                'moh naufal demas hartono',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.local_library),
          ),
        ],
        // moh naufal demas hartono 202432013
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BANNER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF087F5B), Color(0xFF42A884)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                //moh naufal demas hartono 202432013
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.local_library, color: Colors.white, size: 36),
                    SizedBox(height: 12),
                    Text(
                      'Temukan Dunia dalam Buku',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Jelajahi koleksi buku dan temukan bacaan '
                      'favoritmu di perpustakaan.',
                      style: TextStyle(color: Colors.white, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // JUDUL KATALOG
              const Text(
                'Koleksi Buku',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF214D3B),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${daftarBuku.length} buku dalam katalog',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 16),
              //moh naufal demas hartono_202432013

              // FILTER
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFDCE8DE)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: tombolFilter(
                        'Semua Buku',
                        Icons.grid_view,
                        !tampilFavoritSaja,
                        () => ubahFilter(false),
                      ),
                    ),
                    Expanded(
                      child: tombolFilter(
                        'Favorit (${bukuFavorit.length})',
                        Icons.favorite,
                        tampilFavoritSaja,
                        () => ubahFilter(true),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
                //moh naufal demas hartono _202432013

              // DAFTAR BUKU
              if (bukuDitampilkan.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.favorite_border,
                          size: 55, color: Color(0xFF087F5B)),
                      SizedBox(height: 12),
                      Text(
                        'Belum Ada Buku Favorit',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Tekan ikon hati pada buku untuk '
                        'menambahkannya ke daftar favorit.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                ...bukuDitampilkan.map(
                  (buku) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: KartuBuku(
                      buku: buku,
                      isFavorite: bukuFavorit.contains(buku.judul),
                      onFavoritePressed: () => toggleFavorit(buku),
                      onDetailPressed: () => tampilkanDetail(buku),
                    ),
                  ),
                ),
                // moh naufal demas hartono_202432013
              const SizedBox(height: 4),
              const RingkasanPerpustakaan(),
              const SizedBox(height: 18),

              // TOMBOL FAVORIT
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final nilaiBaru = !tampilFavoritSaja;
                    ubahFilter(nilaiBaru);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          nilaiBaru
                              ? 'Menampilkan buku favorit'
                              : 'Menampilkan semua buku',
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    tampilFavoritSaja ? Icons.grid_view : Icons.favorite,
                  ),
                  label: Text(
                    tampilFavoritSaja
                        ? 'Lihat Semua Buku'
                        : 'Lihat Favorit (${bukuFavorit.length})',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF087F5B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
// moh naufal demas hartono-202432013

  // WIDGET TOMBOL FILTER
  Widget tombolFilter(
    String judul,
    IconData ikon,
    bool aktif,
    VoidCallback onTap,
  ) {
    return Material(
      color: aktif ? const Color(0xFF087F5B) : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(ikon,
                  size: 18,
                  color: aktif ? Colors.white : Colors.grey.shade700),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  judul,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: aktif ? Colors.white : Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// moh naufal demas hartono

// 5. KARTU BUKU
class KartuBuku extends StatelessWidget {
  final Buku buku;
  final bool isFavorite;
  final VoidCallback onFavoritePressed, onDetailPressed;

  const KartuBuku({
    super.key,
    required this.buku,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onDetailPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GAMBAR BUKU DAN TOMBOL FAVORIT
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: buku.warna,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    buku.ikon,
                    size: 70,
                    color: const Color(0xFF087F5B),
                  ),
                ),
                // moh naufal demas hartono_202432013
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    elevation: 2,
                    child: InkWell(
                      onTap: onFavoritePressed,
                      customBorder: const CircleBorder(),
                      child: SizedBox(
                        width: 42,
                        height: 42,
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite
                              ? Colors.red
                              : const Color(0xFF087F5B),
                          size: 23,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              buku.judul,
              style: const TextStyle(
                  fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Penulis: ${buku.penulis}',
                style: TextStyle(color: Colors.grey.shade700)),
            const SizedBox(height: 6),
                //moh naufal demas hartono-202432013

            // KATEGORI
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: buku.warna,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                buku.kategori,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF214D3B),
                ),
              ),
            ),
            const SizedBox(height: 12),
// moh naufal demas hartono-202432013

            // HALAMAN DAN STOK
            Row(
              children: [
                const Icon(Icons.menu_book,
                    size: 19, color: Color(0xFF087F5B)),
                const SizedBox(width: 6),
                Expanded(child: Text('${buku.jumlahHalaman} halaman')),
                Icon(
                  buku.stok > 0 ? Icons.check_circle : Icons.cancel,
                  size: 18,
                  color: buku.stok > 0 ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    buku.stok > 0 ? 'Tersedia (${buku.stok})' : 'Dipinjam',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onDetailPressed,
                child: const Text('Lihat Detail'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//moh naufal demas hartono-202432013

// 6. TIPS PERPUSTAKAAN
class RingkasanPerpustakaan extends StatelessWidget {
  const RingkasanPerpustakaan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4D6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9C46A)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline,
              color: Color(0xFF8A6414), size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tips Perpustakaan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF684B0F),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Jaga kebersihan buku, hindari melipat halaman, '
                  'dan kembalikan buku tepat waktu. Pilih bacaan '
                  'sesuai minat agar kegiatan membaca semakin '
                  'menyenangkan.',
                  style: TextStyle(height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// moh naufal demas hartono -202432013
