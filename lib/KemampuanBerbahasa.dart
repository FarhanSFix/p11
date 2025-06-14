import 'package:flutter/material.dart';

List<String> bahasaDipilihList = [];

class KemampuanBerbahasa extends StatefulWidget {
  const KemampuanBerbahasa({super.key});

  @override
  State<KemampuanBerbahasa> createState() => _KemampuanBerbahasaState();
}

class _KemampuanBerbahasaState extends State<KemampuanBerbahasa> {
  List<String> bahasaList = [
    "Indonesia",
    "Inggris",
    "Arab",
    "Sunda",
    "Jawa",
    "Madura",
    "Jepang",
    "Korea",
    "Mandarin",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Kemampuan Berbahasa"),
        Container(
          height: 90,
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 4 / 1,
            ),
            children: bahasaList.map((e) => OpsiBahasa(strBahasa: e)).toList(),
          ),
        ),
      ],
    );
  }
}

class OpsiBahasa extends StatefulWidget {
  final String strBahasa;
  const OpsiBahasa({super.key, required this.strBahasa});

  @override
  State<OpsiBahasa> createState() => _OpsiBahasaState();
}

class _OpsiBahasaState extends State<OpsiBahasa> {
  bool? opsiDipilih = false;

  @override
  void initState() {
    super.initState();
    opsiDipilih = bahasaDipilihList.contains(widget.strBahasa);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: opsiDipilih,
          onChanged: (value) {
            setState(() {
              opsiDipilih = value;
              if (value == true) {
                bahasaDipilihList.add(widget.strBahasa);
              } else {
                bahasaDipilihList.remove(widget.strBahasa);
              }
            });
          },
        ),
        Text(widget.strBahasa),
      ],
    );
  }
}
