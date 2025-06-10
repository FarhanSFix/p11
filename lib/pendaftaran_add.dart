import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:p11/konstanta.dart';
import 'package:p11/main.dart';
import 'package:p11/pendaftaran_model.dart';

class PendaftaranAdd extends StatefulWidget {
  const PendaftaranAdd({super.key});

  @override
  State<PendaftaranAdd> createState() => _PendaftaranAddState();
}

class _PendaftaranAddState extends State<PendaftaranAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Data Pendaftaran")),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DataPendaftaran()),
          );
        },
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () async {
                var url = Uri.parse(baseUrl + 'pendaftran');
                var respons = await http.post(
                  url,
                  body: PendaftaranModel(
                    nama: "jokoabc4",
                    email: "jokoabc4@gmail.com",
                    noTelpon: "08964",
                    jenisKelamin: "Pria",
                    bahasa: "Indonesia, Inggris, Batak",
                    agama: "Katolik",
                    tanggalDaftar: "2024-01-01",
                    jamDaftar: "20:00:00",
                  ).toJson(),
                );

                Map<String, dynamic> responsDecode =
                    json.decode(respons.body) as Map<String, dynamic>;
                if (responsDecode.toString().contains('error')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        responsDecode['messages'].toString().replaceAll(
                          ",",
                          "\n\n",
                        ),
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DataPendaftaran()),
                  );
                }
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
