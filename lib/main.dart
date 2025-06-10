import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:p11/konstanta.dart';
import 'package:p11/pendaftaran_add.dart';
import 'package:p11/pendaftaran_model.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataPendaftaran(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DataPendaftaran extends StatefulWidget {
  const DataPendaftaran({super.key});

  @override
  State<DataPendaftaran> createState() => _DataPendaftaranState();
}

class _DataPendaftaranState extends State<DataPendaftaran> {
  List<PendaftaranModel> pendaftaranList = [];

  Future ambilDataPendaftaran() async {
    var url = Uri.parse(baseUrl + 'pendaftaran');
    var respons = await http.get(url);
    List responsDecode = json.decode(respons.body);
    pendaftaranList.clear();

    for (var element in responsDecode) {
      pendaftaranList.add(PendaftaranModel.fromJson(element));
    }
    return pendaftaranList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data Pendaftaran")),
      body: FutureBuilder(
        future: ambilDataPendaftaran(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (pendaftaranList.length == 0) {
              return Center(child: Text("Data Tidak Ditemukan"));
            }
            return ListView.builder(
              itemCount: pendaftaranList.length,
              itemBuilder: (context, index) => Card(
                color: Colors.green.shade50,
                child: ListTile(
                  title: Text(pendaftaranList[index].id!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('nama : ${pendaftaranList[index].nama!}'),
                      Text('email : ${pendaftaranList[index].email!}'),
                      Text('noTelpon : ${pendaftaranList[index].noTelpon!}'),
                      Text(
                        'jenis Kelamin : ${pendaftaranList[index].jenisKelamin!}',
                      ),
                      Text('bahasa : ${pendaftaranList[index].bahasa!}'),
                      Text('agama : ${pendaftaranList[index].agama!}'),
                      Text(
                        'tanggal Daftar : ${pendaftaranList[index].tanggalDaftar!}',
                      ),
                      Text('jam Daftar : ${pendaftaranList[index].jamDaftar!}'),
                    ],
                  ),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Hapus Data"),
                                content: Text(
                                  "Apakah anda yakin akan menghapus data?",
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      var url = Uri.parse(
                                        baseUrl +
                                            'pendaftaran/${pendaftaranList[index].id!}',
                                      );
                                      var respons = await http.delete(url);
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: Text("Ya"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Tidak"),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Edit Data"),
                                content: Text(
                                  "Apakah anda yakin akan mengedit data?",
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      var url = Uri.parse(
                                        baseUrl +
                                            'pendaftaran/${pendaftaranList[index].id!}',
                                      );
                                      var respons = await http.put(
                                        url,
                                        body: PendaftaranModel(
                                          nama: "Joko Edit",
                                          email: "Jokoedit@gmail.com",
                                          noTelpon: "08964",
                                          jenisKelamin: "Pria",
                                          bahasa: "Indonesia, Inggris, Batak",
                                          agama: "Katolik",
                                          tanggalDaftar: "2024-01-01",
                                          jamDaftar: "20:00:00",
                                        ).toJson(),
                                      );
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: Text("Ya"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Tidak"),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PendaftaranAdd()),
          );
        },
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
    );
  }
}
