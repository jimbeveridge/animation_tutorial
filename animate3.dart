// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Demonstrate a repeating animation

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

const kLogoUrl =
    "https://raw.githubusercontent.com/dart-lang/logos/master/logos_and_wordmarks/dart-logo.png";

class LogoApp extends AnimatedComponent {
  LogoApp({Key key, Animation<double> animation})
      : super(key: key, animation: animation);

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
  final AnimationController controller =
      new AnimationController(duration: const Duration(milliseconds: 2000));
  final Animation<double> animation =
      new Tween(begin: 0.0, end: 300.0).animate(controller)..addStatusListener((state) => print("$state") );
  animation.addStatusListener((status) {
    if (status == AnimationStatus.completed) controller.reverse();
    else if (status == AnimationStatus.dismissed) controller.forward();
  });

  runApp(new LogoApp(animation: animation));
  controller.forward();
}
