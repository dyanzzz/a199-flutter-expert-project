import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CoreMovieBloc>().add(const OnQueryChangedCore());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Tv Show'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, TV_HOME_ROUTE);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, MOVIE_WATCHLIST_ROUTE);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, ABOUT_ROUTE);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_ROUTE);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing Movies',
                style: kHeading6,
              ),
              BlocBuilder<CoreMovieBloc, CoreState>(
                builder: (context, state) {
                  //print("$state state...");
                  if (state is CoreLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CoreMovieHasData) {
                    final result = state.result;

                    return MovieList(result);
                  } else if (state is CoreError) {
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
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, MOVIE_POPULAR_ROUTE),
              ),
              BlocBuilder<CoreMovieBloc, CoreState>(
                builder: (context, state) {
                  if (state is CoreLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CoreMovieHasData) {
                    final result = state.popular;

                    return MovieList(result);
                  } else if (state is CoreError) {
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
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, MOVIE_TOP_RATED_ROUTE),
              ),
              BlocBuilder<CoreMovieBloc, CoreState>(
                builder: (context, state) {
                  //print("$state state...");
                  if (state is CoreLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CoreMovieHasData) {
                    final result = state.topRated;

                    return MovieList(result);
                  } else if (state is CoreError) {
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
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MOVIE_DETAIL_ROUTE,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
