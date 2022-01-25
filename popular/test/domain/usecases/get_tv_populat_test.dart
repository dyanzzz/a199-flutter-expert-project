import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:popular/popular.dart';

import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late GetTvPopular usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvPopular(mockTvRepository);
  });

  final tTvShow = <Tv>[];

  group('GetPopularTvShow Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRepository.getPopularTvShow())
            .thenAnswer((_) async => Right(tTvShow));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvShow));
      });
    });
  });
}
