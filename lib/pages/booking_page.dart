import 'package:flutter/material.dart';

import '../data/pemesanan_data.dart';
import '../models/pemesanan.dart';
import '../models/wisata.dart';
import 'eticket_page.dart';

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
  final TextEditingController namaController = TextEditingController();
  final TextEditingController hpController = TextEditingController();

  DateTime? tanggal;

  int jumlahTiket = 1;

  int get totalHarga => jumlahTiket * widget.wisata.harga;

  Future<void> pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        tanggal = picked;
      });
    }
  }

  String formatTanggal() {
    if (tanggal == null) {
      return "Pilih Tanggal";
    }

    return "${tanggal!.day}/${tanggal!.month}/${tanggal!.year}";
  }

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

  void pesan() {
    if (namaController.text.trim().isEmpty ||
        hpController.text.trim().isEmpty ||
        tanggal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Lengkapi semua data terlebih dahulu.",
          ),
        ),
      );
      return;
    }

    final pesanan = Pemesanan(
      namaPemesan: namaController.text.trim(),
      nomorHp: hpController.text.trim(),
      namaWisata: widget.wisata.nama,
      tanggal: formatTanggal(),
      jumlah: jumlahTiket,
      total: totalHarga,
    );

    daftarPemesanan.add(pesanan);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ETicketPage(
          pesanan: pesanan,
        ),
      ),
    );
  }

  Widget infoRow(String judul, String isi) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            judul,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            isi,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Tiket"),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              onPressed: pesan,
              icon: const Icon(Icons.confirmation_num),
              label: const Text(
                "Pesan Sekarang",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.place,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.wisata.nama,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.wisata.lokasi,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Tanggal Kunjungan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: pilihTanggal,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      formatTanggal(),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: "Nama Pemesan",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: hpController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Nomor HP",
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Jumlah Tiket",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 38,
                  color: Colors.red,
                  onPressed: () {
                    if (jumlahTiket > 1) {
                      setState(() {
                        jumlahTiket--;
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.remove_circle,
                  ),
                ),
                Container(
                  width: 70,
                  alignment: Alignment.center,
                  child: Text(
                    jumlahTiket.toString(),
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 38,
                  color: Colors.green,
                  onPressed: () {
                    setState(() {
                      jumlahTiket++;
                    });
                  },
                  icon: const Icon(
                    Icons.add_circle,
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
                  children: [
                    const Text(
                      "Ringkasan Pesanan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    infoRow(
                      "Destinasi",
                      widget.wisata.nama,
                    ),
                    infoRow(
                      "Harga Tiket",
                      formatRupiah(
                        widget.wisata.harga,
                      ),
                    ),
                    infoRow(
                      "Jumlah",
                      "$jumlahTiket Tiket",
                    ),
                    const Divider(),
                    infoRow(
                      "Total Bayar",
                      formatRupiah(totalHarga),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
