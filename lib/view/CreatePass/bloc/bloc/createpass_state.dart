part of 'createpass_bloc.dart';

@immutable
abstract class CreatepassState {}

final class CreatepassInitial extends CreatepassState {
  final double strength  ;
  final Color color ; 
  CreatepassInitial(this.strength, this.color );
}
