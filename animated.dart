// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Demonstrate a simple animation with addListener()

import 'dart:async';
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
  double size = 350.0;
  Timer timer;

  LogoAppState() {
    AnimationController controller =
        new AnimationController(duration: const Duration(milliseconds: 3000),
            vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
    timer = new Timer.periodic(const Duration(seconds: 2), (timer) {
      size *= 0.75;
      if (size > 400.0) {
        timer.cancel();
      } else {
        setState(() {});
      }
    });
  }

  Widget build(BuildContext context) {
    return new Center(
        child: new AnimatedContainer(
            duration: const Duration(milliseconds: 1500),
            margin: new EdgeInsets.symmetric(vertical: 10.0),
            height: size,
            width: size,
            child: new Image.network(kLogoUrl)));
  }
}

void main() {
  runApp(new LogoApp());
}
