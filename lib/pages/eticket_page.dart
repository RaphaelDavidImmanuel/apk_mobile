import 'package:flutter/material.dart';

import '../models/pemesanan.dart';
import '../utils/formatter.dart';
import 'main_navigation_page.dart';
import 'review_page.dart';

class ETicketPage extends StatefulWidget {
  final Pemesanan pesanan;

  const ETicketPage({
    super.key,
    required this.pesanan,
  });

  @override
  State<ETicketPage> createState() => _ETicketPageState();
}

class _ETicketPageState extends State<ETicketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F5F7),
      appBar: AppBar(
        title: const Text("E-Ticket"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/splash_logo.png",
                  width: 90,
                ),

                const SizedBox(height: 15),

                const Text(
                  "WISATAGO E-TICKET",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "PEMBAYARAN BERHASIL",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                const Divider(),

                const SizedBox(height: 10),

                tiketItem(
                  "Nama",
                  widget.pesanan.namaPemesan,
                ),

                tiketItem(
                  "Nomor HP",
                  widget.pesanan.nomorHp,
                ),

                tiketItem(
                  "Destinasi",
                  widget.pesanan.namaWisata,
                ),

                tiketItem(
                  "Tanggal",
                  widget.pesanan.tanggal,
                ),

                tiketItem(
                  "Jumlah Tiket",
                  "${widget.pesanan.jumlah} Tiket",
                ),

                const Divider(
                  height: 35,
                ),

                tiketItem(
                  "Subtotal",
                  Formatter.formatRupiah(
                    widget.pesanan.subtotal,
                  ),
                ),

                tiketItem(
                  "Diskon",
                  widget.pesanan.diskon == 0
                      ? "-"
                      : "- ${Formatter.formatRupiah(widget.pesanan.diskon)}",
                  valueColor:
                      widget.pesanan.diskon == 0 ? Colors.black : Colors.green,
                ),

                tiketItem(
                  "Total Bayar",
                  Formatter.formatRupiah(
                    widget.pesanan.total,
                  ),
                  valueColor: Colors.blue,
                  isTotal: true,
                ),

                const Divider(
                  height: 35,
                ),

                tiketItem(
                  "Kode Booking",
                  widget.pesanan.kodeBooking,
                ),

                tiketItem(
                  "Waktu Pesan",
                  widget.pesanan.waktuPesan,
                ),

                const SizedBox(height: 20),

                Image.asset(
                  "assets/images/qr_dummy.png",
                  width: 180,
                ),

                const SizedBox(height: 15),

                const Text(
                  "Tunjukkan QR Code ini kepada petugas saat memasuki lokasi wisata.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.receipt_long),
                    label: const Text(
                      "Lihat Riwayat Pesanan",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
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
                ),

                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainNavigationPage(
                          initialIndex: 0,
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.home_outlined),
                  label: const Text(
                    "Kembali ke Beranda",
                  ),
                ),

                const SizedBox(height: 15),

//================ REVIEW =================

                if (!widget.pesanan.sudahReview)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.star_rate),
                      label: const Text(
                        "Beri Rating & Review",
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReviewPage(
                              pesanan: widget.pesanan,
                            ),
                          ),
                        );

                        setState(() {});
                      },
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green.shade300,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Review Sudah Dikirim",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tiketItem(
    String title,
    String value, {
    bool isTotal = false,
    Color valueColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: valueColor,
                fontWeight: FontWeight.bold,
                fontSize: isTotal ? 19 : 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
