import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:loginwithapi/service/http_service.dart';

class PesanPage extends StatefulWidget {
  const PesanPage(
      {Key? key,
      required this.asalKey,
      required this.tujuanKey,
      required this.tanggalKey})
      : super(key: key);
  final String asalKey;
  final String tujuanKey;
  final String tanggalKey;

  @override
  State<PesanPage> createState() => _PesanPageState();
}

class _PesanPageState extends State<PesanPage> {
  TextEditingController Nama = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Nohp = TextEditingController();
  @override
  var nama;
  var email;
  var noHp;
  var tanggal;
  var asal;
  var tujuan;
  final _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pesan")),
      body: SafeArea(
        child: Material(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Container(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: Nama,
                            onChanged: (value) {
                              setState(() {
                                nama = value;
                              });
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Masukan Nama Lengkap",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: "Nama"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Nama tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: Email,
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Masukan Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: "Email"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: Nohp,
                            onChanged: (value) {
                              setState(() {
                                noHp = value;
                              });
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Masukan Nomor Hp",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: "Nomor Hp"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Nomor Hp tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            initialValue: widget.asalKey,
                            obscureText: false,
                            onChanged: (value) {
                              setState(() {
                                asal = value;
                              });
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: 'Asal',
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: "Asal"),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            initialValue: widget.tujuanKey,
                            obscureText: false,
                            onChanged: (value) {
                              setState(() {
                                tujuan = value;
                              });
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: 'Tujuan',
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: "Tujuan"),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            initialValue: widget.tanggalKey,
                            obscureText: false,
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: 'Tanggal',
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: "Tanggal"),
                            onChanged: (value) {
                              setState(() {
                                tanggal = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () async {
                        await HttpService.pesan(nama, email, noHp,
                            widget.asalKey, widget.tujuanKey, tanggal, context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: const Center(
                          child: Text(
                            "Bayar",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(25)),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
