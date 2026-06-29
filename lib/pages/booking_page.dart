import 'package:flutter/material.dart';
import 'dart:math';

// import 'package:intl/intl.dart';

import '../data/pemesanan_data.dart';
import '../models/pemesanan.dart';
import '../models/wisata.dart';
import '../utils/formatter.dart';
import 'payment_page.dart';
// import 'eticket_page.dart';

class BookingPage extends StatefulWidget {
  final Wisata wisata;

  const BookingPage({
    super.key,
    required this.wisata,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();

  final hpController = TextEditingController();

  DateTime? tanggal;

  int jumlah = 1;

  //----------------------------------------------------
  // HITUNG
  //----------------------------------------------------

  int get hargaTiket => widget.wisata.harga;

  int get subtotal => hargaTiket * jumlah;

  int get diskon {
    if (jumlah >= 2) {
      return (subtotal * 0.20).toInt();
    }

    return 0;
  }

  int get total => subtotal - diskon;

  //----------------------------------------------------
  // DATE PICKER
  //----------------------------------------------------

  Future<void> pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(
        2030,
      ),
    );

    if (picked != null) {
      setState(() {
        tanggal = picked;
      });
    }
  }

  //----------------------------------------------------
  // PESAN
  //----------------------------------------------------

  void pesan() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (tanggal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Pilih tanggal kunjungan terlebih dahulu.",
          ),
        ),
      );

      return;
    }

    //----------------------------------------------------
// VALIDASI STOK
//----------------------------------------------------

    if (jumlah > widget.wisata.stok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Maaf, stok tiket hanya tersisa ${widget.wisata.stok}.",
          ),
        ),
      );

      return;
    }

    final now = DateTime.now();

    final data = Pemesanan(
      kodeBooking: "WG${100000 + Random().nextInt(900000)}",
      waktuPesan: "${now.day}/${now.month}/${now.year} "
          "${now.hour}:${now.minute.toString().padLeft(2, '0')}",
      namaPemesan: namaController.text,
      nomorHp: hpController.text,
      namaWisata: widget.wisata.nama,
      tanggal: "${tanggal!.day}/${tanggal!.month}/${tanggal!.year}",
      jumlah: jumlah,
      subtotal: subtotal,
      diskon: diskon,
      total: total,
      sudahReview: false,
    );

    daftarPemesanan.add(
      data,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentPage(
          pesanan: data,
          wisata: widget.wisata,
        ),
      ),
    );
  }

  //----------------------------------------------------
  // BUILD
  //----------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Booking Tiket",
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //================ DESTINASI =================

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                      child: Image.asset(
                        widget.wisata.gambar,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.wisata.nama,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  widget.wisata.lokasi,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            Formatter.formatRupiah(hargaTiket),
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Data Pemesan",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: namaController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Nama wajib diisi";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Nama Pemesan",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: hpController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Nomor HP wajib diisi";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Nomor HP",
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Tanggal Kunjungan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              InkWell(
                onTap: pilihTanggal,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        tanggal == null
                            ? "Pilih Tanggal"
                            : "${tanggal!.day}/${tanggal!.month}/${tanggal!.year}",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Jumlah Tiket",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 38,
                    onPressed: () {
                      if (jumlah > 1) {
                        setState(() {
                          jumlah--;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    width: 70,
                    alignment: Alignment.center,
                    child: Text(
                      jumlah.toString(),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: 38,
                    onPressed: () {
                      if (jumlah < widget.wisata.stok) {
                        setState(() {
                          jumlah++;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Stok tersisa ${widget.wisata.stok} tiket.",
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Ringkasan Pembayaran",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 18),
                      buildItem(
                        "Harga / Tiket",
                        Formatter.formatRupiah(
                          hargaTiket,
                        ),
                      ),
                      buildItem(
                        "Jumlah Tiket",
                        "$jumlah Tiket",
                      ),
                      buildItem(
                        "Subtotal",
                        Formatter.formatRupiah(
                          subtotal,
                        ),
                      ),
                      buildItem(
                        "Diskon",
                        diskon == 0
                            ? "-"
                            : "- ${Formatter.formatRupiah(diskon)}",
                        valueColor: diskon == 0 ? Colors.black : Colors.green,
                      ),
                      const Divider(
                        height: 30,
                      ),
                      buildItem(
                        "TOTAL",
                        Formatter.formatRupiah(
                          total,
                        ),
                        isTotal: true,
                      ),
                      if (diskon > 0) ...[
                        const SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.discount,
                                color: Colors.green,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "Promo 20% berhasil diterapkan.",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: pesan,
                  icon: const Icon(
                    Icons.payment,
                  ),
                  label: const Text(
                    "Pesan Sekarang",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(
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
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: isTotal ? 18 : 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: isTotal ? 20 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    hpController.dispose();
    super.dispose();
  }
}
