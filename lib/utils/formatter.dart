class Formatter {
  static String formatRupiah(int angka) {
    String hasil = angka.toString();

    RegExp reg = RegExp(r'(\d+)(\d{3})');

    while (reg.hasMatch(hasil)) {
      hasil = hasil.replaceAllMapped(
        reg,
        (Match m) => '${m[1]}.${m[2]}',
      );
    }

    return "Rp $hasil";
  }
}
