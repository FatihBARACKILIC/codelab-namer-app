import 'package:flutter/material.dart';
import 'package:namer_app/provider/app_state.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appState = context.watch<AppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text("No favorites yet."),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("You have ${appState.favorites.length} favorites:"),
        ),
        Expanded(
          child: GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 400 / 80,
            ),
            children: [
              for (var favorite in appState.favorites)
                ListTile(
                  leading: IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      semanticLabel: "Delete",
                    ),
                    color: theme.colorScheme.primary,
                    onPressed: () => appState.removeFavorite(favorite),
                  ),
                  title: Text(
                    favorite.asCamelCase,
                    semanticsLabel: favorite.asCamelCase,
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
