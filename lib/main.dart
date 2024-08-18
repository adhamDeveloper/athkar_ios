import 'package:athkar_tasbeh_sound/pref/sharedprefrenace_language.dart';
import 'package:athkar_tasbeh_sound/provider/language_provider.dart';
import 'package:athkar_tasbeh_sound/screens/home_screen.dart';
import 'package:athkar_tasbeh_sound/screens/splash_screen.dart';
import 'package:athkar_tasbeh_sound/screens/who_screen.dart';
import 'package:athkar_tasbeh_sound/widgets/data_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void initializeData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString('dataList');

  if (jsonString == null) {
    await DataList.saveItems(DataList.allListAthkar);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeData();
  await SharedPrefController().initPref();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageProvider>(
      create: (context) => LanguageProvider(),
      child: MyMaterialApp(),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(Provider.of<LanguageProvider>(context).language),
      initialRoute: '/splash_screen',
      routes: {
        '/splash_screen': (context) => SplashScreen(),
        '/home_screen': (context) => HomeScreen(),
        '/who_screen': (context) => WhoScreen(),
      },
    );
  }
}
