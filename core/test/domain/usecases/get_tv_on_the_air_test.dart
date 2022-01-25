import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late GetTvOnTheAir usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvOnTheAir(mockTvRepository);
  });

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
}
