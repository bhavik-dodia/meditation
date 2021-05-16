import 'package:flutter/foundation.dart';

/// Data model for meditation tracks.
class MeditationTrack {
  final String title, duration;

  MeditationTrack({
    @required this.title,
    @required this.duration,
  });

  /// Converts MeditationTrack object to json.
  Map<String, dynamic> toJson() => {
        'title': title,
        'duration': duration,
      };

  /// Creates MeditationTrack object from json.
  factory MeditationTrack.fromJson(Map<String, dynamic> json) =>
      MeditationTrack(
        title: json['title'],
        duration: json['duration'],
      );
}
