import 'package:flutter/material.dart';

import '../data/pemesanan_data.dart';

class PesananPage extends StatelessWidget {
  const PesananPage({super.key});

  String formatRupiah(int angka) {
    String hasil = angka.toString();

    RegExp reg = RegExp(r'(\d+)(\d{3})');

    while (reg.hasMatch(hasil)) {
      hasil = hasil.replaceAllMapped(
        reg,
        (Match m) => "${m[1]}.${m[2]}",
      );
    }

    return "Rp $hasil";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Pesanan"),
        centerTitle: true,
      ),
      body: daftarPemesanan.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/empty.png",
                      width: 220,
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Belum Ada Pesanan",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Silakan lakukan pemesanan tiket wisata terlebih dahulu.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: daftarPemesanan.length,
              itemBuilder: (context, index) {
                final pesanan = daftarPemesanan[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 18),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.place,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pesanan.namaWisata,
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    pesanan.tanggal,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                              ),
                              child: const Text(
                                "LUNAS",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        infoRow(
                          "Nama",
                          pesanan.namaPemesan,
                        ),
                        infoRow(
                          "No HP",
                          pesanan.nomorHp,
                        ),
                        infoRow(
                          "Jumlah Tiket",
                          "${pesanan.jumlah}",
                        ),
                        infoRow(
                          "Total Bayar",
                          formatRupiah(
                            pesanan.total,
                          ),
                        ),
                        const Divider(),
                        Row(
                          children: const [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Tiket Siap Digunakan",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
