import 'package:flutter/material.dart';
import 'package:sic_management_app/constants/constant_color.dart';

class MapScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const MapScreen(),
      );

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Map screen',
          style: TextStyle(color: ConstantColors.primary),
        ),
      ),
    );
  }
}
