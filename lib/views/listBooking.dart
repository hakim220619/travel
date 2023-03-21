import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loginwithapi/views/pesanPage.dart';

class ListBooking extends StatefulWidget {
  const ListBooking(
      {Key? key,
      required this.fromAgentValue,
      required this.toAgentValue,
      required this.dateofJourney})
      : super(key: key);
  final String fromAgentValue;
  final String toAgentValue;
  final String dateofJourney;
  @override
  _ListBookingState createState() => _ListBookingState();
}

class _ListBookingState extends State<ListBooking> {
  List _get = [];
  static final _client = http.Client();
  var asal;
  var tujuan;
  Future search() async {
    try {
      print({widget.fromAgentValue});
      var _SearchUrl =
          Uri.parse('https://travel.dlhcode.com/api/cek_persediaan_tiket');
      http.Response response = await _client.post(_SearchUrl, body: {
        "asal": widget.fromAgentValue,
        "tujuan": widget.toAgentValue,
        "tgl_keberangkatan": widget.dateofJourney,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _get = data['data'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    search();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> items = List<String>.generate(10000, (i) => '$i');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 0, 37, 247),
            title: Text(
              "List Travel",
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Color.fromARGB(253, 255, 252, 252),
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: _get.length,
            itemBuilder: (context, index) => Card(
              margin: const EdgeInsets.all(10),
              elevation: 8,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 131, 90, 214),
                  child: Icon(Icons.directions_car),
                ),
                title: Text(
                  _get[index]['asal'],
                  style: new TextStyle(fontSize: 18.0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  _get[index]['tujuan'],
                  maxLines: 2,
                  style: new TextStyle(fontSize: 18.0),
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (
                          context,
                        ) =>
                            PesanPage(
                                asalKey: _get[index]['asal'],
                                tujuanKey: _get[index]['tujuan'],
                                tanggalKey: widget.dateofJourney),
                      ));
                },
              ),
            ),
          )),
    );
  }
}
