import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../test/helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late TvRemoteDataSourceImpl dataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    dataSource = TvRemoteDataSourceImpl(client: mockIOClient);
  });

  group('get On The Air TV Show', () {
    final testTvList =
        TvResponse.fromJson(json.decode(readJson('dummy_data/on_the_air.json')))
            .tvList;

    test('should return list of TV Show Model when the response code is 200',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response(
                readJson('dummy_data/on_the_air.json'),
                200,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));
      // act
      final result = await dataSource.getOnTheAirTvShow();
      // assert
      expect(result, equals(testTvList));
    });

    test('should throw a ServerException when response code is 404 or other',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response(
                'Not Found',
                404,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));
      // act
      final call = dataSource.getOnTheAirTvShow();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get popular TV Show', () {
    final testTvShowList =
        TvResponse.fromJson(json.decode(readJson('dummy_data/tv_popular.json')))
            .tvList;

    test('should return list of tv show when response is success (200)',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response(
                readJson('dummy_data/tv_popular.json'),
                200,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));
      // act
      final result = await dataSource.getPopularTvShow();
      // assert
      expect(result, testTvShowList);
    });

    test('should throw a ServerException when response code is 404 or other',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response(
                'Not Found',
                404,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));
      // act
      final call = dataSource.getPopularTvShow();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated tv show', () {
    final testTvShowList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_top_rated.json')))
        .tvList;

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(
                readJson('dummy_data/tv_top_rated.json'),
                200,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));
      // act
      final result = await dataSource.getTopRatedTvShow();
      // assert
      expect(result, testTvShowList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(
                'Not Found',
                404,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));
      // act
      final act = dataSource.getTopRatedTvShow();
      // assert
      expect(() => act, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show detail', () {
    const testId = 88329;
    final testTvShowDetail = TvDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/$testId?$apiKey')))
          .thenAnswer((_) async => http.Response(
                readJson('dummy_data/tv_detail.json'),
                200,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));
      // act
      final result = await dataSource.getTvShowDetail(testId);
      // assert
      expect(result, equals(testTvShowDetail));
    });

    test('should throw server exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/$testId?$apiKey')))
          .thenAnswer((_) async => http.Response(
                'Not Found',
                404,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));
      // act
      final call = dataSource.getTvShowDetail(testId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show recommendations', () {
    final testTvShowList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recommendations.json')))
        .tvList;
    const testId = 130392;

    test('should return list of TV Show model when the response is 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$testId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
                readJson('dummy_data/tv_recommendations.json'),
                200,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));
      // act
      final result = await dataSource.getTvRecommendations(testId);
      // assert
      expect(result, equals(testTvShowList));
    });

    test('should return list of TV Show model when the response is not 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$testId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
                'Not Found',
                404,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));
      // act
      final result = dataSource.getTvRecommendations(testId);
      // assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('search tv show', () {
    final testSearchResult = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_search_hawkeye.json')))
        .tvList;
    const query = 'hawkeye';

    test('should return list of tv when response code is 200', () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query')))
          .thenAnswer((_) async => http.Response(
                readJson('dummy_data/tv_search_hawkeye.json'),
                200,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));
      // act
      final result = await dataSource.searchTvShows(query);
      // assert
      expect(result, testSearchResult);
    });

    test('should return list of tv when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query')))
          .thenAnswer((_) async => http.Response(
                'Not Found',
                404,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));
      // act
      final result = dataSource.searchTvShows(query);
      // assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });
}
