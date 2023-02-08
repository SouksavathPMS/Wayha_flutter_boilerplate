import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:sic_management_app/navigation.dart';
import 'package:sic_management_app/providers/user_provider.dart';
import 'package:sic_management_app/services/app_language.dart';
import 'package:sic_management_app/services/app_localization.dart';
import 'package:sic_management_app/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();

  await appLanguage.fetchLocale();
  await dotenv.load(fileName: ".env");
  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatelessWidget {
  final AppLanguage? appLanguage;

  const MyApp({super.key, required this.appLanguage});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => appLanguage),
        ChangeNotifierProvider.value(value: UserProvider()),
      ],
      child: Consumer<AppLanguage>(
        builder: (context, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: value.appLocal,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('lo', 'LA'),
            Locale('zh', 'CN'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            FormBuilderLocalizations.delegate,
          ],
          title: 'Kye boilerplate',
          theme: AppTheme.theme,
          home: const Navigation(),
        ),
      ),
    );
  }
}
