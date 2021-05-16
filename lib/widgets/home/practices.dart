import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/meditation_track.dart';
import '../../providers/player.dart';
import '../category_item.dart';
import '../meditation_item.dart';

/// Displays all practices available.
class Practices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Container(
          height: 250.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 5.0,
            ),
            children: [
              CategoryItem(
                aspectRatio: 3 / 2,
                showFavorite: true,
                image: 'assets/images/Card 2.png',
                title: 'Mental Training\n',
                subtitle: 'Turn down the stress\nvolume',
                subtitle1: '\n7 steps | 5-11 min',
              ),
              CategoryItem(
                aspectRatio: 3 / 2,
                showFavorite: true,
                image: 'assets/images/anxiety_1.png',
                title: 'Anxiety\n',
                subtitle: 'Turn down the stress\nvolume',
                subtitle1: '5 steps | 5-11 min',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: const Text(
            'All Practices',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('Meditations').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildEmptyPage();
            } else {
              final docs = snapshot.data.docs;
              return docs.isEmpty
                  ? buildEmptyPage()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final doc = docs[index];
                        return InkWell(
                          onTap: () {
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
                      separatorBuilder: (context, index) => const Divider(),
                    );
            }
          },
        ),
      ],
    );
  }

  /// Returns page to show when no practices are available.
  Widget buildEmptyPage() {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 4 / 3,
          child: Image.asset(
            'assets/images/meditation.png',
          ),
        ),
        const Text(
          'Practices will appear here!!',
          textAlign: TextAlign.center,
          softWrap: true,
        ),
      ],
    );
  }
}
