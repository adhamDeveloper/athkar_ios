import 'package:athkar_tasbeh_sound/screens/home_screen.dart';
import 'package:athkar_tasbeh_sound/screens/splash_screen.dart';
import 'package:athkar_tasbeh_sound/screens/who_screen.dart';
import 'package:athkar_tasbeh_sound/widgets/data_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void initializeData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString('dataList');

  if (jsonString == null) {
    await DataList.saveItems(DataList.allListAthkar);
  }
}
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash_screen',
      routes: {
        '/splash_screen': (context) => SplashScreen(),
        '/home_screen': (context) => HomeScreen(),
        '/who_screen': (context) => WhoScreen(),

      },
    );
  }

}
