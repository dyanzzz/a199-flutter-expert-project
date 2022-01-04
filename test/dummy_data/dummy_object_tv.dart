import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testTv = Tv(
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalName: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  name: 'Spider-Man',
  voteAverage: 7.2,
  voteCount: 13507,
  firstAirDate: DateTime.parse('2002-05-01'),
  originalLanguage: 'en',
  originCountry: ['US'],
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
    status: 'Ended',
    backdropPath: '/1R68vl3d5s86JsS2NPjl8UoMqIS.jpg',
    genres: [Genre(id: 10759, name: 'Action & Adventure')],
    id: 88329,
    originalName: 'Hawkeye',
    overview:
        'Former Avenger Clint Barton has a seemingly simple mission: get back to his family for Christmas. Possible? Maybe with the help of Kate Bishop, a 22-year-old archer with dreams of becoming a superhero. The two are forced to work together when a presence from Barton’s past threatens to derail far more than the festive spirit.',
    posterPath: '/pqzjCxPVc9TkVgGRWeAoMmyqkZV.jpg',
    firstAirDate: DateTime.parse('2021-11-24'),
    name: 'Hawkeye',
    voteAverage: 8.5,
    voteCount: 1267,
    inProduction: false,
    numberOfSeasons: 1,
    homepage: "https://www.disneyplus.com/series/hawkeye/11Zy8m9Dkj5l",
    lastAirDate: DateTime.parse("2021-12-22"),
    numberOfEpisodes: 6,
    originalLanguage: 'en',
    popularity: 1607.746,
    tagline: 'This holiday season, the best gifts come with a bow',
    type: 'Miniseries');

final testTvCache = TvTable(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  name: 'Spider-Man',
);

final testTvCacheMap = {
  'id': 557,
  'overview':
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  'name': 'Spider-Man',
};

final testTvFromCache = Tv.watchlist(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  name: 'Spider-Man',
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
