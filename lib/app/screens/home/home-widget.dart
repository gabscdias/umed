import 'package:flutter/material.dart';
import 'package:umed_v2/app/shared/widgets/sidedraw-widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDraw(),
      backgroundColor: Colors.websafe,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.websafe,
      ),
    );
  }
}
