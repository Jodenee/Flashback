import 'package:flashback/models/flashback.dart';
import 'package:flashback/utility/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AddFlashbackPage extends StatelessWidget {
  final void Function(String) switchPage;
  final void Function(Flashback) addFlashback;

  AddFlashbackPage({
    super.key,
    required this.switchPage,
    required this.addFlashback,
  });

  final TextEditingController _contentController = TextEditingController();

  void _onSubmit(BuildContext context) async {
    String content = _contentController.text;

    if (content.length <= 5) {
      await showInformationModal(
        context, // ignore: use_build_context_synchronously
        "Invalid Input",
        "Content must be at least 5 characters long.",
      );
      return;
    }

    LocationPermission locationPermission = await Geolocator.checkPermission();
    List<LocationPermission> requestForPermission = [
      LocationPermission.denied,
      LocationPermission.unableToDetermine
    ];
    List<LocationPermission> allowedPermission = [
      LocationPermission.always,
      LocationPermission.whileInUse
    ];

    if (requestForPermission.contains(locationPermission)) {
      locationPermission = await Geolocator.requestPermission();
    }

    if (!allowedPermission.contains(locationPermission)) {
      await showInformationModal(
        context, // ignore: use_build_context_synchronously
        "Can't get location...",
        "Could not obtain permission to use location, please make sure it is enabled.",
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    Flashback flashback = Flashback(
      text: content,
      latitude: position.latitude,
      longitude: position.longitude,
    );
    addFlashback(flashback);
    switchPage("ViewFlashbacksPage");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: "Content",
            hintText: "Message",
          ),
          autocorrect: true,
          controller: _contentController,
          validator: (String? value) {
            if (value == null) {
              return "Please enter a value";
            }

            if (value.length <= 5) {
              return "Content must contain more than 5 characters";
            }

            return null;
          },
        ),
        Row(
          spacing: 10,
          children: [
            ElevatedButton.icon(
              onPressed: () => switchPage("ViewFlashbacksPage"),
              label: Text("Back"),
              icon: Icon(Icons.arrow_back),
            ),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _onSubmit(context),
                label: Text("Add"),
                icon: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
