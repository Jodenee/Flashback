import 'package:flashback/models/flashback.dart';
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

  void _onSubmit() async {
    String content = _contentController.text;

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
                onPressed: _onSubmit,
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
