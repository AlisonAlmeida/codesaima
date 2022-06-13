import 'package:flutter/material.dart';

class PDFVisualizer extends StatefulWidget {
  PDFVisualizer({Key? key, required this.pdfPath}) : super(key: key);

  final String pdfPath;

  @override
  State<PDFVisualizer> createState() => _PDFVisualizerState();
}

class _PDFVisualizerState extends State<PDFVisualizer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.pdfPath),
      ),
    );
  }
}
