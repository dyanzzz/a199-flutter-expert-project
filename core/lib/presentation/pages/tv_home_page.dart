import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:detail/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular/popular.dart';
import 'package:about/about.dart';
import 'package:search/search.dart';
import 'package:top_rated/top_rated.dart';
import 'package:watchlist/watchlist.dart';

class TvHomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv';

  @override
  _TvHomePageState createState() => _TvHomePageState();
}

class _TvHomePageState extends State<TvHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CoreTvBloc>().add(const OnQueryChangedCore());
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
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Tv Show'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, TV_WATCHLIST_ROUTE);
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
              Navigator.pushNamed(context, TvSearchPage.ROUTE_NAME);
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
                'On The Air Tv Shows',
                style: kHeading6,
              ),
              BlocBuilder<CoreTvBloc, CoreState>(
                builder: (context, state) {
                  //print("$state state...");
                  if (state is CoreLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CoreTvHasData) {
                    final result = state.result;

                    return TvList(result);
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
                onTap: () =>
                    Navigator.pushNamed(context, TvPopularPage.ROUTE_NAME),
              ),
              BlocBuilder<CoreTvBloc, CoreState>(
                builder: (context, state) {
                  if (state is CoreLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CoreTvHasData) {
                    final result = state.popular;

                    return TvList(result);
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
                    Navigator.pushNamed(context, TvTopRatedPage.ROUTE_NAME),
              ),
              BlocBuilder<CoreTvBloc, CoreState>(
                builder: (context, state) {
                  if (state is CoreLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CoreTvHasData) {
                    final result = state.topRated;

                    return TvList(result);
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

class TvList extends StatelessWidget {
  final List<Tv> tvShows;

  const TvList(this.tvShows);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvShows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TV_DETAIL_ROUTE,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
