// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Demonstrate a simple animation with AnimatedComponent

import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'opacity_container.dart';

const kLogoUrl =
    "https://raw.githubusercontent.com/dart-lang/logos/master/logos_and_wordmarks/dart-logo.png";

class LogoApp extends StatelessComponent {
  LogoApp({Key key, this.opacity, this.size}) : super(key: key);

  final double opacity;
  final double size;

  Widget build(BuildContext context) {
    print("++++++++ build");
    return new Center(
        child: new Container(
            margin: new EdgeInsets.symmetric(vertical: 10.0),
            height: size,
            width: size,
            child: new AnimatedOpacityContainer(
                duration: const Duration(seconds: 4),
                opacity: 1.0,
                child: new Image.network(kLogoUrl))));
  }
}

void main() {
  runApp(new LogoApp(opacity: 0.0));
  new Timer(new Duration(seconds: 2), () => runApp(new LogoApp(opacity: 1.0)));
}
