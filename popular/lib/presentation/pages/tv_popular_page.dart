import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular/popular.dart';

class TvPopularPage extends StatefulWidget {
  @override
  _TvPopularPageState createState() => _TvPopularPageState();
}

class _TvPopularPageState extends State<TvPopularPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularTvBloc>().add(const OnQueryChanged()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Show'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<PopularTvBloc, PopularState>(
              builder: (context, state) {
                if (state is PopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvHasData) {
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
                } else if (state is PopularError) {
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
