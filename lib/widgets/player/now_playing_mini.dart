import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../../providers/player.dart';
import 'now_playing.dart';

/// Displays mini player with pause/play and close options.
class NowPlayingMini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.only(left: 15.0),
        decoration: BoxDecoration(
          color: Colors.indigoAccent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => NowPlaying(),
              ),
              child: const Icon(
                Icons.keyboard_arrow_up_rounded,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                const Text(
                  'Mental Training',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                const Spacer(),
                Consumer<Player>(
                  builder: (context, playerProvider, child) {
                    final player = playerProvider.player;
                    return StreamBuilder<PlayerState>(
                      stream: player.playerStateStream,
                      builder: (context, snapshot) {
                        final playerState = snapshot.data;
                        final processingState = playerState?.processingState;
                        final playing = playerState?.playing;
                        if (processingState == ProcessingState.loading ||
                            processingState == ProcessingState.buffering) {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            width: 30.0,
                            height: 30.0,
                            child: CircularProgressIndicator(),
                          );
                        } else if (playing != true) {
                          return IconButton(
                            icon: const Icon(
                              Icons.play_circle_outline_rounded,
                              color: Colors.white,
                            ),
                            iconSize: 30.0,
                            onPressed: player.play,
                          );
                        } else if (processingState !=
                            ProcessingState.completed) {
                          return IconButton(
                            icon: const Icon(
                              Icons.pause_circle_outline_rounded,
                              color: Colors.white,
                            ),
                            iconSize: 30.0,
                            onPressed: player.pause,
                          );
                        } else {
                          return IconButton(
                            icon: const Icon(
                              Icons.replay_rounded,
                              color: Colors.white,
                            ),
                            iconSize: 30.0,
                            onPressed: () => player.seek(
                              Duration.zero,
                              index: player.effectiveIndices.first,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 30.0,
                  onPressed: Provider.of<Player>(context, listen: false)
                      .closeMiniPlayer,
                ),
              ],
            ),
          ],
        ),
      ),
      onClosing: () {
        print('closing');
      },
    );
  }
}
