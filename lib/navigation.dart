import 'package:flutter/material.dart';
import 'package:sic_management_app/screens/home/home_screen.dart';
import 'package:sic_management_app/screens/map/map_screen.dart';
import 'package:sic_management_app/screens/report/report_screen.dart';
import 'package:sic_management_app/services/app_localization.dart';
import './theme/app_bar_theme.dart' as appbar;

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int index = 0;

  final List<Icon> bottomNavigationBarIcon = const [
    Icon(Icons.home_outlined),
    Icon(Icons.map_outlined),
    Icon(Icons.report),
  ];

  final appBar = appbar.AppBarTheme.appBar();
  @override
  Widget build(BuildContext context) {
    final List<String> bottomNavigationBarTitle = [
      AppLocalizations.of(context)!.translate('home'),
      AppLocalizations.of(context)!.translate('map'),
      AppLocalizations.of(context)!.translate('report'),
    ];

    final List<Widget> content = [
      const HomeScreen(),
      const MapScreen(),
      const ReportScreen()
    ];
    return Scaffold(
      body: content[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });
        },
        destinations: [
          ...List.generate(
            content.length,
            (index) => NavigationDestination(
                icon: bottomNavigationBarIcon[index],
                label: bottomNavigationBarTitle[index]),
          ).toList()
        ],
      ),
    );
  }
}
