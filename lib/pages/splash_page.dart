import 'package:flutter/material.dart';
import 'package:intermediate_mobile_amcc24/routes/router.dart';
import 'dart:async';

import '../shared/themes/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        router.goNamed(Routenames.login);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Image.asset(
          "lib/shared/assets/amcc-logo.png",
          width: 120,
          height: 120,
        ),
      ),
    );
  }
}
