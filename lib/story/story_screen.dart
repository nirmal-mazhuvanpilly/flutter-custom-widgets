import 'package:flutter/material.dart';
import 'package:limoverse_widgets/story/story.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          children: const [
            Story(
              sections: 10,
              startingAngle: 0,
              strokeWidth: 4,
              size: 150,
            ),
            SizedBox(width: 10),
            Story(),
            SizedBox(width: 10),
            Story(),
            SizedBox(width: 10),
            Story(),
            SizedBox(width: 10),
            Story(),
          ],
        ),
      ),
    );
  }
}
