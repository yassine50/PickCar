part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginEvents extends  LoginEvent{
  final String email;
  final String pass; 
  final BuildContext context ; 
  LoginEvents(this.pass, this.email, this.context);
}
