import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tif_assignment/constants.dart';
import 'package:tif_assignment/widgets/custom_fab.dart';
import '../models/event_model.dart';
import '../services/fetch_event_details.dart';

class EventDetailsScreen extends StatefulWidget {
  final int eventId;
  final EventDetailsService apiService;

  const EventDetailsScreen(
      {super.key, required this.eventId, required this.apiService});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Event>(
      future: widget.apiService.fetchEventDetails(widget.eventId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('No data available');
        } else {
          final event = snapshot.data!;
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(220),
              child: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(event.bannerImage),
                            fit: BoxFit.cover)),
                  ),
                  title: const Text('Event Details'),
                  actions: <Widget>[
                    IconButton(
                      icon: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.black.withOpacity(0.3)),
                        child: const Icon(
                          Icons.bookmark_rounded,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/search');
                      },
                    ),
                  ]),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 60),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.title,
                          style: Theme.of(context).textTheme.headlineLarge),
                      const SizedBox(height: 22),
                      ListTile(
                        leading: Image.network(event.organiserIcon),
                        title: Text(event.organiserName,
                            style: Theme.of(context).textTheme.headline2),
                        subtitle: const Text(
                          'Organiser',
                        ),
                      ),
                      const SizedBox(height: 22),
                      InfoTile(
                          title: event.formattedDateTime(),
                          subtitle: event.formattedDateTime(),
                          icon: "calendar.svg"),
                      const SizedBox(height: 22),
                      InfoTile(
                          title: event.venueName,
                          subtitle: '${event.venueCity}, ${event.venueCountry}',
                          icon: "location.svg"),
                      const SizedBox(height: 22),
                      Text("About Event",
                          style: Theme.of(context).textTheme.headline3),
                      const SizedBox(height: 16),
                      if (event.description.length > 200 && !isExpanded)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded = true;
                            });
                          },
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        '${event.description.substring(0, 200)}...',
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                                const TextSpan(
                                  text: ' Read More',
                                  style: TextStyle(
                                    color: primaryBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (event.description.length <= 200 || isExpanded)
                        Text(
                          event.description,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                    ]),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: const CustomFAB(),
          );
        }
      },
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  const InfoTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          padding: const EdgeInsets.all(8.0),
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: primaryBlue.withOpacity(0.1)),
          child: SvgPicture.asset(
            'assets/icons/$icon',
          )),
      title: Text(title, style: Theme.of(context).textTheme.headline2),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.subtitle2),
    );
  }
}
