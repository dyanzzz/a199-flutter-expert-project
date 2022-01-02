import 'package:equatable/equatable.dart';

import 'genre.dart';
import 'last_episode_to_air.dart';
import 'network.dart';
import 'next_episode_to_air.dart';
import 'production_countries.dart';
import 'season.dart';
import 'spoken_languages.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.backdropPath,
    //required this.createdBy,
    //required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    //required this.languages,
    required this.lastAirDate,
    //required this.lastEpisodeToAir,
    required this.name,
    //required this.nextEpisodeToAir,
    //required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    //required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    //required this.productionCompanies,
    //required this.productionCountries,
    //required this.seasons,
    //required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final String backdropPath;
  //final List<dynamic> createdBy;
  //final List<int> episodeRunTime;
  final DateTime firstAirDate;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  //final List<String> languages;
  final DateTime lastAirDate;
  //final LastEpisodeToAir lastEpisodeToAir;
  final String name;
  //final NextEpisodeToAir? nextEpisodeToAir;
  //final List<Network> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  //final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  //final List<Network> productionCompanies;
  //final List<ProductionCountry> productionCountries;
  //final List<Season> seasons;
  //final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  @override
  // todo implements object
  List<Object?> get props => [
        backdropPath,
        //createdBy,
        //episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        //languages,
        lastAirDate,
        //lastEpisodeToAir,
        name,
        //nextEpisodeToAir,
        //networks,
        numberOfEpisodes,
        numberOfSeasons,
        //originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        //productionCompanies,
        //productionCountries,
        //seasons,
        //spokenLanguages,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
