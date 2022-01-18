library core;

export 'package:core/utils/constants.dart';
export 'package:core/utils/exception.dart';
export 'package:core/utils/failure.dart';
export 'package:core/utils/state_enum.dart';

export 'package:core/styles/color.dart';
export 'package:core/styles/text_styles.dart';

export 'package:core/common/network_info.dart';
export 'package:core/common/utils.dart';

export 'package:core/data/datasources/db/database_helper.dart';
export 'package:core/data/datasources/movie_local_data_source.dart';
export 'package:core/data/datasources/movie_remote_data_source.dart';
export 'package:core/data/datasources/tv_local_data_source.dart';
export 'package:core/data/datasources/tv_remote_data_source.dart';

export 'package:core/data/models/movie_model.dart';
export 'package:core/data/models/movie_table.dart';
export 'package:core/data/models/movie_detail_model.dart';
export 'package:core/data/models/movie_response.dart';
export 'package:core/data/models/tv_model.dart';
export 'package:core/data/models/tv_table.dart';
export 'package:core/data/models/tv_detail_model.dart';
export 'package:core/data/models/tv_response.dart';
export 'package:core/data/models/genre_model.dart';

export 'package:core/domain/entities/genre.dart';
export 'package:core/domain/entities/last_episode_to_air.dart';
export 'package:core/domain/entities/movie_detail.dart';
export 'package:core/domain/entities/movie.dart';
export 'package:core/domain/entities/network.dart';
export 'package:core/domain/entities/next_episode_to_air.dart';
export 'package:core/domain/entities/production_countries.dart';
export 'package:core/domain/entities/season.dart';
export 'package:core/domain/entities/spoken_languages.dart';
export 'package:core/domain/entities/tv_detail.dart';
export 'package:core/domain/entities/tv.dart';

export 'package:core/domain/repositories/movie_repository.dart';
export 'package:core/domain/repositories/tv_repository.dart';

export 'package:core/domain/usecases/get_movie_detail.dart';
export 'package:core/domain/usecases/get_movie_recommendations.dart';
export 'package:core/domain/usecases/get_watchlist_status.dart';
export 'package:core/domain/usecases/remove_watchlist.dart';
export 'package:core/domain/usecases/save_watchlist.dart';
export 'package:core/domain/usecases/get_now_playing_movies.dart';
export 'package:core/domain/usecases/get_popular_movies.dart';
export 'package:core/domain/usecases/get_top_rated_movies.dart';
export 'package:core/domain/usecases/search_movies.dart';
export 'package:core/domain/usecases/get_tv_detail.dart';
export 'package:core/domain/usecases/get_tv_recommendation.dart';
export 'package:core/domain/usecases/get_tv_watchlist_status.dart';
export 'package:core/domain/usecases/remove_tv_watchlist.dart';
export 'package:core/domain/usecases/save_tv_watchlist.dart';
export 'package:core/domain/usecases/get_tv_on_the_air.dart';
export 'package:core/domain/usecases/get_tv_popular.dart';
export 'package:core/domain/usecases/get_tv_top_rated.dart';
export 'package:core/domain/usecases/search_tv.dart';
export 'package:core/domain/usecases/get_tv_watchlist.dart';
export 'package:core/domain/usecases/get_watchlist_movies.dart';

export 'package:core/presentation/pages/home_movie_page.dart';
export 'package:core/presentation/pages/movie_detail_page.dart';
export 'package:core/presentation/pages/popular_movies_page.dart';
export 'package:core/presentation/pages/search_page.dart';
export 'package:core/presentation/pages/top_rated_movies_page.dart';
export 'package:core/presentation/pages/watchlist_movies_page.dart';

export 'package:core/presentation/pages/tv_home_page.dart';
export 'package:core/presentation/pages/tv_popular_page.dart';
export 'package:core/presentation/pages/tv_search_page.dart';
export 'package:core/presentation/pages/tv_top_rated_page.dart';
export 'package:core/presentation/pages/tv_watchlist_page.dart';
export 'package:core/presentation/pages/tv_detail_page.dart';

export 'package:core/presentation/provider/movie_list_notifier.dart';
export 'package:core/presentation/provider/movie_detail_notifier.dart';
export 'package:core/presentation/provider/movie_search_notifier.dart';
export 'package:core/presentation/provider/popular_movies_notifier.dart';
export 'package:core/presentation/provider/top_rated_movies_notifier.dart';
export 'package:core/presentation/provider/tv_detail_notifier.dart';
export 'package:core/presentation/provider/tv_list_notifier.dart';
export 'package:core/presentation/provider/tv_popular_notifier.dart';
export 'package:core/presentation/provider/tv_search_notifier.dart';
export 'package:core/presentation/provider/tv_top_rated_notifier.dart.dart';
export 'package:core/presentation/provider/tv_watchlist_notifier.dart';
export 'package:core/presentation/provider/watchlist_movie_notifier.dart';

export 'package:core/presentation/widgets/movie_card_list.dart';
export 'package:core/presentation/widgets/tv_card_list.dart';

export 'package:core/data/repositories/movie_repository_impl.dart';
export 'package:core/data/repositories/tv_repository_impl.dart';
