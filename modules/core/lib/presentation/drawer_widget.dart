import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:about/about.dart';
import 'package:series/presentation/pages/watchlist_series_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
    required this.onTapMovie,
    required this.onTapSeries,
  }) : super(key: key);

  final Function() onTapMovie;
  final Function() onTapSeries;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: () {
              onTapMovie();
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Series'),
            onTap: () {
              onTapSeries();
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist Series'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistSeriesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
