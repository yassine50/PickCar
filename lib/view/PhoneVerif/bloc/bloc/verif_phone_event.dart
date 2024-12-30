part of 'verif_phone_bloc.dart';

@immutable
sealed class VerifPhoneEvent {}
class VerifPhone extends  VerifPhoneEvent{
  final User user  ; 
  final BuildContext context ; 
  final String code;
  final bool fromProfile ; 
  VerifPhone( this.context, this.user, this.code, this.fromProfile);
}
