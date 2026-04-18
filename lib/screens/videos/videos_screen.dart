// screens/videos/videos_screen.dart
import 'package:flutter/material.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Icon(Icons.play_circle_fill, color: Colors.white, size: 40)),
              ),
            ),
            const SizedBox(height: 5),
            Text("Video Tutorial #${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold)),
            const Text("5:20 min", style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        );
      },
    );
  }
}