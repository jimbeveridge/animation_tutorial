// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Demonstrate a simple animation with addListener()

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

const kLogoUrl =
    "https://raw.githubusercontent.com/dart-lang/logos/master/logos_and_wordmarks/dart-logo.png";

class LogoApp extends StatefulComponent {
  const LogoApp({Key key}) : super(key: key);
  LogoAppState createState() => new LogoAppState();
}

class LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;

  initState() {
    super.initState();
    AnimationController controller =
        new AnimationController(duration: const Duration(milliseconds: 2000),
            vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
            margin: new EdgeInsets.symmetric(vertical: 10.0),
            height: animation.value,
            width: animation.value,
            child: new Image.network(kLogoUrl)));
  }
}

void main() {
  runApp(new LogoApp());
}
