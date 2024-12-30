part of 'maps_blocc_bloc.dart';

@immutable
sealed class MapsBloccState {}

final class MapsBloccInitial extends MapsBloccState {}

final class Carsloaded extends MapsBloccState {
  final  List<Car> cars ; 
  Carsloaded( this.cars) ; 
}
