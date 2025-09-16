
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
      ),
      body: Center(
        child: InteractiveViewer( // يديك زووم و سحب
          child: Image(image: imageProvider),
        ),
      ),
    );
  }
}