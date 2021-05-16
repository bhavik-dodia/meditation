import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/position_data.dart';
import '../../providers/player.dart';
import '../favorites_button.dart';
import 'seekbar.dart';

/// Displays full screen player with pause/play/replay, close options along with slidable seekbar.
class NowPlaying extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height,
      width: mediaQuery.size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Mental Training.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30.0),
          AppBar(
            title: const Text(
              'Mental Training',
              style: TextStyle(color: Colors.white),
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                  Provider.of<Player>(context, listen: false).closeMiniPlayer();
                },
              ),
            ],
          ),
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const FavoritesButton(),
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
                          margin: EdgeInsets.all(8.0),
                          width: 60.0,
                          height: 60.0,
                          child: CircularProgressIndicator(),
                        );
                      } else if (playing != true) {
                        return IconButton(
                          icon: const Icon(
                            Icons.play_circle_outline_rounded,
                            color: Colors.white,
                          ),
                          iconSize: 60.0,
                          onPressed: player.play,
                        );
                      } else if (processingState != ProcessingState.completed) {
                        return IconButton(
                          icon: const Icon(
                            Icons.pause_circle_outline_rounded,
                            color: Colors.white,
                          ),
                          iconSize: 60.0,
                          onPressed: player.pause,
                        );
                      } else {
                        return IconButton(
                          icon: const Icon(
                            Icons.replay_rounded,
                            color: Colors.white,
                          ),
                          iconSize: 60.0,
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
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(
                  maxHeight: 40.0,
                  maxWidth: 40.0,
                  minHeight: 20.0,
                  minWidth: 20.0,
                ),
                iconSize: 26.0,
                icon: const Icon(Icons.tune_rounded, color: Colors.grey),
                onPressed: () {},
              )
            ],
          ),
          Consumer<Player>(
            builder: (context, playerProvider, child) {
              final player = playerProvider.player;
              return StreamBuilder<Duration>(
                stream: player.durationStream,
                builder: (context, snapshot) {
                  final duration = snapshot.data ?? Duration.zero;
                  return StreamBuilder<PositionData>(
                    stream: Rx.combineLatest2<Duration, Duration, PositionData>(
                        player.positionStream,
                        player.bufferedPositionStream,
                        (position, bufferedPosition) =>
                            PositionData(position, bufferedPosition)),
                    builder: (context, snapshot) {
                      final positionData = snapshot.data ??
                          PositionData(Duration.zero, Duration.zero);
                      var position = positionData.position;
                      if (position > duration) {
                        position = duration;
                      }
                      var bufferedPosition = positionData.bufferedPosition;
                      if (bufferedPosition > duration) {
                        bufferedPosition = duration;
                      }
                      return SeekBar(
                        duration: duration,
                        position: position,
                        bufferedPosition: bufferedPosition,
                        onChangeEnd: (newPosition) {
                          player.seek(newPosition);
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 60.0),
        ],
      ),
    );
  }
}
