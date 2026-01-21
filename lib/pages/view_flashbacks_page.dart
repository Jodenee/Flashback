import 'package:flashback/components/flashbacks_display.dart';
import 'package:flashback/models/flashback.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewFlashbacksPage extends StatelessWidget {
  final void Function(String) switchPage;
  List<Flashback> flashbacks;

  ViewFlashbacksPage({super.key, required this.switchPage, required this.flashbacks});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 18,
      children: [
        Expanded(child: FlashbacksDisplay(flashbacks: flashbacks)),
        ElevatedButton.icon(
          onPressed: () => switchPage("AddFlashbackPage"),
          label: Text("Create Flashback"),
          icon: Icon(Icons.add),
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.all(18)),
          ),
        ),
      ],
    );
  }
}
