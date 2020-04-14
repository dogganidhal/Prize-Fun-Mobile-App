import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fun_prize/blocs/auth/auth_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_event.dart';
import 'package:fun_prize/utils/contants.dart';


class Login extends StatefulWidget {
  final VoidCallback onSignUpButtonTapped;

  const Login({Key key, this.onSignUpButtonTapped}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isPasswordTextObscure = true;

  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    EdgeInsets safeAreaPadding = MediaQuery.of(context).padding;
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: screenSize.height - safeAreaPadding.top - safeAreaPadding.bottom,
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
                        "Connexion",
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
                        "Connectez vous pour continuer",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black45
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    FormBuilderTextField(
                      attribute: "email",
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Constants.primaryColor,
                            width: 0.5,
                          ),
                        ),
                        labelText: "Adresse Email",
                      ),
                      validators: [
                        FormBuilderValidators.required(errorText: "Ce champ est requis"),
                        FormBuilderValidators.email(errorText: "Adresse mail non valide")
                      ],
                    ),
                    SizedBox(height: 16),
                    FormBuilderTextField(
                      attribute: "password",
                      maxLines: 1,
                      decoration: InputDecoration(
                        focusColor: Constants.primaryColor,
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
                    ),
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
                            onPressed: this.widget.onSignUpButtonTapped,
                            child: Text("S'inscrire"),
                          ),
                          FlatButton(
                            colorBrightness: Brightness.dark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)
                            ),
                            color: Constants.primaryColor,
                            onPressed: _login,
                            child: Text("Se connecter"),
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
    );
  }

  void _login() {
    if (!_formKey.currentState.saveAndValidate()) {
      return;
    }
    final values = _formKey.currentState.value;
    final String email = values["email"];
    final String password = values["password"];
    BlocProvider.of<AuthBloc>(context).add(LoginEvent(
      email: email,
      password: password
    ));
  }

  void _togglePasswordObscureText() {
    this.setState(() => this._isPasswordTextObscure = !this._isPasswordTextObscure);
  }
}