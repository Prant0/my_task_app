import 'package:flutter/material.dart';
import 'package:task_manager/common/widgets/custom_app_bar.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "About Us"),
    );
  }
}
