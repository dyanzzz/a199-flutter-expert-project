import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final testTvModel = TvModel(
      backdropPath: "/1R68vl3d5s86JsS2NPjl8UoMqIS.jpg",
      firstAirDate: '2021-11-24',
      genreIds: const [10759, 18],
      id: 88329,
      name: "Hawkeye",
      originCountry: const ["US"],
      originalLanguage: "en",
      originalName: "Hawkeye",
      overview:
          "Former Avenger Clint Barton has a seemingly simple mission: get back to his family for Christmas. Possible? Maybe with the help of Kate Bishop, a 22-year-old archer with dreams of becoming a superhero. The two are forced to work together when a presence from Barton’s past threatens to derail far more than the festive spirit.",
      popularity: 2203.365,
      posterPath: "/pqzjCxPVc9TkVgGRWeAoMmyqkZV.jpg",
      voteAverage: 8.5,
      voteCount: 1241);

  final testTvResponseModel = TvResponse(
    tvList: <TvModel>[testTvModel],
    page: 1,
    totalPages: 6102,
    totalResults: 122025,
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air.json'));

      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, testTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testTvResponseModel.toJson();

      // assert
      final expectJsonMap = {
        "page": 1,
        "results": [
          {
            "backdrop_path": "/1R68vl3d5s86JsS2NPjl8UoMqIS.jpg",
            "first_air_date": "2021-11-24",
            "genre_ids": [10759, 18],
            "id": 88329,
            "name": "Hawkeye",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Hawkeye",
            "overview":
                "Former Avenger Clint Barton has a seemingly simple mission: get back to his family for Christmas. Possible? Maybe with the help of Kate Bishop, a 22-year-old archer with dreams of becoming a superhero. The two are forced to work together when a presence from Barton’s past threatens to derail far more than the festive spirit.",
            "popularity": 2203.365,
            "poster_path": "/pqzjCxPVc9TkVgGRWeAoMmyqkZV.jpg",
            "vote_average": 8.5,
            "vote_count": 1241
          }
        ],
        "total_pages": 6102,
        "total_results": 122025
      };
      expect(result, expectJsonMap);
    });
  });
}
