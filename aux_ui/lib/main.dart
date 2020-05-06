// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

//class Invite extends StatefulWidget {
//  @override
//  InviteState createState() => InviteState();
//}
//
//class InviteState extends State<Invite> {
//
//}

class MyApp extends StatelessWidget {

  Container hostQueue = Container(
      child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            "host\nan aux queue",
            style: TextStyle(
                color: Colors.white, fontSize: 57, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          )),
      color: Colors.black);

  Container joinQueue = Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFCC00FF), Color(0xFF4200FF)],
              begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
      ),
      child: Align(
          alignment: Alignment.topRight,
          child: Text(
            "join\nan aux queue",
            style: TextStyle(
                color: Colors.black, fontSize: 57, fontWeight: FontWeight.w500),
            textAlign: TextAlign.right,
          )),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        body: Center(
          child: Container(
              child: Column(children: <Widget>[
            Expanded(
                child: hostQueue),
            Expanded(
                child: joinQueue),
          ])),
        ),
      ),
    );
  }
}
