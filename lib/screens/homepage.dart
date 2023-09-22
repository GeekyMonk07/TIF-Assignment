import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/event_model.dart';
import '../services/event_api.dart';
import '../services/fetch_event_details.dart';
import '../widgets/event_card.dart';
import 'event_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final EventApiService _eventApiService = EventApiService();
  late Future<List<Event>> _futureEvents;

  @override
  void initState() {
    super.initState();
    _futureEvents = _eventApiService.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              width: isTablet ? 30 : 24,
              height: isTablet ? 30 : 24,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/more-vertical.svg',
              width: isTablet ? 28 : 22,
              height: isTablet ? 28 : 22,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<Event>>(
        future: _futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No events available.'));
          } else {
            final events = snapshot.data;
            return ListView.builder(
              itemCount: events!.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return InkWell(
                    onTap: () => _navigateToEventDetails(event.id),
                    child: EventCard(event: event));
              },
            );
          }
        },
      ),
    );
  }

  void _navigateToEventDetails(int eventId) {
    final eventApiService = EventDetailsService();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EventDetailsScreen(apiService: eventApiService, eventId: eventId),
      ),
    );
  }
}
