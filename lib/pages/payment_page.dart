import 'dart:math';

import 'package:flutter/material.dart';

import '../models/pemesanan.dart';
import '../models/wisata.dart';
import '../utils/formatter.dart';
import 'eticket_page.dart';

class PaymentPage extends StatefulWidget {
  final Pemesanan pesanan;
  final Wisata wisata;

  const PaymentPage({
    super.key,
    required this.pesanan,
    required this.wisata,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String metode = "BCA";

  String generateVA() {
    return "8808${100000000 + Random().nextInt(900000000)}";
  }

  String generateKode() {
    return "IND${100000 + Random().nextInt(900000)}";
  }

  late String nomorVA;
  late String kodeMinimarket;

  @override
  void initState() {
    super.initState();

    nomorVA = generateVA();
    kodeMinimarket = generateKode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Pembayaran"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Text(
                      "Total Pembayaran",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      Formatter.formatRupiah(widget.pesanan.total),
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // ==========================
                    // STATUS PEMBAYARAN
                    // ==========================

                    const SizedBox(height: 20),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.orange,
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status Pembayaran",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "Menunggu Pembayaran",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Pilih Metode Pembayaran",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            RadioListTile(
              value: "BCA",
              groupValue: metode,
              title: const Text("BCA Virtual Account"),
              secondary: const Icon(Icons.account_balance),
              onChanged: (value) {
                setState(() {
                  metode = value!;
                });
              },
            ),
            RadioListTile(
              value: "Mandiri",
              groupValue: metode,
              title: const Text("Mandiri Virtual Account"),
              secondary: const Icon(Icons.account_balance),
              onChanged: (value) {
                setState(() {
                  metode = value!;
                });
              },
            ),
            RadioListTile(
              value: "BNI",
              groupValue: metode,
              title: const Text("BNI Virtual Account"),
              secondary: const Icon(Icons.account_balance),
              onChanged: (value) {
                setState(() {
                  metode = value!;
                });
              },
            ),
            RadioListTile(
              value: "BRI",
              groupValue: metode,
              title: const Text("BRI Virtual Account"),
              secondary: const Icon(Icons.account_balance),
              onChanged: (value) {
                setState(() {
                  metode = value!;
                });
              },
            ),
            RadioListTile(
              value: "QRIS",
              groupValue: metode,
              title: const Text("QRIS"),
              secondary: const Icon(Icons.qr_code),
              onChanged: (value) {
                setState(() {
                  metode = value!;
                });
              },
            ),
            RadioListTile(
              value: "Debit",
              groupValue: metode,
              title: const Text("Kartu Debit / Kredit"),
              secondary: const Icon(Icons.credit_card),
              onChanged: (value) {
                setState(() {
                  metode = value!;
                });
              },
            ),
            RadioListTile(
              value: "Indomaret",
              groupValue: metode,
              title: const Text("Indomaret"),
              secondary: const Icon(Icons.store),
              onChanged: (value) {
                setState(() {
                  metode = value!;
                });
              },
            ),
            RadioListTile(
              value: "Alfamart",
              groupValue: metode,
              title: const Text("Alfamart"),
              secondary: const Icon(Icons.store),
              onChanged: (value) {
                setState(() {
                  metode = value!;
                });
              },
            ),
            const SizedBox(height: 25),
            if (metode == "BCA" ||
                metode == "Mandiri" ||
                metode == "BNI" ||
                metode == "BRI")
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$metode Virtual Account",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SelectableText(
                        nomorVA,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Silakan lakukan pembayaran menggunakan nomor Virtual Account di atas.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            if (metode == "QRIS")
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        "Scan QRIS",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Image.asset(
                        "assets/images/qr_dummy.png",
                        width: 220,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Scan menggunakan aplikasi mobile banking atau e-wallet.",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            if (metode == "Debit")
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.credit_card,
                        size: 60,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Pembayaran menggunakan kartu Debit / Kredit (Simulasi).",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            if (metode == "Indomaret" || metode == "Alfamart")
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Kode Pembayaran $metode",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SelectableText(
                        kodeMinimarket,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Tunjukkan kode pembayaran kepada kasir.",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ringkasan Pesanan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 18),
                    item(
                      "Destinasi",
                      widget.pesanan.namaWisata,
                    ),
                    item(
                      "Nama Pemesan",
                      widget.pesanan.namaPemesan,
                    ),
                    item(
                      "Nomor HP",
                      widget.pesanan.nomorHp,
                    ),
                    item(
                      "Tanggal",
                      widget.pesanan.tanggal,
                    ),
                    item(
                      "Jumlah Tiket",
                      "${widget.pesanan.jumlah} Tiket",
                    ),
                    const Divider(),
                    item(
                      "Subtotal",
                      Formatter.formatRupiah(
                        widget.pesanan.subtotal,
                      ),
                    ),
                    item(
                      "Diskon",
                      widget.pesanan.diskon == 0
                          ? "-"
                          : "- ${Formatter.formatRupiah(widget.pesanan.diskon)}",
                    ),
                    const Divider(),
                    item(
                      "Total Bayar",
                      Formatter.formatRupiah(
                        widget.pesanan.total,
                      ),
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.payment),
                label: const Text(
                  "Bayar Sekarang",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () async {
                  // loading
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  await Future.delayed(
                    const Duration(seconds: 2),
                  );

                  if (!mounted) return;

                  Navigator.pop(context);

                  // kurangi stok
                  widget.wisata.stok -= widget.pesanan.jumlah;

                  // dialog berhasil
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 70,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Pembayaran Berhasil",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Terima kasih.\n\nPembayaran berhasil diverifikasi dan E-Ticket telah dibuat.",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Lihat E-Ticket"),
                          ),
                        ),
                      ],
                    ),
                  );

                  if (!mounted) return;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ETicketPage(
                        pesanan: widget.pesanan,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget item(
    String title,
    String value, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: isTotal ? 17 : 15,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 15,
              fontWeight: FontWeight.bold,
              color: isTotal ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
