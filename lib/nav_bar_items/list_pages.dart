import 'package:flutter/cupertino.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('List page')
      ),
    );
  }
}