import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class EventDetailsService {
  static const String baseUrl =
      'https://sde-007.api.assignment.theinternetfolks.works/v1/event';

  Future<Event> fetchEventDetails(int eventId) async {
    final url = Uri.parse('$baseUrl/$eventId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return Event.fromJson(parsed['content']['data']);
    } else {
      throw Exception('Failed to load event details');
    }
  }
}
