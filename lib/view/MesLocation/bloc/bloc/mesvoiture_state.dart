part of 'mesvoiture_bloc.dart';

@immutable
sealed class MesvoitureState {}

final class MesvoitureInitial extends MesvoitureState {}

final class DataLoaded extends MesvoitureState {
  final  List<Rent> rents ; 
  DataLoaded( this.rents) ; 
}