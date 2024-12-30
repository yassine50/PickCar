part of 'profile_bloc_bloc.dart';

@immutable
sealed class ProfileBlocState {}

final class ProfileBlocInitial extends ProfileBlocState {}
final class infoPersonel extends ProfileBlocState {}
final class PaymentState extends ProfileBlocState {}
final class PermisConduite extends ProfileBlocState {}
