import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/theme/colors.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2500), (){
      Navigator.popUntil(context, ModalRoute.withName("/"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.kScaffoldColor,
      child: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Lottie.asset(
            "assets/animations/check_org.json",
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
