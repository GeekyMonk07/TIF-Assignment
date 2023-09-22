import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class EventApiService {
  static const String baseUrl =
      'https://sde-007.api.assignment.theinternetfolks.works/v1/event';

  Future<List<Event>> fetchEvents() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      final eventsData = parsed['content']['data'] as List<dynamic>;
      return eventsData.map<Event>((data) => Event.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}
