import 'package:flutter/material.dart';

import '../../screens/see_all_page.dart';
import '../category_item.dart';

/// Displays the main home screen with meditation categories.
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowGlow();
        return;
      },
      child: ListView(
        children: [
          SizedBox(
            height: mediaQuery.size.height * (isPortrait ? 0.4 : 0.7),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 25.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D31AC),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(25.0)),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    'assets/images/nature_1.png',
                    scale: 3,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/images/nature_2.png',
                    scale: 3,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    'assets/images/girl.png',
                    scale: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                  child: Text.rich(
                    TextSpan(
                      text: 'Day 7',
                      children: [
                        TextSpan(
                          text: '\nLove and Accept Yourself',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.indigo[100],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          buildCategoryHeading(context, 'Popular'),
          Container(
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 5.0,
              ),
              children: [
                CategoryItem(
                  aspectRatio: 1.78,
                  showFavorite: false,
                  image: 'assets/images/anxiety.png',
                  title: 'Anxiety',
                  subtitle: 'Turn down the stress\nvolume',
                  subtitle1: '7 steps | 5-11 min',
                ),
                CategoryItem(
                  aspectRatio: 1.78,
                  showFavorite: false,
                  image: 'assets/images/anxiety_1.png',
                  title: 'Anxiety',
                  subtitle: 'Turn down the stress\nvolume',
                  subtitle1: '5 steps | 5-11 min',
                ),
              ],
            ),
          ),
          buildCategoryHeading(context, 'New'),
          Container(
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 5.0,
              ),
              children: [
                CategoryItem(
                  aspectRatio: 1.78,
                  showFavorite: false,
                  image: 'assets/images/happiness.png',
                  title: 'Happiness',
                  subtitle: 'Daily Calm\n',
                  subtitle1: '7 steps | 3-11 min',
                ),
                CategoryItem(
                  aspectRatio: 1.78,
                  showFavorite: false,
                  image: 'assets/images/spiritual.png',
                  title: 'Spiritual',
                  subtitle: 'Daily Calm\n',
                  subtitle1: '5 steps | 6-11 min',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Displays header of the category.
  Padding buildCategoryHeading(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SeeAllPage(title: title),
              ),
            ),
            child: const Text(
              'See All',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: TextButton.styleFrom(
              primary: Colors.blueAccent,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
