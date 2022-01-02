import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=03b8bc1a8bedee74ec1f1fd81b3b39ff';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On The Air TV Show', () {
    final testTvList =
        TvResponse.fromJson(json.decode(readJson('dummy_data/on_the_air.json')))
            .tvList;

    test('should return list of TV Show Model when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
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
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
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
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
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
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
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
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
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
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final act = dataSource.getTopRatedTvShow();
      // assert
      expect(() => act, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show detail', () {
    final testId = 88329;
    final testTvShowDetail = TvDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$testId?$API_KEY')))
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
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$testId?$API_KEY')))
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
}
