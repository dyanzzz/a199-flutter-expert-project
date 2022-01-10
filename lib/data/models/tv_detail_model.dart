import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

import 'genre_model.dart';
import 'last_episode_to_air_model.dart';
import 'network_model.dart';
import 'next_episode_to_air_model.dart';
import 'production_country_model.dart';
import 'season_model.dart';
import 'spoken_languages_model.dart';

class TvDetailResponse extends Equatable {
  TvDetailResponse({
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

  final String? backdropPath;
  //final List<dynamic> createdBy;
  //final List<int> episodeRunTime;
  final String? firstAirDate;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  //final List<String> languages;
  final String? lastAirDate;
  //final LastEpisodeToAirModel lastEpisodeToAir;
  final String name;
  //final NextEpisodeToAirModel? nextEpisodeToAir;
  //final List<NetworkModel> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  //final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  //final List<NetworkModel> productionCompanies;
  //final List<ProductionCountryModel> productionCountries;
  //final List<SeasonModel> seasons;
  //final List<SpokenLanguageModel> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        backdropPath: json["backdrop_path"],
        //createdBy: List<dynamic>.from(json["created_by"].map((x) => x)),
        //episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: json["first_air_date"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        //languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: json["last_air_date"],
        //lastEpisodeToAir: LastEpisodeToAirModel.fromJson(json["last_episode_to_air"]),
        name: json["name"],
        //nextEpisodeToAir: json["next_episode_to_air"] == null ? null : NextEpisodeToAirModel.fromJson(json["next_episode_to_air"]),
        //networks: List<NetworkModel>.from(json["networks"].map((x) => NetworkModel.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        //originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        //productionCompanies: List<NetworkModel>.from(json["production_companies"].map((x) => NetworkModel.fromJson(x))),
        //productionCountries: List<ProductionCountryModel>.from(json["production_countries"].map((x) => ProductionCountryModel.fromJson(x))),
        //seasons: List<SeasonModel>.from(json["seasons"].map((x) => SeasonModel.fromJson(x))),
        //spokenLanguages: List<SpokenLanguageModel>.from(json["spoken_languages"].map((x) => SpokenLanguageModel.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        //"created_by": List<dynamic>.from(createdBy.map((x) => x)),
        //"episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date": "${firstAirDate.toString()}",
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        //"languages": List<dynamic>.from(languages.map((x) => x)),
        "last_air_date": "${lastAirDate.toString()}",
        //"last_episode_to_air": lastEpisodeToAir.toJson(),
        "name": name,
        //"next_episode_to_air":nextEpisodeToAir == null ? null : nextEpisodeToAir!.toJson(),
        //"networks": List<dynamic>.from(networks.map((x) => x.toJson())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        //"origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        //"production_companies":List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        //"production_countries":List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        //"seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        //"spoken_languages":List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvDetail toEntity() {
    return TvDetail(
      backdropPath: this.backdropPath,
      //createdBy: this.createdBy,
      //episodeRunTime: this.episodeRunTime,
      firstAirDate: this.firstAirDate,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      homepage: this.homepage,
      id: this.id,
      inProduction: this.inProduction,
      //languages: this.languages,
      lastAirDate: this.lastAirDate,
      //lastEpisodeToAir: this.lastEpisodeToAir.toEntity(),
      name: this.name,
      //nextEpisodeToAir: this.nextEpisodeToAir == null? null: this.nextEpisodeToAir!.toEntity(),
      //networks: this.networks.map((network) => network.toEntity()).toList(),
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      //originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      //productionCompanies: this.productionCompanies.map((productionCompany) => productionCompany.toEntity()).toList(),
      //productionCountries: this.productionCountries.map((productionCountry) => productionCountry.toEntity()).toList(),
      //seasons: this.seasons.map((season) => season.toEntity()).toList(),
      //spokenLanguages: this.spokenLanguages.map((spokenLanguage) => spokenLanguage.toEntity()).toList(),
      status: this.status,
      tagline: this.tagline,
      type: this.type,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

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
