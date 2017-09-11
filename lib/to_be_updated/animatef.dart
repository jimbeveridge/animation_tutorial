// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Demonstrate a factored animation with AnimatedBuilder

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

const kLogoUrl =
    "https://raw.githubusercontent.com/dart-lang/logos/master/logos_and_wordmarks/dart-logo.png";

class LogoWidget extends StatelessComponent {
  // Leave out the height and width so it fills the animating parent
  build(BuildContext context) {
    return new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        child: new Image.network(kLogoUrl));
  }
}

class GrowTransition extends StatelessComponent {
  GrowTransition({this.child, this.animation});

  Widget child;
  Animation<double> animation;

  Widget build(BuildContext context) {
    return new AnimatedBuilder(animation: animation,
        builder: (BuildContext context, Widget child) {
      return new Center(
          child: new Container(
              height: animation.value, width: animation.value, child: child));
    }, child: child);
  }
}

class LogoApp extends StatefulComponent {
  LogoAppState createState() => new LogoAppState();
}

class LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation animation;

  initState() {
    super.initState();
    final AnimationController controller =
        new AnimationController(duration: const Duration(milliseconds: 2000),
            vsync: this);
    final CurvedAnimation curve =
        new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = new Tween(begin: 0.0, end: 300.0).animate(curve);
    controller.forward();
  }

  Widget build(BuildContext context) {
    return new GrowTransition(child: new LogoWidget(), animation: animation);
  }
}

void main() {
  runApp(new LogoApp());
}
