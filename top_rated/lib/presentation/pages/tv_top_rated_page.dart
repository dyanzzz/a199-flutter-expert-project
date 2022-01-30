import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_rated/top_rated.dart';

class TvTopRatedPage extends StatefulWidget {
  @override
  _TvTopRatedPageState createState() => _TvTopRatedPageState();
}

class _TvTopRatedPageState extends State<TvTopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedTvBloc>().add(const OnQueryChanged()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv Show'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<TopRatedTvBloc, TopRatedState>(
              builder: (context, state) {
                if (state is TopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTvHasData) {
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
                } else if (state is TopRatedError) {
                  return Expanded(
                    child: Center(
                      key: const Key('error_message'),
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
      ),
    );
  }
}
