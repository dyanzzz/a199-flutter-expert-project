import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../../../core/test/dummy_data/dummy_object_tv.dart';
import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late SaveTvWatchlist usecase;
  late MockTvRepository mockRepository;

  setUp(() {
    mockRepository = MockTvRepository();
    usecase = SaveTvWatchlist(mockRepository);
  });

  test('should save tv to the repository', () async {
    // arrange
    when(mockRepository.saveWatchList(testTvDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockRepository.saveWatchList(testTvDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
