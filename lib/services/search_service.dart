import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class SearchService {
  static Future<List<Event>> searchEvents(String query) async {
    final apiUrl =
        'https://sde-007.api.assignment.theinternetfolks.works/v1/event?search=$query';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          final data = jsonResponse['content']['data'] as List<dynamic>;
          final List<Event> events = data.map((eventData) {
            return Event(
              id: eventData['id'],
              title: eventData['title'],
              description: eventData['description'],
              bannerImage: eventData['banner_image'],
              dateTime: eventData['date_time'],
              organiserName: eventData['organiser_name'],
              organiserIcon: eventData['organiser_icon'],
              venueName: eventData['venue_name'],
              venueCity: eventData['venue_city'],
              venueCountry: eventData['venue_country'],
            );
          }).toList();

          final filteredEvents = events.where((event) =>
              event.title.toLowerCase().contains(query.toLowerCase()) ||
              event.description.toLowerCase().contains(query.toLowerCase()) ||
              event.venueName.toLowerCase().contains(query.toLowerCase()) ||
              event.organiserName.toLowerCase().contains(query.toLowerCase()));

          return filteredEvents.toList();
        } else {
          // Handle API error
          throw Exception('API request failed');
        }
      } else {
        // Handle non-200 HTTP status code
        throw Exception(
            'HTTP request failed with status ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions that occurred during the HTTP request
      throw Exception('Error: $error');
    }
  }
}
