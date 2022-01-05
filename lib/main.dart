// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:numeric_keyboard/numeric_keyboard.dart';

void main() {
  runApp(Esp());
}

class Esp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Smart Home",
            style: TextStyle(
              fontSize: 34,
            ),
          ),
        ),
        body: EspPage(),
      ),
    );
  }
}

class EspPage extends StatefulWidget {
  @override
  _EspPageState createState() => _EspPageState();
}

class _EspPageState extends State<EspPage> {
  @override
  var Counter = 0, LDR = 'week', state = 'Running';
  var jsonResponse = {'Counter': 0, 'LDR': 'week'};
  String text = '';
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(
            "7 Segment Control",
            style: TextStyle(fontSize: 28),
          ),
          leading: Icon(
            Icons.cast_connected,
            size: 45,
            color: Colors.blue,
          ),
          subtitle: Text(
            "ESP8266 & Flutter",
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
        ),
        RaisedButton.icon(
            onPressed: () async {
              var res = await http.get('http://192.168.4.1/?on');
              setState(() {
                if (res.statusCode == 200) {
                  var jsonResponse = jsonDecode(res.body);
                  Counter = jsonResponse['Counter'];
                  LDR = jsonResponse['LDR'];
                  state = jsonResponse['state'];
                }
              });
            },
            icon: Icon(
              Icons.lightbulb,
              color: Colors.yellow,
              size: 30,
            ),
            label: Text(
              "ON",
              style: TextStyle(fontSize: 22),
            )),
        RaisedButton.icon(
            onPressed: () async {
              var res = await http.get('http://192.168.4.1/?off');
              setState(() {
                if (res.statusCode == 200) {
                  var jsonResponse = jsonDecode(res.body);
                  Counter = jsonResponse['Counter'];
                  LDR = jsonResponse['LDR'];
                  state = jsonResponse['state'];
                }
              });
            },
            icon: Icon(
              Icons.lightbulb_outline,
              size: 30,
            ),
            label: Text("OFF", style: TextStyle(fontSize: 22))),
        RaisedButton.icon(
            onPressed: () async {
              var res = await http.get('http://192.168.4.1/?increase');
              setState(() {
                if (res.statusCode == 200) {
                  var jsonResponse = jsonDecode(res.body);
                  Counter = jsonResponse['Counter'];
                  LDR = jsonResponse['LDR'];
                  state = jsonResponse['state'];
                }
              });
            },
            icon: Icon(
              Icons.add,
              size: 30,
            ),
            label: Text("Increase", style: TextStyle(fontSize: 22))),
        RaisedButton.icon(
            onPressed: () async {
              var res = await http.get('http://192.168.4.1/?decrease');
              setState(() {
                if (res.statusCode == 200) {
                  var jsonResponse = jsonDecode(res.body);
                  Counter = jsonResponse['Counter'];
                  LDR = jsonResponse['LDR'];
                  state = jsonResponse['state'];
                }
              });
            },
            icon: Icon(
              Icons.remove,
              size: 30,
            ),
            label: Text("Decrease", style: TextStyle(fontSize: 22))),
        RaisedButton.icon(
            onPressed: () async {
              var res = await http.get('http://192.168.4.1/?reset');
              setState(() {
                if (res.statusCode == 200) {
                  var jsonResponse = jsonDecode(res.body);
                  Counter = jsonResponse['Counter'];
                  LDR = jsonResponse['LDR'];
                  state = jsonResponse['state'];
                }
              });
            },
            icon: Icon(
              Icons.restore_sharp,
              size: 30,
            ),
            label: Text("Reset", style: TextStyle(fontSize: 22))),
        RaisedButton.icon(
            onPressed: () async {
              var res = await http.get('http://192.168.4.1/');
              setState(() {
                if (res.statusCode == 200) {
                  var jsonResponse = jsonDecode(res.body);
                  Counter = jsonResponse['Counter'];
                  LDR = jsonResponse['LDR'];
                  state = jsonResponse['state'];
                }
              });
            },
            icon: Icon(
              Icons.refresh,
              size: 30,
            ),
            label: Text("Refresh", style: TextStyle(fontSize: 22))),
        RaisedButton.icon(
            onPressed: () async {
              var res = await http.get('http://192.168.4.1/?sr');
              setState(() {
                if (res.statusCode == 200) {
                  var jsonResponse = jsonDecode(res.body);
                  Counter = jsonResponse['Counter'];
                  LDR = jsonResponse['LDR'];
                  state = jsonResponse['state'];
                }
              });
            },
            icon: Icon(
              Icons.play_arrow_outlined,
              size: 30,
            ),
            label: Text("Stop / Resume", style: TextStyle(fontSize: 22))),
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            Text(
              'The 7 Segment Value is $Counter',
              style: TextStyle(fontSize: 28, color: Colors.lightBlue),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            Text(
              'The bulb intensity is $LDR',
              style: TextStyle(fontSize: 28, color: Colors.lightBlue),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '$state',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(text),
            NumericKeyboard(
              onKeyboardTap: _onKeyboardTap,
              textColor: Colors.blueAccent,
              rightButtonFn: () {
                setState(() {
                  text = text.substring(0, text.length - 1);
                });
              },
              rightIcon: Icon(
                Icons.backspace,
                color: Colors.red,
              ),
              leftButtonFn: () async {
                print('left button clicked');
                var res = await http.get('http://192.168.4.1/?num$text');
                setState(() {
                  if (res.statusCode == 200) {
                    var jsonResponse = jsonDecode(res.body);
                    Counter = jsonResponse['Counter'];
                    LDR = jsonResponse['LDR'];
                    state = jsonResponse['state'];
                  }
                });
              },
              leftIcon: Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }
}
