import 'package:flutter/material.dart';
import 'package:namer_app/provider/app_state.dart';
import 'package:namer_app/widgets/big_card_widget.dart';
import 'package:namer_app/widgets/history_list_view_widget.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: HistoryListViewWidget(),
          ),
          SizedBox(height: 10),
          BigChartWidget(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: appState.toggleFavorite,
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: appState.getNext,
                child: Text('Next'),
              ),
            ],
          ),
          Spacer(flex: 2)
        ],
      ),
    );
  }
}
