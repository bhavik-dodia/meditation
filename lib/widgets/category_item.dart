import 'package:flutter/material.dart';
import 'package:meditation/widgets/favorites_button.dart';
import 'package:provider/provider.dart';

import '../providers/player.dart';

class CategoryItem extends StatelessWidget {
  final String title, subtitle, subtitle1, image;
  final double aspectRatio;
  final bool showFavorite;

  const CategoryItem({
    Key key,
    this.title,
    this.subtitle,
    this.subtitle1,
    this.image,
    this.aspectRatio,
    this.showFavorite,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Provider.of<Player>(context, listen: false).showMiniPlayer,
      child: Card(
        elevation: 8.0,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0),
        ),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: title,
                    children: [
                      TextSpan(
                        text: '\n$subtitle',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: '\n\n$subtitle1',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ],
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Visibility(
                  visible: showFavorite,
                  child: const FavoritesButton(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
