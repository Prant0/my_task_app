import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habiba_task_manager/features/dashboard/views/dashboard_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => const DashboardPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/logo.png', width: 120, height: 120),
      ),
    );
  }
}
