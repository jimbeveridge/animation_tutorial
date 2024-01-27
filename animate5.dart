// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Demonstrate an AnimatedComponent with multiple Tweens

import 'package:flutter/material.dart';

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // We can make the Tweens static because we don't change them.
  late Animation _opacityAnimation;
  late Animation _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object's value.
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          });

    _sizeAnimation = Tween<double>(begin: 0.0, end: 300.0).animate(_controller);
    _opacityAnimation =
        Tween<double>(begin: 0.3, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
          opacity: _opacityAnimation.value,
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              height: _sizeAnimation.value,
              width: _sizeAnimation.value,
              child: const FlutterLogo())),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(const LogoApp());
}
