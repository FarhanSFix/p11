import 'package:flutter/material.dart';

TextEditingController TanggalDaftarController = TextEditingController();

class TanggalDaftar extends StatefulWidget {
  const TanggalDaftar({super.key});

  @override
  State<TanggalDaftar> createState() => _TanggalDaftarState();
}

class _TanggalDaftarState extends State<TanggalDaftar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TanggalDaftarController,
      decoration: InputDecoration(
        label: Text("Tanggal Daftar"),
        suffixIcon: IconButton(
          onPressed: () {
            pilihTanggal();
          },
          icon: Icon(Icons.date_range),
        ),
      ),
    );
  }

  Future<void> pilihTanggal() async {
    DateTime? tglDidapat;

    tglDidapat = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );

    if (tglDidapat.toString() != "null") {
      TanggalDaftarController.text = tglDidapat.toString().substring(0, 10);
    }
  }
}
