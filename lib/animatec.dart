// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Demonstrate a repeating animation

import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const kLogoUrl =
    "https://raw.githubusercontent.com/dart-lang/logos/master/logos_and_wordmarks/dart-logo.png";

final SpringDescription _kSpringDesc = new SpringDescription.withDampingRatio(
    mass: 15.0, springConstant: 0.2, ratio: 1.1);

/// A spring force with reasonable default values.
final SpringForce kSpringForce = new SpringForce(_kSpringDesc);

///
/// SizeSeekingContainer
///
class SizeSeekingContainer extends StatefulComponent {
  final Widget child;
  final FractionalOffset align;

  const SizeSeekingContainer(
      {Key key, this.child, this.align: const FractionalOffset(0.5, 0.5)})
      : super(key: key);

  SizeSeekingContainerState createState() => new SizeSeekingContainerState();
}

class SizeSeekingContainerState extends State<SizeSeekingContainer> {
  final outerKey = new GlobalKey();
  final AnimationController controller = new AnimationController();
  final SizeTween tween =
      new SizeTween(begin: Size.zero, end: new Size(1.0, 1.0));
  Animation<Size> animation;

  SizeSeekingContainerState() {
    controller
      ..addListener(() {
        setState(() {});
      });
    animation = tween.animate(controller);
    controller.fling(velocity: 2.0, force: kSpringForce);
  }

  Widget build(BuildContext context) {
    RenderBox rb = outerKey.currentContext?.findRenderObject();
    if (rb?.size != null && rb?.size != tween.end) {
      tween.begin = tween.end;
      tween.end = rb.size;
      controller.value = 0.0;
      controller.fling(velocity: 2.0, force: kSpringForce);
      print(
          "========== CALLED FLING ${tween.begin.width},${tween.begin.height}");
      print("========== CALLED FLING ${tween.end.width},${tween.end.height}");
    }

    print(
        "++++ BUILD BUILD BUILD  ${animation.value.width},${animation.value.height}");
    final widgets = new Container(
        key: outerKey,
        child: new Align(
            alignment: config.align,
            child: new SizedBox(
                height: animation.value.height,
                width: animation.value.width,
                child: config.child)));
    return (controller.value == 0.0) ? new OffStage(child: widgets) : widgets;
  }
}

///
/// LogoApp
///
class LogoApp extends StatefulComponent {
  LogoApp({Key key}) : super(key: key);

  LogoAppState createState() => new LogoAppState();
}

class LogoAppState extends State<LogoApp> {
  static double size = 300.0;

  Widget build(BuildContext context) {
    print("++++");
    return new SizeSeekingContainer(
        align: const FractionalOffset(0.5, 0.0),
        child: new Container(
            margin: new EdgeInsets.symmetric(vertical: 10.0),
            child: new Image.network(kLogoUrl)));
  }
}

void main() {
  runApp(new LogoApp());
}
