import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/watchlist.dart';

class TvWatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  @override
  _TvWatchlistPageState createState() => _TvWatchlistPageState();
}

class _TvWatchlistPageState extends State<TvWatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          //Provider.of<TvWatchlistNotifier>(context, listen: false).fetchTvWatchlist(),
          context.read<WatchlistTvBloc>().add(const OnQueryChangedDetailTv()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    // Provider.of<TvWatchlistNotifier>(context, listen: false).fetchTvWatchlist();
    context.read<WatchlistTvBloc>().add(const OnQueryChangedDetailTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<WatchlistTvBloc, WatchlistState>(
              builder: (context, state) {
                if (state is WatchlistLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is WatchlistTvHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tv = result[index];
                        return TvCard(tv);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is WatchlistError) {
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
          ],
        ),
        /* child: Consumer<TvWatchlistNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tvWatchlist[index];
                  return TvCard(tv);
                },
                itemCount: data.tvWatchlist.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ), */
      ),
    );
  }
}
