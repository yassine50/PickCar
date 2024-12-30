part of 'filter_bloc_bloc.dart';

@immutable
sealed class FilterBlocState {}

final class FilterBlocInitial extends FilterBlocState {}

final class DataLoaded extends FilterBlocState {
  final  List<Address> adress ; 
  DataLoaded( this.adress) ; 
}