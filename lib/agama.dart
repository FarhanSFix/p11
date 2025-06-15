import 'package:flutter/material.dart';

String? agamaDipilih;

class Agama extends StatefulWidget {
  const Agama({super.key});

  @override
  State<Agama> createState() => _AgamaState();
}

class _AgamaState extends State<Agama> {
  List<String> agamaList = [
    "Islam",
    "Katolik",
    "Protestan",
    "Hindu",
    "Budha",
    "Konghucu",
    "Penganut Kepercayaan",
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text("Silahkan Pilih Agama yang Anda Anut"),
      value: agamaList.contains(agamaDipilih) ? agamaDipilih : null,
      items: agamaList
          .map((e) => DropdownMenuItem(child: Text(e), value: e))
          .toList(),
      onChanged: (value) {
        setState(() {
          agamaDipilih = value;
        });
      },
    );
  }
}
