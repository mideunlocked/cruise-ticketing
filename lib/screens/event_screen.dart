import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  static const routeName = "/EventScreen";

  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  Map<String, dynamic> data = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(data["name"] ?? ""),
      ),
    );
  }
}
