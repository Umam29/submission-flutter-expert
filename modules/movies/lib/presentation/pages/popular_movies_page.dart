import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/blocs/popular_movie_bloc.dart';
import 'package:movies/presentation/blocs/popular_movie_event.dart';
import 'package:movies/presentation/blocs/popular_movie_state.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  const PopularMoviesPage({super.key});

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<PopularMovieBloc>(context).add(GetPopularMovieList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
          builder: (context, state) {
            if (state is PopularMovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMovieHasData) {
              final result = state.result;

              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(movie: movie);
                },
                itemCount: result.length,
              );
            } else if (state is PopularMovieError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
