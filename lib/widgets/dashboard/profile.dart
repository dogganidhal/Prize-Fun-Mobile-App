import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fun_prize/blocs/auth/auth_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_event.dart';
import 'package:fun_prize/blocs/profile/profile_bloc.dart';
import 'package:fun_prize/blocs/profile/profile_event.dart';
import 'package:fun_prize/blocs/profile/profile_state.dart';


class Profile extends StatelessWidget {
  final ProfileBloc _profileBloc = ProfileBloc();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  Profile({Key key}) : super(key: key) {
    _profileBloc.add(LoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text("Profil"),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1)
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
              Navigator.of(context).pop();
            }
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _editProfile,
          )
        ],
      ),
      body: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: _profileBloc,
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                if (state.isLoading || state.user == null)
                  Positioned(
                    top: 0, right: 0, left: 0,
                    child: LinearProgressIndicator()
                  ),
                if (state.user != null)
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        _fullNameFields(state),
                        SizedBox(height: 16),
                        _emailField(state),
                        SizedBox(height: 16),
                        _usernameField(state),
                        SizedBox(height: 16),
                        _ageField(state),
                        SizedBox(height: 16),
                        _addressField(state),
                      ],
                    ),
                  )
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _fullNameFields(ProfileState state) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Flexible(
        child: FormBuilderTextField(
          attribute: "lastName",
          initialValue: state.user.lastName,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45, width: 0.5)
            ),
            labelText: "Nom",
          ),
          validators: [
            FormBuilderValidators.required(errorText: "Ce champ est requis")
          ],
        ),
      ),
      SizedBox(width: 16),
      Flexible(
        child: FormBuilderTextField(
          attribute: "firstName",
          initialValue: state.user.firstName,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45, width: 0.5)
            ),
            labelText: "Prénom",
          ),
          validators: [
            FormBuilderValidators.required(errorText: "Ce champ est requis"),
          ],
        ),
      ),
    ],
  );

  Widget _emailField(ProfileState state) => FormBuilderTextField(
    attribute: "email",
    initialValue: state.user.email,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 0.5)
      ),
      labelText: "Adresse Email"
    ),
    validators: [
      FormBuilderValidators.required(errorText: "Ce champ est requis"),
      FormBuilderValidators.email(errorText: "Adresse mail non valide")
    ],
  );

  Widget _usernameField(ProfileState state) => FormBuilderTextField(
    attribute: "username",
    initialValue: state.user.username,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 0.5)
      ),
      labelText: "Pseudo"
    ),
    validators: [
      FormBuilderValidators.required(errorText: "Ce champ est requis")
    ],
  );

  Widget _ageField(ProfileState state) => FormBuilderTextField(
    attribute: "age",
    initialValue: state.user.age?.toString(),
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 0.5)
      ),
      labelText: "Age"
    ),
    validators: [],
  );

  Widget _addressField(ProfileState state) => FormBuilderTextField(
    attribute: "address",
    initialValue: state.user.address,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 0.5)
      ),
      labelText: "Adresse"
    ),
    validators: [],
  );

  void _editProfile() {
    if (!_formKey.currentState.saveAndValidate()) {
      return;
    }
    final values = _formKey.currentState.value;
    final String firstName = values["firstName"];
    final String lastName = values["lastName"];
    final String email = values["email"];
    final String username = values["username"];
    final String address = values["address"];
    final String age = values["age"];

    _profileBloc.add(EditProfileEvent(
      email: email,
      username: username,
      firstName: firstName,
      lastName: lastName,
      address: address,
      age: int.parse(age)
    ));
  }
}
