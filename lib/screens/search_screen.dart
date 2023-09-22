import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:tif_assignment/constants.dart';
import 'package:tif_assignment/services/search_service.dart';

import '../models/event_model.dart';
import '../services/fetch_event_details.dart';
import '../widgets/search_event_card.dart';
import 'event_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Event> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: 24,
                  height: 24,
                  color: primaryBlue,
                ),
                const SizedBox(
                  width: 13,
                ),
                Container(
                  height: 26,
                  width: 1,
                  color: const Color(0xff7974E7),
                ),
                const SizedBox(
                  width: 13,
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      _searchEvents(value);
                    },
                    style: const TextStyle(fontSize: 20.0),
                    controller: _searchController,
                    showCursor: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type Event Name',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.3),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchResults.isEmpty) {
      if (_searchController.text.isEmpty) {
        return const Center(
          child: Text(
            'Search for events',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    } else {
      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final event = searchResults[index];
          return InkWell(
              onTap: () => _navigateToEventDetails(event.id),
              child: SearchEventCard(event: event));
        },
      );
    }
  }

  void _searchEvents(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults.clear();
      });
      return;
    }
    try {
      final events = await SearchService.searchEvents(query);
      setState(() {
        searchResults = events;
      });
    } catch (error) {
      // print(error);
    }
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
