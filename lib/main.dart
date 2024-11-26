
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/text_repeater_model.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TextRepeaterModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TextStream',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}


// backgroundColor: const Color(0xFF0e7dfb),
// iconTheme: const IconThemeData(color: Colors.white),