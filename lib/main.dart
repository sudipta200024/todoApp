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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ToDoProviderTaskNumbers()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case "/todo":
                  return MaterialPageRoute(builder: (_) => TodoScreen());
                case "/calculator":
                  return MaterialPageRoute(builder: (_) => CalculatorScreen());
                case "/counter":
                  return MaterialPageRoute(builder: (_) => CounterScreen());
                default:
                  return MaterialPageRoute(
                    builder: (_) => Scaffold(
                      body: Center(child: Text("No page found")),
                    ),
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
            themeMode: themeProvider.themeMode, // ← Now uses the provider!
          );
        },
      ),
    );
  }
}