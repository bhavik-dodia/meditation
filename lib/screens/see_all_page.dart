import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meditation_track.dart';
import '../providers/player.dart';
import '../widgets/meditation_item.dart';

/// Displays a page with list of all the meditation tracks available.
class SeeAllPage extends StatelessWidget {
  final String title;

  const SeeAllPage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('Meditations').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildEmptyPage(isPortrait);
          } else {
            final docs = snapshot.data.docs;
            return docs.isEmpty
                ? buildEmptyPage(isPortrait)
                : Container(
                    color: theme.dividerColor,
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowGlow();
                        return;
                      },
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          childAspectRatio: 4 / 0.8,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                          maxCrossAxisExtent: 500.0,
                        ),
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final doc = docs[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              Provider.of<Player>(context, listen: false)
                                  .showMiniPlayer();
                            },
                            child: MeditationItem(
                              imgNo: index % 5,
                              track: MeditationTrack.fromJson(
                                doc.data(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
          }
        },
      ),
    );
  }

  /// Returns page to show when no meditation tracks are available.
  Widget buildEmptyPage(bool isPortrait) {
    return Column(
      children: [
        Expanded(
          child: isPortrait
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buildChildren,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: buildChildren,
                ),
        ),
      ],
    );
  }

  List<Widget> get buildChildren {
    return [
      AspectRatio(
        aspectRatio: 4 / 3,
        child: Image.asset(
          'assets/images/meditation.png',
        ),
      ),
      const Text(
        'Meditation tracks will appear here!!',
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    ];
  }
}
