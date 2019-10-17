import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fun_prize/blocs/auth/auth_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_event.dart';
import 'package:fun_prize/blocs/auth/auth_state.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      bloc: BlocProvider.of<AuthBloc>(context),
      listener: (context, state) {
        if (state.signUpFinished) {
          this._showSignUpFinishedModal();
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: FormBuilder(
                key: _formKey,
                autovalidate: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: 192,
                        child: Image.asset(Constants.logoAsset),
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
                      _fullNameFields,
                      SizedBox(height: 16),
                      _emailField,
                      SizedBox(height: 16),
                      _usernameField,
                      SizedBox(height: 16),
                      _yearField,
                      SizedBox(height: 16),
                      _programField,
                      SizedBox(height: 16),
                      _passwordAndConfirmationFields,
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)
                              ),
                              textColor: Constants.primaryColor,
                              onPressed: this.widget.onLoginButtonTapped,
                              child: Text("Se connecter"),
                            ),
                            FlatButton(
                              colorBrightness: Brightness.dark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)
                              ),
                              color: Constants.primaryColor,
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
    validators: [
      FormBuilderValidators.required(errorText: "Ce champ est requis")
    ],
  );

  Widget get _yearField => FormBuilderDropdown(
    attribute: "graduationYear",
    items: [2019, 2020, 2021, 2022, 2023, 2024]
      .map((year) => DropdownMenuItem<String>(
        value: "$year",
        child: Text("$year"),
      ))
      .toList(),
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black45, width: 0.5)
      ),
      labelText: "Année d'obtention de diplôme"
    ),
    validators: [
      FormBuilderValidators.required(errorText: "Ce champ est requis")
    ],
  );
  
  Widget get _programField => FormBuilderDropdown(
    attribute: "program",
    items: [
      "Grande école", "Bachelors", "SciencesCom", "Mastère spécialisé",
      "MBA", "DBA", "International Masters", "Executive éducation"
    ]
      .map((program) => DropdownMenuItem<String>(
        value: "$program",
        child: Text("$program"),
      ))
      .toList(),
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black45, width: 0.5)
      ),
      labelText: "Programme"
    ),
    validators: [
      FormBuilderValidators.required(errorText: "Ce champ est requis")
    ],
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
    final String graduationYear = values["graduationYear"];
    final String program = values["program"];
    BlocProvider.of<AuthBloc>(context).dispatch(SignUpEvent(
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      password: password,
      graduationYear: graduationYear,
      program: program
    ));
  }

  void _showSignUpFinishedModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        title: Text("Inscription réussie!"),
        content: Text(
          "Votre inscription a bien été prise en compte!\n"
          "Veuillez confirmer votre adresse email pour pouvoir vous connecter"
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Constants.primaryColor,
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          )
        ],
      )
    );
  }
}