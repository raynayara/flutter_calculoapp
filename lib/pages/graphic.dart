import 'package:flutter/material.dart';

class GraphicPage extends StatefulWidget {
  @override
  State<GraphicPage> createState() => _GraphicPageState();
}

class _GraphicPageState extends State<GraphicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Graphic Page'),
      ),
      body: Container(
        child: Center(
          child: Text(
            'Welcome to the Graphic Page!',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}