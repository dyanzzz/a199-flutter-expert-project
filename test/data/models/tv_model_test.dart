import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testTvModel = TvModel(
    backdropPath: "/1R68vl3d5s86JsS2NPjl8UoMqIS.jpg",
    firstAirDate: '2021-11-24',
    genreIds: [10759, 18],
    id: 88329,
    name: "Hawkeye",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Hawkeye",
    overview:
        "Former Avenger Clint Barton has a seemingly simple mission: get back to his family for Christmas. Possible? Maybe with the help of Kate Bishop, a 22-year-old archer with dreams of becoming a superhero. The two are forced to work together when a presence from Barton’s past threatens to derail far more than the festive spirit.",
    popularity: 2203.365,
    posterPath: "/pqzjCxPVc9TkVgGRWeAoMmyqkZV.jpg",
    voteAverage: 8.5,
    voteCount: 1241,
  );

  final testTv = Tv(
    backdropPath: "/1R68vl3d5s86JsS2NPjl8UoMqIS.jpg",
    firstAirDate: '2021-11-24',
    genreIds: [10759, 18],
    id: 88329,
    name: "Hawkeye",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Hawkeye",
    overview:
        "Former Avenger Clint Barton has a seemingly simple mission: get back to his family for Christmas. Possible? Maybe with the help of Kate Bishop, a 22-year-old archer with dreams of becoming a superhero. The two are forced to work together when a presence from Barton’s past threatens to derail far more than the festive spirit.",
    popularity: 2203.365,
    posterPath: "/pqzjCxPVc9TkVgGRWeAoMmyqkZV.jpg",
    voteAverage: 8.5,
    voteCount: 1241,
  );

  test('should be a subclass of TV entity', () async {
    final result = testTvModel.toEntity();
    expect(result, testTv);
  });
}
