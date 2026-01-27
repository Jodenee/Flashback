import 'package:flashback/components/flashback_display.dart';
import 'package:flashback/models/flashback.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlashbacksDisplay extends StatefulWidget {
  List<Flashback> flashbacks;
  final Future<void> Function(Flashback) removeFlashback;

  FlashbacksDisplay({
    super.key,
    required this.flashbacks,
    required this.removeFlashback,
  });

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
        final Flashback flashback = widget.flashbacks[index];

        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) async {
            await widget.removeFlashback(flashback);
          },
          child: FlashbackDisplay(flashback: flashback),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10),
    );
  }
}
