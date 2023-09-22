import 'package:flutter/material.dart';
import '../models/event_model.dart';

class SearchEventCard extends StatelessWidget {
  final Event event;

  const SearchEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    String formattedDateTime = event.formattedDateTime();
    return Container(
      height: isTablet ? 122 : 112,
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
            width: isTablet ? 110 : 100,
            height: isTablet ? 112 : 105,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                    image: NetworkImage(event.bannerImage), fit: BoxFit.fill)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(formattedDateTime,
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(
                  height: 3,
                ),
                Text(event.title, style: Theme.of(context).textTheme.headline3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
