import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<TodayDayDetails> fetchTodayDayDetails() async {
  final response =
      await http.get(Uri.parse('https://calender-pro.janja.tech/api/v1/01-01'));

  print(response);

  if (response.statusCode == 200) {
    print(response.body);

    // If the server did return a 200 OK response,
    // then parse the JSON.
    return TodayDayDetails.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load details');
  }
}

class TodayDayDetails {
  // final String tarehe;
  final int? id;
  final String? title;
  final String? details;

  TodayDayDetails(
      {required this.id, required this.title, required this.details});

  factory TodayDayDetails.fromJson(Map<String, dynamic> json) {
    return TodayDayDetails(
        // tarehe: json['tarehe'],
        id: json['id'],
        title: json['jina'],
        details: json['maelezo']);
  }
}

class DayDetails extends StatefulWidget {
  const DayDetails({Key? key}) : super(key: key);

  @override
  _DayDetailsState createState() => _DayDetailsState();
}

class _DayDetailsState extends State<DayDetails> {
  late Future<TodayDayDetails> futureTodayDayDetails;
  @override
  void initState() {
    super.initState();
    futureTodayDayDetails = fetchTodayDayDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODAY QUOTE!'),
        backgroundColor: Color.fromRGBO(128, 128, 128, 9.1),
      ),
      body: Column(children: [
        Row(
          children: [
            Container(
              width: 411,
              height: 250,
              color: Colors.black,
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                color: Colors.amberAccent,
                child: Container(
                  alignment: Alignment(1, 0),
                  child: Row(
                    children: [
                      Container(
                        width: 350,
                        height: 190,
                        child: Card(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: FutureBuilder<TodayDayDetails>(
                            future: futureTodayDayDetails,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                // print(snapshot.data);
                                return Text('${snapshot.data!.id}');
                              } else if (snapshot.hasError) {
                                return Text(
                                  '${snapshot.error}',
                                );
                              }
                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Row(
              children: [
                Container(
                  width: 411,
                  height: 250,
                  color: Colors.pink,
                  padding: EdgeInsets.fromLTRB(4, 0, 0, 10),
                  alignment: Alignment(1, -0.9),
                  child: Row(
                    children: [
                      Container(
                        width: 400,
                        height: 75,
                        // padding: EdgeInsets.fromLTRB(02, 00, 00, 0),
                        child: Card(
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(""),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        )
      ]),
    );
  }
}
