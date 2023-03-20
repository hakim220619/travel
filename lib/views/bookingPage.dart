// import 'package:bus_ticket_booking_app/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:loginwithapi/service/http_service.dart';

class Add extends StatefulWidget {
  const Add({
    Key? key,
    this.date,
    this.fromcity,
    this.tocity,
  }) : super(key: key);

  final String? date;
  final String? fromcity;
  final String? tocity;

  @override
  State<Add> createState() => _AddState();
}

// for Authentication login and signup
class _AddState extends State<Add> {
  // AuthController authController = Get.put(AuthController());
  TextEditingController dateofJourney = TextEditingController();
//list for gender

  List fromAgent = [];
  Future getagentFrom() async {
    var baseUrl = "https://travel.dlhcode.com/api/tempat_agen";
    http.Response response = await http.get(Uri.parse(baseUrl));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        fromAgent = jsonData['data'];
      });
    }
    // print(fromAgent);
  }

  List toAgent = [];
  Future getagentTo() async {
    var baseUrl = "https://travel.dlhcode.com/api/tempat_agen";
    http.Response response = await http.get(Uri.parse(baseUrl));
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        toAgent = jsonData['data'];
      });
    }
    // print(fromAgent);
  }

  // List<String> get ToCity => [
  //       'Kebumen',
  //       'Banyumas',
  //       'Purwokerto',
  //       'Wonosobo',
  //       'Bali',
  //       'Surabaya',
  //     ];

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getagentFrom();
    getagentTo();
  }

  var fromAgentValue;
  var toAgentValue;
  bool changebutton = false;
  @override
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      child: Text(
                        "Travel Booking",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //------Textformfiled code-------------
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Container(
                      child: Column(children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "From :",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              //Add isDense true and zero Padding.
                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //Add more decoration as you want here
                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Titik Penjemputan',
                              style: TextStyle(fontSize: 14),
                            ),
                            items: fromAgent.map((item) {
                              return DropdownMenuItem(
                                value: item['tempat_agen'].toString(),
                                child: Text(item['tempat_agen'].toString()),
                              );
                            }).toList(),
                            value: fromAgentValue,
                            onChanged: (newVal) {
                              setState(() {
                                fromAgentValue = newVal;
                              });
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "TO :",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            // isExpanded: true,
                            hint: const Text(
                              'Select Your City',
                              style: TextStyle(fontSize: 14),
                            ),
                            items: fromAgent.map((item) {
                              return DropdownMenuItem(
                                value: item['tempat_agen'].toString(),
                                child: Text(item['tempat_agen'].toString()),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                toAgentValue = newVal;
                              });
                            },
                            value: toAgentValue,
                            validator: (value) {
                              if (value == null) return 'Please select city';
                            },
                          ),
                        ),

                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Date :",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            readOnly: true,
                            controller: dateofJourney,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'Pick your Date'),
                            validator: (value) {
                              if (value == false) return 'Please select Date';
                              return null;
                            },
                            onTap: () async {
                              DateFormat('dd/mm/yyyy').format(DateTime.now());
                              var date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100));
                              dateofJourney.text =
                                  date.toString().substring(0, 10);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //-----------Login Button code---------------
                        InkWell(
                          onTap: () async {
                            await HttpService.search(fromAgentValue,
                                toAgentValue, dateofJourney.text, context);
                          },
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: changebutton ? 50 : 150,
                            height: 50,
                            alignment: Alignment.center,
                            child: changebutton
                                ? Icon(Icons.done)
                                : Text(
                                    "Cari",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(
                                    changebutton ? 50 : 8)),
                          ),
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
