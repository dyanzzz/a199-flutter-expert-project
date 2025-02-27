import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_object_tv.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvWatchlist usecase;
  late MockTvRepository mockRepository;

  setUp(() {
    mockRepository = MockTvRepository();
    usecase = RemoveTvWatchlist(mockRepository);
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockRepository.removeWatchList(testTvDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockRepository.removeWatchList(testTvDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
