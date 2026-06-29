import 'package:flutter/material.dart';

import '../data/pemesanan_data.dart';
import '../models/pemesanan.dart';
import '../utils/formatter.dart';
import 'eticket_page.dart';

class PesananPage extends StatelessWidget {
  const PesananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Riwayat Pesanan"),
        centerTitle: true,
      ),
      body: daftarPemesanan.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
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
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: daftarPemesanan.length,
              itemBuilder: (context, index) {
                final Pemesanan pesanan =
                    daftarPemesanan[daftarPemesanan.length - 1 - index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 18),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.confirmation_num,
                                color: Colors.blue,
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    pesanan.tanggal,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    pesanan.waktuPesan,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
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
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "LUNAS",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 12),
                        infoRow(
                          "Nama Pemesan",
                          pesanan.namaPemesan,
                        ),
                        infoRow(
                          "Nomor HP",
                          pesanan.nomorHp,
                        ),
                        infoRow(
                          "Jumlah Tiket",
                          "${pesanan.jumlah} Tiket",
                        ),
                        infoRow(
                          "Subtotal",
                          Formatter.formatRupiah(
                            pesanan.subtotal,
                          ),
                        ),
                        infoRow(
                          "Diskon",
                          pesanan.diskon == 0
                              ? "-"
                              : "- ${Formatter.formatRupiah(pesanan.diskon)}",
                          valueColor:
                              pesanan.diskon == 0 ? Colors.black : Colors.green,
                        ),
                        const Divider(),
                        infoRow(
                          "Total Bayar",
                          Formatter.formatRupiah(
                            pesanan.total,
                          ),
                          isTotal: true,
                          valueColor: Colors.blue,
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ETicketPage(
                                    pesanan: pesanan,
                                  ),
                                ),
                              );
                            },
                            // icon: const Icon(Icons.receipt_long),
                            label: const Text(
                              "Lihat E-Ticket",
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget infoRow(
    String title,
    String value, {
    bool isTotal = false,
    Color valueColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: isTotal ? 17 : 15,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 15,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
