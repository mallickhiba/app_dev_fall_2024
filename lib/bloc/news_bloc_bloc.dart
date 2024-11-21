import 'package:bloc/bloc.dart';
import 'package:iba_course_2/news_service.dart';
import 'package:meta/meta.dart';

part 'news_bloc_event.dart';
part 'news_bloc_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService newsService;

  NewsBloc(this.newsService) : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final news = await newsService.fetchNews();
        emit(NewsLoaded(news));
      } catch (e) {
        emit(NewsError("Failed to fetch news"));
      }
    });
  }
}
