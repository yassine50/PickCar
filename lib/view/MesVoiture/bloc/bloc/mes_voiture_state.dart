part of 'mes_voiture_bloc.dart';

@immutable
sealed class MesVoitureState {}

final class MesVoitureInitial extends MesVoitureState {}

final class DataLoaded extends MesVoitureState {
  final  List<Car> cars ; 
  DataLoaded( this.cars) ; 
}
