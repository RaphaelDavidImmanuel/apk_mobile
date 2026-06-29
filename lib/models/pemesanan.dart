class Pemesanan {
  final String namaPemesan;
  final String nomorHp;
  final String namaWisata;
  final String tanggal;
  final String kodeBooking;
  final String waktuPesan;

  final int jumlah;
  final int subtotal;
  final int diskon;
  final int total;

  bool sudahReview;

  Pemesanan({
    required this.namaPemesan,
    required this.nomorHp,
    required this.namaWisata,
    required this.tanggal,
    required this.jumlah,
    required this.subtotal,
    required this.diskon,
    required this.total,
    required this.kodeBooking,
    required this.waktuPesan,
    required this.sudahReview,
  });
}
