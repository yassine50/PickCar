part of 'mes_voiture_bloc.dart';

@immutable
sealed class MesVoitureEvent {}
 class getCars extends  MesVoitureEvent{
  final User user ;
  getCars({required this.user}); 
 }
