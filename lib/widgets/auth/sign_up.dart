import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fun_prize/blocs/auth/auth_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_event.dart';
import 'package:fun_prize/utils/contants.dart';


class SignUp extends StatefulWidget {
  final VoidCallback onLoginButtonTapped;

  const SignUp({Key key, this.onLoginButtonTapped}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isPasswordTextObscure = true;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: FormBuilder(
            key: _formKey,
            autovalidate: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 64,
                    child: Image.asset(Constants.medalAsset),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Inscription",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: Text(
                      "Créer votre compte Fun & Prize",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  this._fullNameFields,
                  SizedBox(height: 16),
                  this._emailField,
                  SizedBox(height: 16),
                  this._usernameField,
                  SizedBox(height: 16),
                  this._passwordAndConfirmationFields,
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          textColor: Colors.blue,
                          onPressed: this.widget.onLoginButtonTapped,
                          child: Text("Se connecter"),
                        ),
                        FlatButton(
                          color: Colors.blue,
                          colorBrightness: Brightness.dark,
                          onPressed: _signUp,
                          child: Text("S'inscrire"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _fullNameFields => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Flexible(
        child: FormBuilderTextField(
          attribute: "lastName",
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

  Widget get _emailField => FormBuilderTextField(
    attribute: "email",
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black45, width: 0.5)
      ),
      labelText: "Adresse Email",
      suffixText: Constants.audenciaEmailSuffix
    ),
    validators: [
      FormBuilderValidators.required(errorText: "Ce champ est requis"),
      FormBuilderValidators.pattern(r'^[a-zA-Z0-9\-_\.]+$', errorText: "Adresse mail non valide")
    ],
  );

  Widget get _usernameField => FormBuilderTextField(
    attribute: "username",
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black45, width: 0.5)
      ),
      labelText: "Pseudo"
    ),
  );

  Widget get _passwordAndConfirmationFields => FormBuilderTextField(
    attribute: "password",
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: "Mot de passe",
      suffixIcon: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          this._isPasswordTextObscure ?
          Icons.visibility :
          Icons.visibility_off
        ),
        onPressed: this._togglePasswordObscureText,
      )
    ),
    obscureText: this._isPasswordTextObscure,
    validators: [
      FormBuilderValidators.required(errorText: "Ce champ est requis")
    ],
  );

  void _togglePasswordObscureText() {
    this.setState(() => this._isPasswordTextObscure = !this._isPasswordTextObscure);
  }

  void _signUp() {
    if (!_formKey.currentState.saveAndValidate()) {
      return;
    }
    final values = _formKey.currentState.value;
    final String firstName = values["firstName"];
    final String lastName = values["lastName"];
    final String email = values["email"];
    final String username = values["username"];
    final String password = values["password"];
    BlocProvider.of<AuthBloc>(context).dispatch(SignUpEvent(
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      password: password
    ));
  }
}