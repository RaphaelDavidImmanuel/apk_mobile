import 'package:flutter/material.dart';

import '../data/wisata_data.dart';
import '../models/wisata.dart';
import '../utils/formatter.dart';
import 'detail_wisata_page.dart';

class WisataPage extends StatefulWidget {
  const WisataPage({super.key});

  @override
  State<WisataPage> createState() => _WisataPageState();
}

class _WisataPageState extends State<WisataPage> {
  final TextEditingController searchController = TextEditingController();

  late List<Wisata> hasilCari;

  @override
  void initState() {
    super.initState();
    hasilCari = List.from(daftarWisata);
  }

  void cariWisata(String keyword) {
    setState(() {
      if (keyword.trim().isEmpty) {
        hasilCari = List.from(daftarWisata);
      } else {
        hasilCari = daftarWisata.where((wisata) {
          return wisata.nama.toLowerCase().contains(keyword.toLowerCase()) ||
              wisata.lokasi.toLowerCase().contains(keyword.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Wisata"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              15,
              15,
              15,
              10,
            ),
            child: TextField(
              controller: searchController,
              onChanged: cariWisata,
              decoration: InputDecoration(
                hintText: "Cari nama atau lokasi wisata...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          cariWisata("");
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: hasilCari.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Destinasi tidak ditemukan",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(
                      bottom: 15,
                    ),
                    itemCount: hasilCari.length,
                    itemBuilder: (context, index) {
                      final wisata = hasilCari[index];

                      String rating = "4.8";

                      if (wisata.nama == "Kawah Putih") {
                        rating = "4.9";
                      } else if (wisata.nama == "Taman Safari") {
                        rating = "4.8";
                      } else if (wisata.nama == "Kebun Raya Bogor") {
                        rating = "5.0";
                      } else if (wisata.nama == "Gunung Bromo") {
                        rating = "4.9";
                      } else if (wisata.nama == "Raja Ampat") {
                        rating = "5.0";
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailWisataPage(
                                wisata: wisata,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(18),
                                ),
                                child: Image.asset(
                                  wisata.gambar,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      wisata.nama,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          rating,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 18),
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            wisata.lokasi,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Mulai dari",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              Formatter.formatRupiah(
                                                wisata.harga,
                                              ),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    DetailWisataPage(
                                                  wisata: wisata,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 16,
                                          ),
                                          label: const Text(
                                            "Lihat",
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
