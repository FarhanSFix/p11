import 'package:flutter/material.dart';
TextEditingController jamDaftarController = TextEditingController();

class jamDaftar extends StatefulWidget {
  const jamDaftar({super.key});

  @override
  State<jamDaftar> createState() => _jamDaftarState();
}

class _jamDaftarState extends State<jamDaftar> {
  

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: jamDaftarController,
      decoration: InputDecoration(
        label: Text("Jam Daftar"),
        suffixIcon: IconButton(
          onPressed: () {pilihTanggal();},
          icon: Icon(Icons.timer),
        ),
      ),
    );
  }
  
  Future<void> pilihTanggal() async {
    TimeOfDay? jamDidapat;

    jamDidapat=await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now()
    );

    if (jamDidapat.toString() != "null") {
      jamDaftarController.text = jamDidapat
      .toString()
      .replaceAll('TimeOfDay(', '')
      .replaceAll(')', '');
    }
  }
}