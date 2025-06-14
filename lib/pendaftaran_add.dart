import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:p11/KemampuanBerbahasa.dart';
import 'package:p11/agama.dart';
import 'package:p11/jamDaftar.dart';
import 'package:p11/konstanta.dart';
import 'package:p11/main.dart';
import 'package:p11/pendaftaran_model.dart';
import 'package:p11/tanggalDaftar.dart';

class PendaftaranAdd extends StatefulWidget {
  final PendaftaranModel? data;
  const PendaftaranAdd({Key? key, this.data}) : super(key: key);

  @override
  State<PendaftaranAdd> createState() => _PendaftaranAddState();
}

class _PendaftaranAddState extends State<PendaftaranAdd> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();

  String? jenisKelamin;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      namaController.text = widget.data!.nama!;
      emailController.text = widget.data!.email!;
      noTelpController.text = widget.data!.noTelpon!;
      jenisKelamin = widget.data!.jenisKelamin!;
      bahasaDipilihList = widget.data!.bahasa!.split(',');
      agamaDipilih = widget.data!.agama!;
      TanggalDaftarController.text = widget.data!.tanggalDaftar!;
      jamDaftarController.text = widget.data!.jamDaftar!;
    }
  }

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextField(
                controller: namaController,
                decoration: InputDecoration(label: Text("Nama Lengkap")),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(label: Text("Email")),
              ),
              TextField(
                controller: noTelpController,
                decoration: InputDecoration(label: Text("Nomor Telepon")),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: Text("Pria"),
                      value: "Pria",
                      groupValue: jenisKelamin,
                      onChanged: (value) {
                        setState(() {
                          jenisKelamin = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text("Wanita"),
                      value: "Wanita",
                      groupValue: jenisKelamin,
                      onChanged: (value) {
                        setState(() {
                          jenisKelamin = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              KemampuanBerbahasa(),
              Agama(),
              TanggalDaftar(),
              jamDaftar(),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (widget.data != null) {
                        // EDIT DATA
                        var url = Uri.parse(
                          baseUrl + 'pendaftaran/${widget.data!.id}',
                        );
                        await http.put(
                          url,
                          body: PendaftaranModel(
                            nama: namaController.text,
                            email: emailController.text,
                            noTelpon: noTelpController.text,
                            jenisKelamin: jenisKelamin,
                            bahasa: bahasaDipilihList.toString(),
                            agama: agamaDipilih,
                            tanggalDaftar: TanggalDaftarController.text,
                            jamDaftar: jamDaftarController.text,
                          ).toJson(),
                        );
                      } else {
                        // TAMBAH DATA
                        var url = Uri.parse(baseUrl + 'pendaftaran');
                        var respons = await http.post(
                          url,
                          body: PendaftaranModel(
                            nama: namaController.text,
                            email: emailController.text,
                            noTelpon: noTelpController.text,
                            jenisKelamin: jenisKelamin,
                            bahasa: bahasaDipilihList.toString(),
                            agama: agamaDipilih,
                            tanggalDaftar: TanggalDaftarController.text,
                            jamDaftar: jamDaftarController.text,
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
                          return;
                        }
                      }

                      // Kembali ke halaman list
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DataPendaftaran(),
                        ),
                      );
                    },
                    child: Text("Simpan"),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DataPendaftaran(),
                      ),
                    ),
                    child: Text("Lihat Data"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
