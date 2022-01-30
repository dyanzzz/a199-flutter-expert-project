import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular/popular.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/search.dart';
import 'package:top_rated/top_rated.dart';
import 'package:watchlist/watchlist.dart';
import 'package:detail/detail.dart';

void main() async {
  // firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  di.init(await getHttpClient());
  runApp(MyApp());
}

/* 
dart: restart analysis server
clear cache project, setelah memindahkan project ke modul masing-masing
https://github.com/Dart-Code/Dart-Code/issues/2764#issuecomment-1001202535
 */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // bloc
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<CoreMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<CoreTvBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case MOVIE_HOME_ROUTE:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case MOVIE_POPULAR_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case MOVIE_TOP_RATED_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case MOVIE_WATCHLIST_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());

            case TV_HOME_ROUTE:
              return MaterialPageRoute(builder: (_) => TvHomePage());
            case TV_POPULAR_ROUTE:
              return MaterialPageRoute(builder: (_) => TvPopularPage());
            case TV_TOP_RATED_ROUTE:
              return MaterialPageRoute(builder: (_) => TvTopRatedPage());
            case TV_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case TV_SEARCH_ROUTE:
              return CupertinoPageRoute(builder: (_) => TvSearchPage());
            case TV_WATCHLIST_ROUTE:
              return MaterialPageRoute(builder: (_) => TvWatchlistPage());

            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
