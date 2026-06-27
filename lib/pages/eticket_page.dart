import 'dart:math';

import 'package:flutter/material.dart';

import '../models/pemesanan.dart';
import 'main_navigation_page.dart';

class ETicketPage extends StatelessWidget {
  final Pemesanan pesanan;

  const ETicketPage({
    super.key,
    required this.pesanan,
  });

  @override
  Widget build(BuildContext context) {
    final kodeBooking = "WG${100000 + Random().nextInt(900000)}";

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("E-Ticket"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/splash_logo.png",
                      width: 80,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "WISATAGO E-TICKET",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "✔ LUNAS",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Divider(),
                    tiketItem(
                      "Nama",
                      pesanan.namaPemesan,
                    ),
                    tiketItem(
                      "Nomor HP",
                      pesanan.nomorHp,
                    ),
                    tiketItem(
                      "Destinasi",
                      pesanan.namaWisata,
                    ),
                    tiketItem(
                      "Tanggal",
                      pesanan.tanggal,
                    ),
                    tiketItem(
                      "Jumlah Tiket",
                      "${pesanan.jumlah} Tiket",
                    ),
                    tiketItem(
                      "Total Bayar",
                      "Rp ${pesanan.total}",
                    ),
                    tiketItem(
                      "Kode Booking",
                      kodeBooking,
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 15),
                    Image.asset(
                      "assets/images/qr_dummy.png",
                      width: 180,
                      height: 180,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Tunjukkan QR Code ini saat memasuki lokasi wisata.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.home),
                        label: const Text(
                          "Kembali ke Home",
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MainNavigationPage(
                                initialIndex: 2,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tiketItem(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
