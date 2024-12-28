import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iba_course_2/juice_services.dart';

part 'juice_event.dart';
part 'juice_state.dart';

class JuiceBloc extends Bloc<JuiceEvent, JuiceState> {
  final JuiceService juiceService;

  JuiceBloc(this.juiceService) : super(JuiceInitial()) {
    on<FetchJuice>((event, emit) async {
      emit(JuiceLoading());
      try {
        final juices = await juiceService.fetchJuice();
        emit(JuiceLoaded(juices));
      } catch (e) {
        emit(JuiceError("Failed to fetch juices: $e"));
      }
    });
  }
}
