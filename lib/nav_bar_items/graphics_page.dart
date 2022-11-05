import 'package:flutter/cupertino.dart';

class GraphicPage extends StatefulWidget {
  const GraphicPage({super.key});

  @override
  State<GraphicPage> createState() => _GraphicPageState();
}

class _GraphicPageState extends State<GraphicPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Graphic page')),
    );
  }
}
