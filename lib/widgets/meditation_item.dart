import 'package:flutter/material.dart';

import '../models/meditation_track.dart';
import 'favorites_button.dart';

/// Displays tile with meditation track information.
class MeditationItem extends StatelessWidget {
  final MeditationTrack track;
  final int imgNo;

  const MeditationItem({Key key, this.track, this.imgNo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).scaffoldBackgroundColor,
      leading: Container(
        width: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            image: AssetImage(
              'assets/images/Illustration_$imgNo.png',
            ),
          ),
        ),
      ),
      title: Text(track.title),
      subtitle: Text(track.duration),
      trailing: const FavoritesButton(),
    );
  }
}
