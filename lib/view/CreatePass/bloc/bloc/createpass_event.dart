part of 'createpass_bloc.dart';

@immutable
abstract class CreatepassEvent {}

 class CalculeStrength extends  CreatepassEvent{
  final String pass;
  CalculeStrength(this.pass);
}
