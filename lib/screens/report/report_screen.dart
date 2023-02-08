import 'package:flutter/material.dart';
import 'package:sic_management_app/constants/constant_color.dart';

class ReportScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ReportScreen(),
      );

  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Report screen',
          style: TextStyle(color: ConstantColors.primary),
        ),
      ),
    );
  }
}
