part of 'mes_demande_bloc.dart';

@immutable
sealed class MesDemandeState {}

final class MesDemandeInitial extends MesDemandeState {}
final class DataLoaded extends MesDemandeState {
  final  List<RentDemand> rentDemands ; 
  DataLoaded( this.rentDemands) ; 
}