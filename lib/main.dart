import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/player.dart';
import 'screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Player(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meditation',
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
          accentColor: Colors.blueAccent,
          textTheme: GoogleFonts.poppinsTextTheme(),
          appBarTheme: appBarTheme(true),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.blueAccent,
          accentColor: Colors.blueAccent,
          appBarTheme: appBarTheme(false),
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }

  AppBarTheme appBarTheme(bool isLight) {
    return AppBarTheme(
      elevation: 0.0,
      centerTitle: true,
      color: Colors.transparent,
      iconTheme: const IconThemeData(size: 25.0),
      actionsIconTheme: const IconThemeData(
        size: 30.0,
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 25.0,
          color: isLight ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
