import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:detail/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/bloc/watchlist_movie_bloc.dart';
import 'package:watchlist/watchlist.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  const MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailMovieBloc>().add(OnQueryChangedDetail(widget.id));
      context.read<WatchlistMovieBloc>().add(GetWatchlistStatus(widget.id));
      //context.read<RecommendationMovieBloc>().add(OnQueryChanged(widget.id));
      /* Provider.of<MovieDetailNotifier>(context, listen: false)
          .fetchMovieDetail(widget.id);
      Provider.of<MovieDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id); */
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailMovieBloc, DetailState>(
        builder: (context, state) {
          //print("$state state...");
          if (state is DetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailMovieHasData) {
            final result = state.result;
            final movieRecommendations = state.getMovieRecommendations;
            final isWatchlist = state.getWatchListStatus;

            return SafeArea(
              child: DetailContent(
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
      /* body: Consumer<MovieDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.movieState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.movieState == RequestState.loaded) {
            final movie = provider.movie;
            return SafeArea(
              child: DetailContent(
                movie,
                provider.movieRecommendations,
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

  /* @override
  void dispose() {
    //counterBloc.dispose();
    context.read<DetailMovieBloc>().close();
    super.dispose();
  } */
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(
    this.movie,
    this.recommendations,
    this.isAddedWatchlist,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
                              movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!context
                                    .read<WatchlistMovieBloc>()
                                    .watchlistStatus) {
                                  context.read<WatchlistMovieBloc>().add(
                                      AddMovieWatchlist(
                                          movie, WatchlistMovieBloc.actionAdd));
                                } else {
                                  context.read<WatchlistMovieBloc>().add(
                                      AddMovieWatchlist(movie,
                                          WatchlistMovieBloc.actionRemove));
                                }

                                /* 
                                if (message ==
                                        MovieDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        MovieDetailNotifier
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
                                /* } else if (state is DetailError) {
                                      return Expanded(
                                        child: Center(
                                          child: Text(state.message),
                                        ),
                                      );
                                    } else {
                                      return Expanded(child: Container());
                                    }
                                  },
                                ); */
                              },
                              child: BlocBuilder<WatchlistMovieBloc,
                                  WatchlistState>(
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
                                                WatchlistMovieBloc
                                                    .watchlistAddSuccessMessage
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    );
                                  } else if (state
                                      is GetWatchlistStatusData) {
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
                              "Genre : " + _showGenres(movie.genres),
                            ),
                            Text(
                              "Duration : " + _showDuration(movie.runtime),
                            ),
                            Text(
                              "Release Date : " + movie.releaseDate.toString(),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            Container(
                              margin: const EdgeInsets.all(16),
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '$BASE_IMAGE_URL${movie.backdropPath}',
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
                            BlocBuilder<DetailMovieBloc, DetailState>(
                              builder: (context, state) {
                                if (state is DetailLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is DetailMovieHasData) {
                                  final result = state.getMovieRecommendations;
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
                                        final movie = result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
                            /* Consumer<MovieDetailNotifier>(
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
                                        final movie = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
                                      itemCount: recommendations.length,
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
        )
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
