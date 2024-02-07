import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:series/domain/entities/genre.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/presentation/blocs/series_detail_bloc.dart';
import 'package:series/presentation/blocs/series_detail_event.dart';
import 'package:series/presentation/blocs/series_detail_state.dart';
import 'package:series/presentation/blocs/series_recommendation_bloc.dart';
import 'package:series/presentation/blocs/series_recommendation_event.dart';
import 'package:series/presentation/blocs/series_recommendation_state.dart';
import 'package:series/presentation/blocs/watchlist_series_bloc.dart';
import 'package:series/presentation/blocs/watchlist_series_event.dart';
import 'package:series/presentation/blocs/watchlist_series_state.dart';

class SeriesDetailPage extends StatefulWidget {
  const SeriesDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  static const ROUTE_NAME = '/series-detail';
  final int id;

  @override
  State<SeriesDetailPage> createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () {
        BlocProvider.of<SeriesDetailBloc>(context)
            .add(GetSeriesDetailResult(widget.id));
        BlocProvider.of<SeriesRecommendationBloc>(context)
            .add(GetSeriesRecommendationResult(widget.id));
        BlocProvider.of<WatchlistSeriesBloc>(context)
            .add(LoadWatchlistSeriesStatus(widget.id));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isAddedToWatchlist = context.select<WatchlistSeriesBloc, bool>(
      (value) {
        final state = value.state;

        if (state is WatchlistSeriesStatus) {
          return state.result;
        } else {
          return false;
        }
      },
    );

    return Scaffold(
      body: BlocBuilder<SeriesDetailBloc, SeriesDetailState>(
        builder: (context, state) {
          if (state is SeriesDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeriesDetailHasData) {
            return SafeArea(
              child: DetailContent(
                series: state.series,
                isAddedWatchlist: isAddedToWatchlist,
              ),
            );
          } else if (state is SeriesDetailError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final SeriesDetail series;
  final bool isAddedWatchlist;

  const DetailContent({
    super.key,
    required this.series,
    required this.isAddedWatchlist,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    late String message;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${series.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              series.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<WatchlistSeriesBloc>()
                                      .add(AddWatchlistSeries(series));
                                } else {
                                  context
                                      .read<WatchlistSeriesBloc>()
                                      .add(DeleteWatchlistSeries(series));
                                }

                                final state =
                                    BlocProvider.of<WatchlistSeriesBloc>(
                                            context,
                                            listen: false)
                                        .state;

                                if (state is WatchlistSeriesStatus) {
                                  message = state.message;

                                  if (message == watchlistAddSuccessMessage ||
                                      message ==
                                          watchlistRemoveSuccessMessage) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(message)));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(message),
                                          );
                                        });
                                  }
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(series.genres),
                            ),
                            Text(
                                'Episode : ${series.numberOfEpisodes.toString()}'),
                            Text(
                                'Season : ${series.numberOfSeasons.toString()}'),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: series.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${series.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              series.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<SeriesRecommendationBloc,
                                SeriesRecommendationState>(
                              builder: (context, state) {
                                if (state is SeriesRecommendationLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is SeriesRecommendationError) {
                                  return Text(state.message);
                                } else if (state
                                    is SeriesRecommendationHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final series = state.series[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                SeriesDetailPage.ROUTE_NAME,
                                                arguments: series.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${series.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.series.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
