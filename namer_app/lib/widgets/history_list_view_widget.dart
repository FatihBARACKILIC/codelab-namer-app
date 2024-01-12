import 'package:flutter/material.dart';
import 'package:namer_app/provider/app_state.dart';
import 'package:provider/provider.dart';

class HistoryListViewWidget extends StatefulWidget {
  const HistoryListViewWidget({super.key});

  @override
  State<HistoryListViewWidget> createState() => _HistoryListViewWidgetState();
}

class _HistoryListViewWidgetState extends State<HistoryListViewWidget> {
  final _key = GlobalKey();

  static const Gradient _maskingGradient = LinearGradient(
    colors: [
      Colors.transparent,
      Colors.black,
    ],
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    appState.historyListKey = _key;

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: true,
        padding: EdgeInsets.only(top: 100),
        initialItemCount: appState.history.length,
        itemBuilder: (context, index, animation) {
          final pair = appState.history.elementAt(index);
          return SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: TextButton.icon(
                onPressed: () => appState.toggleFavorite(pair),
                icon: appState.favorites.contains(pair)
                    ? Icon(
                        Icons.favorite,
                        size: 12,
                      )
                    : SizedBox(),
                label: Text(
                  pair.asLowerCase,
                  semanticsLabel: pair.asPascalCase,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
