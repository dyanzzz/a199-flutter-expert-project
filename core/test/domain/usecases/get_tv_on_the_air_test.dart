import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/helpers/test_helper.mocks.dart';
import '../../../../core/test/dummy_data/dummy_object_tv.dart';
import 'get_tv_on_the_air_test.mocks.dart';

@GenerateMocks([CoreTvBloc])
void main() {
  late GetTvOnTheAir usecase;
  late MockTvRepository mockTvRepository;
  late MockCoreTvBloc mockCoreTvBloc;

  setUp(() {
    mockTvRepository = MockTvRepository();
    mockCoreTvBloc = MockCoreTvBloc();
    usecase = GetTvOnTheAir(mockTvRepository);
  });

  Widget _createApp(Widget child) {
    return BlocProvider<CoreTvBloc>.value(
      value: mockCoreTvBloc,
      child: MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }

  final tTvShow = <Tv>[];

  test('should get list of tv from the repository', () async {
    //arrange
    when(mockTvRepository.getOnTheAirTvShow())
        .thenAnswer((realInvocation) async => Right(tTvShow));
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(tTvShow));
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockCoreTvBloc.stream).thenAnswer((_) => Stream.value(CoreLoading()));
    when(mockCoreTvBloc.state).thenReturn(CoreLoading());

    final loadingWidget = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createApp(TvHomePage()));

    expect(loadingWidget, findsNWidgets(3));
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockCoreTvBloc.stream).thenAnswer(
        (_) => Stream.value(CoreTvHasData(testTvList, testTvList, testTvList)));
    when(mockCoreTvBloc.state)
        .thenReturn(const CoreTvHasData(<Tv>[], <Tv>[], <Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createApp(TvHomePage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error message when error',
      (WidgetTester tester) async {
    when(mockCoreTvBloc.stream)
        .thenAnswer((_) => Stream.value(const CoreError('Error Message')));
    when(mockCoreTvBloc.state).thenReturn(const CoreError('Error Message'));

    final emptyMessage = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_createApp(TvHomePage()));

    expect(emptyMessage, findsNWidgets(3));
  });
}
