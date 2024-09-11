import 'package:flutter/material.dart';
import 'views/google_maps_view.dart';

void main() {
  runApp(const RouteTracke());
}

class RouteTracke extends StatelessWidget {
  const RouteTracke({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleMapsView(),
    );
  }
}

