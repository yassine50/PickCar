part of 'mode_bloc.dart';

@immutable
sealed class ModeEvent {}
class ModeFunction extends  ModeEvent{
  final String newMode ; 
  final BuildContext context ;
  final User user ;

  ModeFunction({required this.newMode, required this.context, required this.user,});

}