part of 'maps_blocc_bloc.dart';

@immutable
sealed class MapsBloccEvent {}
 class getCars extends  MapsBloccEvent{
  final Address adress ;
  final User user ;
  getCars(this.adress, this.user);
 }
