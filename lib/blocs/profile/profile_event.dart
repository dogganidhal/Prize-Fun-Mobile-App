import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {

}

class LoadProfileEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class EditProfileEvent extends ProfileEvent {
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String address;
  final int age;

  EditProfileEvent({
    this.email, this.username, this.firstName, this.lastName, this.age, this.address
  });

  @override
  List<Object> get props => [firstName, lastName, email, username, address, age];
}