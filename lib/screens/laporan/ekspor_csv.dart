import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();

}
class _LaporanPageState extends State<LaporanPage> {
  List<List<dynamic>> data = [
    ['tanggal', 'jumlah_transaksi', 'produk', 'pendapatan'],
    ['2024-06-01',  10,'sprite',  30000],
    ['2024-06-01', 15, 'ayam crispy',  30000],
    ['2024-06-02',  8, 'burger',   75000],
  ];

  Future<void> eksporCSV() async {
    String csvData = const ListToCsvConverter().convert(data);
    final String directory = (await getApplicationDocumentsDirectory()).path;
    final path = '$directory/laporan_penjualan.csv';
    final File file = File(path);
    await file.writeAsString(csvData);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Laporan disimpan di $path')),
    );
    OpenFile.open(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Penjualan'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: eksporCSV,
          child: const Text('Ekspor ke CSV'),
        ),
      ),
    );
  }
}