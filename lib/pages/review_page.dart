import 'package:flutter/material.dart';

import '../data/review_data.dart';
import '../models/pemesanan.dart';
import '../models/review.dart';

class ReviewPage extends StatefulWidget {
  final Pemesanan pesanan;

  const ReviewPage({
    super.key,
    required this.pesanan,
  });

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController komentarController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  int rating = 5;

  //--------------------------------------------------
  // KIRIM REVIEW
  //--------------------------------------------------

  void kirimReview() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    daftarReview.insert(
      0,
      Review(
        namaUser: widget.pesanan.namaPemesan,
        namaWisata: widget.pesanan.namaWisata,
        rating: rating,
        komentar: komentarController.text.trim(),
      ),
    );

    widget.pesanan.sudahReview = true;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Terima kasih atas review Anda.",
        ),
      ),
    );

    Navigator.pop(
      context,
      true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rating & Review"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    Icons.rate_review,
                    size: 70,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Bagaimana pengalaman Anda?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.pesanan.namaWisata,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Berikan Rating",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    children: List.generate(
                      5,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              rating = index + 1;
                            });
                          },
                          child: Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 42,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: komentarController,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Komentar tidak boleh kosong";
                      }

                      if (value.trim().length < 5) {
                        return "Komentar terlalu pendek";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Tulis pengalaman Anda",
                      hintText: "Contoh: Tempatnya sangat indah dan bersih...",
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: kirimReview,
                      icon: const Icon(Icons.send),
                      label: const Text(
                        "Kirim Review",
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
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    komentarController.dispose();
    super.dispose();
  }
}
