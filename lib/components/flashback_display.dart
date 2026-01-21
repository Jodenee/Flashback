import 'package:flashback/models/flashback.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
        color: Colors.indigoAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(widget.flashback.text)),
              IconButton(
                onPressed: () async {
                  bool success = await _launchMapsUrl(
                    widget.flashback.latitude,
                    widget.flashback.longitude,
                  );

                  if (!success) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Failed to open google maps"),
                        content: const Text(
                          "Something went wrong while opening google maps.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, "Ok"),
                            child: const Text("Ok"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                icon: Icon(Icons.location_on),
              ),
            ],
          ),
          Text(
            "Distance From: 2m",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
