import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:detail/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:recommendation/recommendation.dart';
import 'package:watchlist/watchlist.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail_tv';

  final int id;
  const TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailTvBloc>().add(OnQueryChangedDetail(widget.id));
      context.read<WatchlistTvBloc>().add(GetWatchlistStatus(widget.id));
      /* Provider.of<TvDetailNotifier>(context, listen: false).fetchTVDetail(widget.id);
      Provider.of<TvDetailNotifier>(context, listen: false).loadTvWatchlistStatus(widget.id); */
      //context.read<RecommendationTvBloc>().add(OnQueryChanged(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTvBloc, DetailState>(
        builder: (context, state) {
          //print("$state state...");
          if (state is DetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailTvHasData) {
            final result = state.result;
            final movieRecommendations = state.getTvRecommendations;
            final isWatchlist = state.getWatchListStatus;

            return SafeArea(
              child: DetailContentTv(
                result,
                movieRecommendations,
                isWatchlist,
              ),
            );
            /* } else if (state is AddWatchlistMovieData) {
            var message = state.movie;
            if (message == MovieDetailNotifier.watchlistAddSuccessMessage ||
                message == MovieDetailNotifier.watchlistRemoveSuccessMessage) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(message),
                    );
                  });
            } */
          } else if (state is DetailError) {
            return SafeArea(
              child: Center(
                child: Text(state.message),
              ),
            );
          } else {
            return const Center(
              child: Text("Not Found"),
            );
          }
        },
      ),
      /* body: Consumer<TvDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvState == RequestState.loaded) {
            final tv = provider.tv;
            return SafeArea(
              child: DetailContentTv(
                tv,
                // provider.tvRecommendations,
                provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ), */
    );
  }
}

class DetailContentTv extends StatelessWidget {
  final TvDetail tv;
  final List<Tv> recommendation;
  final bool isAddedWatchlist;

  const DetailContentTv(
    this.tv,
    this.recommendation,
    this.isAddedWatchlist,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
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
                              tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!context
                                    .read<WatchlistTvBloc>()
                                    .watchlistStatus) {
                                  context.read<WatchlistTvBloc>().add(
                                      AddTvWatchlist(
                                          tv, WatchlistTvBloc.actionAdd));
                                } else {
                                  context.read<WatchlistTvBloc>().add(
                                      AddTvWatchlist(
                                          tv, WatchlistTvBloc.actionRemove));
                                }
                                /* if (!isAddedWatchlist) {
                                  await Provider.of<TvDetailNotifier>(context,
                                          listen: false)
                                      .addTvWatchlist(tv);
                                } else {
                                  await Provider.of<TvDetailNotifier>(context,
                                          listen: false)
                                      .removeTvFromWatchlist(tv);
                                }

                                final message = Provider.of<TvDetailNotifier>(
                                        context,
                                        listen: false)
                                    .watchlistMessage;

                                if (message ==
                                        TvDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        TvDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
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
                                } */
                              },
                              child:
                                  BlocBuilder<WatchlistTvBloc, WatchlistState>(
                                builder: (context, state) {
                                  print("statenya apa ya : $state");
                                  if (state is WatchlistLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is AddWatchlistData) {
                                    final message = state.message;

                                    /* if (message ==
                                            MovieDetailNotifier
                                                .watchlistAddSuccessMessage ||
                                        message ==
                                            MovieDetailNotifier
                                                .watchlistRemoveSuccessMessage) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(message),
                                        ),
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(message),
                                          );
                                        },
                                      );
                                    } */

                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        message ==
                                                WatchlistTvBloc
                                                    .watchlistAddSuccessMessage
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    );
                                  } else if (state is GetWatchlistStatusData) {
                                    var status = state.status;
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        status
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    );
                                  } else {
                                    return const Center(
                                      child: Text("Watchlist Not Found"),
                                    );
                                  }
                                },
                              ),
                            ),
                            Text(
                              "Genre : " + _showGenres(tv.genres),
                            ),
                            Text(
                              "Duration : " +
                                  _showDuration(tv.numberOfEpisodes),
                            ),
                            Text(
                              "First Air Date : " + tv.firstAirDate.toString(),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            Container(
                              margin: const EdgeInsets.all(16),
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl: '$BASE_IMAGE_URL${tv.backdropPath}',
                                  //width: 150,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<DetailTvBloc, DetailState>(
                              builder: (context, state) {
                                if (state is DetailLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is DetailTvHasData) {
                                  final result = state.getTvRecommendations;
                                  /* return Expanded(
                                    child: ListView.builder(
                                      padding: const EdgeInsets.all(8),
                                      itemBuilder: (context, index) {
                                        final movie = result[index];
                                        return MovieCard(movie);
                                      },
                                      itemCount: result.length,
                                    ),
                                  ); */

                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvDetailPage.ROUTE_NAME,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: result.length,
                                    ),
                                  );
                                } else if (state is DetailError) {
                                  return Expanded(
                                    child: Center(
                                      child: Text(state.message),
                                    ),
                                  );
                                } else {
                                  return Expanded(child: Container());
                                }
                              },
                            ),
                            /* Consumer<TvDetailNotifier>(
                              builder: (context, data, child) {
                                if (data.recommendationState ==
                                    RequestState.loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.recommendationState ==
                                    RequestState.error) {
                                  return Text(data.message);
                                } else if (data.recommendationState ==
                                    RequestState.loaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = recommendation[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvDetailPage.ROUTE_NAME,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendation.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ), */
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
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
