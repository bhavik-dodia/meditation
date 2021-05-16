import 'package:flutter/material.dart';

/// Displays favorites button.
class FavoritesButton extends StatefulWidget {
  final bool isFavorite;
  final Color color;

  const FavoritesButton({Key key, this.isFavorite: false, this.color: Colors.grey}) : super(key: key);
  @override
  _FavoritesButtonState createState() => _FavoritesButtonState();
}

class _FavoritesButtonState extends State<FavoritesButton> {
  bool isFavorite;
  @override
  void initState() {
    super.initState();
    setState(() => isFavorite = widget.isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
        maxHeight: 40.0,
        maxWidth: 40.0,
        minHeight: 20.0,
        minWidth: 20.0,
      ),
      iconSize: 26.0,
      icon: isFavorite
          ? const Icon(
              Icons.favorite_rounded,
              color: Colors.blueAccent,
            )
          : Icon(
              Icons.favorite_border_rounded,
              color: widget.color,
            ),
      onPressed: () => setState(() => isFavorite = !isFavorite),
    );
  }
}
