import 'package:flutter/material.dart';
import 'package:tif_assignment/screens/event_details.dart';
import 'package:tif_assignment/screens/homepage.dart';
import 'package:tif_assignment/screens/search_screen.dart';
import 'package:tif_assignment/services/fetch_event_details.dart';
import 'package:tif_assignment/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final eventApiService = EventDetailsService();
    return MaterialApp(
      theme: customTheme,
      // home: const HomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/event_details': (context) =>
            EventDetailsScreen(apiService: eventApiService, eventId: 1),
        '/search': (context) => const SearchScreen(),
      },
    );
  }
}
