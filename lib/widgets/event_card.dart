import 'package:flutter/material.dart';
import 'package:tif_assignment/constants.dart';
import '../models/event_model.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    String formattedDateTime = event.formattedDateTime();
    return Container(
      height: isTablet ? 120 : 106,
      width: isTablet ? 520 : 320,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(87, 92, 138, 0.06),
            offset: Offset(0, 10),
            blurRadius: 35,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: isTablet ? 100 : 80,
            height: isTablet ? 100 : 96,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                image: NetworkImage(event.bannerImage),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(formattedDateTime,
                    style: Theme.of(context).textTheme.bodyText1),
                Text(event.title, style: Theme.of(context).textTheme.headline1),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: typographySub),
                    Flexible(
                      child: Text('${event.venueName} • ${event.venueCity}',
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
