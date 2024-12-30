part of 'filter_bloc_bloc.dart';

@immutable
sealed class FilterBlocEvent {}

 class getAdress extends  FilterBlocEvent{
  final String adress ;
  getAdress(this.adress); 
 }
