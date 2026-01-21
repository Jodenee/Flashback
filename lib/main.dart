import 'package:flashback/models/flashback.dart';
import 'package:flashback/pages/add_flashback_page.dart';
import 'package:flashback/pages/view_flashbacks_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainApp();
  }
}

class _MainApp extends State<MainApp> {
  String currentPage = "ViewFlashbacksPage";
  List<Flashback> flashbacks = [
    Flashback(
      text: "eee",
      latitude: 35.86617738480747,
      longitude: 14.517315815810383,
    ),
  ];

  void _switchPage(String page) {
    setState(() {
      currentPage = page;
    });
  }

  void _addFlashback(Flashback flashback) {
    setState(() {
      flashbacks.add(flashback);
    });
  }

  void _removeFlashback(Flashback flashback) {
    setState(() {
      flashbacks.remove(flashback);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("Flashback")),

        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
          child: currentPage == "ViewFlashbacksPage"
              ? ViewFlashbacksPage(
                  switchPage: _switchPage,
                  flashbacks: flashbacks,
                )
              : AddFlashbackPage(
                  switchPage: _switchPage,
                  addFlashback: _addFlashback,
                ),
        ),
      ),
    );
  }
}
