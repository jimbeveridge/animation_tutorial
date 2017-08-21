// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This program draws the Flutter logo without animation

import 'package:flutter/material.dart';

class LogoApp extends StatefulWidget {
  LogoAppState createState() => new LogoAppState();
}

class LogoAppState extends State<LogoApp> {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: 300.0,
        width: 300.0,
        child: new FlutterLogo(),
      ),
    );
  }
}

void main() {
  runApp(new LogoApp());
}
