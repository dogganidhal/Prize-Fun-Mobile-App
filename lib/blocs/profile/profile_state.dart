import 'package:equatable/equatable.dart';
import 'package:fun_prize/model/user.dart';


class ProfileState extends Equatable {
  final User user;
  final bool isLoading;

  ProfileState({this.user, this.isLoading});

  @override
  List<Object> get props => [user, isLoading];
}