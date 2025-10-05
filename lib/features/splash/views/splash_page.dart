import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habiba_task_manager/app_theme.dart';
import 'package:habiba_task_manager/features/dashboard/views/dashboard_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            Image.asset('assets/images/logo.png', width: 120, height: 120),

            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.text.withValues(alpha: 0.8),
                size: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
