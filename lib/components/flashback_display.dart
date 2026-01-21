import 'package:flashback/models/flashback.dart';
import 'package:flashback/utility/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class FlashbackDisplay extends StatefulWidget {
  Flashback flashback;

  FlashbackDisplay({super.key, required this.flashback});

  @override
  State<StatefulWidget> createState() {
    return _FlashbackDisplayState();
  }
}

class _FlashbackDisplayState extends State<FlashbackDisplay> {
  Future<bool> _launchMapsUrl(double latitude, double longitude) async {
    final url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
    );

    if (!(await canLaunchUrl(url))) {
      return false;
    }

    await launchUrl(url);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.flashback.text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              bool success = await _launchMapsUrl(
                widget.flashback.latitude,
                widget.flashback.longitude,
              );

              if (!success && mounted) {
                await showInformationModal(
                  context, // ignore: use_build_context_synchronously
                  "Failed to open google maps",
                  "Something went wrong while opening google maps.",
                );
              }
            },
            icon: Icon(Icons.location_on),
          ),
        ],
      ),
    );
  }
}
