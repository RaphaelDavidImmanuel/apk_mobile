import 'package:flutter/material.dart';

import '../models/wisata.dart';
import 'booking_page.dart';

class DetailWisataPage extends StatelessWidget {
  final Wisata wisata;

  const DetailWisataPage({
    super.key,
    required this.wisata,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingPage(
                      wisata: wisata,
                    ),
                  ),
                );
              },
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 270,
            pinned: true,
            backgroundColor: Colors.blue,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    wisata.gambar,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(.2),
                          Colors.black.withOpacity(.5),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wisata.nama,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "4.8",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          wisata.lokasi,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Chip(
                        avatar: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        backgroundColor: Colors.green.shade50,
                        label: const Text(
                          "Buka Hari Ini",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Chip(
                        avatar: const Icon(
                          Icons.schedule,
                          color: Colors.blue,
                        ),
                        backgroundColor: Colors.blue.shade50,
                        label: const Text(
                          "08.00 - 17.00",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Card(
                    color: Colors.blue.shade50,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.payments,
                            color: Colors.blue,
                            size: 40,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Mulai dari",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Rp ${wisata.harga}",
                                style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "/ orang",
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Deskripsi",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    wisata.deskripsi,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Fasilitas",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      FilterChip(
                        selected: true,
                        onSelected: (_) {},
                        avatar: const Icon(Icons.local_parking),
                        label: const Text("Parkir"),
                      ),
                      FilterChip(
                        selected: true,
                        onSelected: (_) {},
                        avatar: const Icon(Icons.restaurant),
                        label: const Text("Restoran"),
                      ),
                      FilterChip(
                        selected: true,
                        onSelected: (_) {},
                        avatar: const Icon(Icons.wc),
                        label: const Text("Toilet"),
                      ),
                      FilterChip(
                        selected: true,
                        onSelected: (_) {},
                        avatar: const Icon(Icons.mosque),
                        label: const Text("Mushola"),
                      ),
                      FilterChip(
                        selected: true,
                        onSelected: (_) {},
                        avatar: const Icon(Icons.photo_camera),
                        label: const Text("Spot Foto"),
                      ),
                      FilterChip(
                        selected: true,
                        onSelected: (_) {},
                        avatar: const Icon(Icons.security),
                        label: const Text("Keamanan"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Informasi",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: const [
                        ListTile(
                          leading: Icon(Icons.access_time),
                          title: Text("Jam Operasional"),
                          subtitle: Text("08.00 - 17.00 WIB"),
                        ),
                        Divider(height: 1),
                        ListTile(
                          leading: Icon(Icons.confirmation_num),
                          title: Text("Jenis Tiket"),
                          subtitle: Text("Berlaku 1x Masuk"),
                        ),
                        Divider(height: 1),
                        ListTile(
                          leading: Icon(Icons.family_restroom),
                          title: Text("Kategori Pengunjung"),
                          subtitle: Text("Semua Umur"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
