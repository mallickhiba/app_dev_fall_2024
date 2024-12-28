part of 'juice_bloc.dart';

abstract class JuiceState {}

class JuiceInitial extends JuiceState {}

class JuiceLoading extends JuiceState {}

class JuiceLoaded extends JuiceState {
  final List<Map<String, dynamic>> juice;
  JuiceLoaded(this.juice);
}

class JuiceError extends JuiceState {
  final String message;
  JuiceError(this.message);
}
