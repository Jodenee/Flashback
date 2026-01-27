import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flashback/models/flashback.dart';
import 'package:flashback/pages/add_flashback_page.dart';
import 'package:flashback/pages/view_flashbacks_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(FlashbackAdapter());

  Box<Flashback> flashbackStore = await Hive.openBox(
    "flashbackStore",
  );

  runApp(MainApp(flashbackStore: flashbackStore));
}

// ignore: must_be_immutable
class MainApp extends StatefulWidget {
  Box<Flashback> flashbackStore;

  MainApp({super.key, required this.flashbackStore});

  @override
  State<StatefulWidget> createState() {
    return _MainAppState();
  }
}

class _MainAppState extends State<MainApp> {
  String currentPage = "ViewFlashbacksPage";
  late List<Flashback> flashbacks = widget.flashbackStore.values
      .whereType<Flashback>()
      .toList();
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void _switchPage(String page) {
    setState(() {
      currentPage = page;
    });
  }

  Future<void> _addFlashback(Flashback flashback) async {
    analytics.logEvent(name: "AddFlashback", parameters: {
      "Flashback": {
        "text": flashback.text,
        "latitude": flashback.latitude,
        "longitude": flashback.longitude
      }
    });
    await widget.flashbackStore.add(flashback);

    setState(() {
      flashbacks.add(flashback);
    });
  }

  Future<void> _removeFlashback(Flashback flashback) async {
    analytics.logEvent(name: "RemoveFlashback", parameters: {
      "Flashback": {
        "text": flashback.text,
        "latitude": flashback.latitude,
        "longitude": flashback.longitude
      }
    });
    await flashback.delete();

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
                  removeFlashback: _removeFlashback,
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
