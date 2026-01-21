import 'package:flashback/components/flashback_display.dart';
import 'package:flashback/models/flashback.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlashbacksDisplay extends StatefulWidget {
  List<Flashback> flashbacks;

  FlashbacksDisplay({super.key, required this.flashbacks});

  @override
  State<StatefulWidget> createState() {
    return _FlashbacksDisplayState();
  }
}

class _FlashbacksDisplayState extends State<FlashbacksDisplay> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.flashbacks.length,
      itemBuilder: (ctx, index) {
        Flashback flashback = widget.flashbacks[index];

        return FlashbackDisplay(flashback: flashback);
      },
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10),
    );
  }
}
