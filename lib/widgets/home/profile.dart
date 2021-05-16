import 'package:flutter/material.dart';

import '../favorites_button.dart';

/// Displays the page with user profile details.
class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final isLight = theme.brightness == Brightness.light;
    final isPortrait = mediaQuery.orientation == Orientation.portrait;
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      physics: const BouncingScrollPhysics(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FavoritesButton(
              isFavorite: true
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CircleAvatar(
                radius: 40.0,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
            ),
            Icon(
              Icons.settings_outlined,
              color: Colors.grey,
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        const Text(
          'Natalia Lebediva',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        isPortrait
            ? Column(
                children: [
                  buildTopPart(isLight),
                  buildBottomPart(isLight),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: mediaQuery.size.width * 0.48,
                    child: buildTopPart(isLight),
                  ),
                  SizedBox(
                    width: mediaQuery.size.width * 0.48,
                    child: buildBottomPart(isLight),
                  ),
                ],
              ),
      ],
    );
  }

  /// Displays card with states represented in graphical format.
  Container buildBottomPart(bool isLight) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.all(7.5),
      decoration: BoxDecoration(
        color: Colors.grey[isLight ? 200 : 800],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Stats',
                style: TextStyle(fontSize: 25.0),
              ),
              const Spacer(),
              const Text(
                'Last Week',
                style: TextStyle(fontSize: 14.0),
              ),
              const Icon(Icons.keyboard_arrow_down_rounded),
            ],
          ),
          buildStats(
            Colors.indigoAccent,
            ' Practices',
            ' 0:43:05',
          ),
          buildStats(
            const Color(0xFFFB9B9C),
            ' Meditations',
            ' 0:15:45',
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildChartBar(1, 0.0, 1, 1.0, 'Mon'),
              buildChartBar(1, 0.0, 9, 1.0, 'Tue'),
              buildChartBar(1, 0.6, 1, 0.6, 'Wed'),
              buildChartBar(1, 0.3, 1, 0.3, 'Thu'),
              buildChartBar(1, 0.0, 2, 0.8, 'Fri'),
              buildChartBar(1, 0.7, 2, 0.7, 'Sat'),
              buildChartBar(1, 0.6, 1, 0.4, 'Sun'),
            ],
          ),
        ],
      ),
    );
  }

  /// Displays element of bar chart.
  Container buildChartBar(int meditationFlex, double meditationFraction,
      int practiceFlex, double practiceFraction, String day) {
    return Container(
      height: 100.0,
      width: 40.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              width: 6.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    flex: meditationFlex,
                    child: FractionallySizedBox(
                      heightFactor: meditationFraction,
                      child: Container(color: const Color(0xFFFB9B9C)),
                    ),
                  ),
                  Flexible(
                    flex: practiceFlex,
                    child: FractionallySizedBox(
                      heightFactor: practiceFraction,
                      child: Container(color: Colors.indigoAccent),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            day,
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }

  /// Displays card with states represented in text format.
  Container buildTopPart(bool isLight) {
    return Container(
      margin: const EdgeInsets.all(7.5),
      child: Column(
        children: [
          buildContainer(
            isLight,
            Colors.indigoAccent,
            Icons.menu_book_outlined,
            ' Practices',
            '13',
            '4:23:04',
          ),
          const SizedBox(height: 15.0),
          buildContainer(
            isLight,
            const Color(0xFFFB9B9C),
            Icons.self_improvement_rounded,
            ' Meditations',
            '6',
            '0:55:04',
          ),
        ],
      ),
    );
  }

  FractionallySizedBox buildStats(Color color, String title, String time) {
    return FractionallySizedBox(
      widthFactor: 0.6,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 5.0,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13.0,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.access_time_rounded,
            color: Colors.grey,
            size: 15.0,
          ),
          Text(
            time,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Container buildContainer(bool isLight, Color color, IconData icon,
      String title, String sessions, String time) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.grey[isLight ? 200 : 800],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color,
                child: Icon(icon, color: Colors.white),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 25.0),
              ),
            ],
          ),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Sessions  ',
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Text(
                          sessions,
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ),
                    ],
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: 'Time  ',
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Text(
                          time,
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ),
                    ],
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
