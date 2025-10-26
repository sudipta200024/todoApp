import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoproviderapp/calculator_screen.dart';
import 'package:todoproviderapp/counter_screen.dart';
import 'package:todoproviderapp/custom_bottom_navbar.dart';
import 'package:todoproviderapp/theme_provider.dart';
import 'package:todoproviderapp/todo_provider.dart';
import 'package:todoproviderapp/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ToDoProviderTaskNumbers()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/todo":
              return MaterialPageRoute(builder: (context) => TodoScreen());
            case "/calculator":
              return MaterialPageRoute(
                builder: (context) => CalculatorScreen(),
              );
            case "/counter":
              return MaterialPageRoute(builder: (context) => CounterScreen());
            default:
              return MaterialPageRoute(
                builder:
                    (context) =>
                        Scaffold(body: Center(child: Text("No page found"))),
              );
          }
        },
        home: CustomBottomNavBar(),

        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black),
          ),
        ),

        // ✅ Dark Theme
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          primarySwatch: Colors.deepPurple,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          ),
        ),

        // ✅ Use system brightness to switch
        themeMode: _themeMode,
      ),
    );
  }
}
