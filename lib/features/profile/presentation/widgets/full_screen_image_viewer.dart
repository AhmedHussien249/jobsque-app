import 'package:flutter/material.dart';

class FullScreenImageViewer extends StatelessWidget {
  final ImageProvider imageProvider;
  const FullScreenImageViewer({super.key, required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          // for zooming and panning
          child: Image(image: imageProvider),
        ),
      ),
    );
  }
}
