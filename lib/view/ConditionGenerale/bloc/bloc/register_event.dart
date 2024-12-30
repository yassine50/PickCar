part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}
class Register extends  RegisterEvent{
  final User user  ; 
  final BuildContext context ; 
  Register( this.context, this.user);
}