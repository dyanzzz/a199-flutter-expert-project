import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/helpers/test_helper.mocks.dart';
import '../../../../core/test/dummy_data/dummy_objects.dart';
import 'get_now_playing_movies_test.mocks.dart';

@GenerateMocks([CoreMovieBloc])
void main() {
  late GetNowPlayingMovies usecase;
  late MockMovieRepository mockMovieRepository;
  late MockCoreMovieBloc mockCoreMovieBloc;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockCoreMovieBloc = MockCoreMovieBloc();
    usecase = GetNowPlayingMovies(mockMovieRepository);
  });

  Widget _createApp(Widget child) {
    return BlocProvider<CoreMovieBloc>.value(
      value: mockCoreMovieBloc,
      child: MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }

  final tMovies = <Movie>[];

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getNowPlayingMovies())
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tMovies));
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockCoreMovieBloc.stream)
        .thenAnswer((_) => Stream.value(CoreLoading()));
    when(mockCoreMovieBloc.state).thenReturn(CoreLoading());

    final loadingWidget = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createApp(HomeMoviePage()));

    expect(loadingWidget, findsNWidgets(3));
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockCoreMovieBloc.stream).thenAnswer((_) => Stream.value(
        CoreMovieHasData(testMovieList, testMovieList, testMovieList)));
    when(mockCoreMovieBloc.state)
        .thenReturn(const CoreMovieHasData(<Movie>[], <Movie>[], <Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createApp(HomeMoviePage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error message when error',
      (WidgetTester tester) async {
    when(mockCoreMovieBloc.stream)
        .thenAnswer((_) => Stream.value(const CoreError('Error Message')));
    when(mockCoreMovieBloc.state).thenReturn(const CoreError('Error Message'));

    final emptyMessage = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_createApp(HomeMoviePage()));

    expect(emptyMessage, findsNWidgets(3));
  });
}
