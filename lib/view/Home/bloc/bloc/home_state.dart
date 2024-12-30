part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

final class HomeInitial extends HomeState {}
final class DataLoaded extends HomeState {
  final  List<Car> cars ; 
  DataLoaded( this.cars) ; 
}
