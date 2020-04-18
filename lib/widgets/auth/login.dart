import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fun_prize/blocs/auth/auth_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_event.dart';
import 'package:fun_prize/utils/constants.dart';
import 'package:fun_prize/widgets/auth/reset_password.dart';


class Login extends StatefulWidget {
  final AuthBloc authBloc;
  final VoidCallback onSignUpButtonTapped;

  const Login({Key key, this.onSignUpButtonTapped, this.authBloc}) : super(key: key);

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
                padding: EdgeInsets.symmetric(horizontal: 16),
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
                          color: Theme.of(context).textTheme.display2.color
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    FormBuilderTextField(
                      attribute: "email",
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
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
                        focusColor: Theme.of(context).primaryColor,
                        border: OutlineInputBorder(),
                        labelText: "Mot de passe",
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            _isPasswordTextObscure ?
                            Icons.visibility :
                            Icons.visibility_off
                          ),
                          onPressed: _togglePasswordObscureText,
                        )
                      ),
                      obscureText: _isPasswordTextObscure,
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
                            textColor: Theme.of(context).primaryColor,
                            onPressed: widget.onSignUpButtonTapped,
                            child: Text("S'inscrire"),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)
                            ),
                            color: Theme.of(context).primaryColor,
                            onPressed: _login,
                            child: Text("Se connecter"),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                        ),
                        textColor: Theme.of(context).primaryColor,
                        onPressed: _loginWithFacebook,
                        child: Text("Se connecter avec Facebook"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                        ),
                        textColor: Theme.of(context).primaryColor,
                        onPressed: _resetPassword,
                        child: Text("Mot de passe oublié ?"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _resetPassword() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => Theme(
        data: Theme.of(context),
        child: ResetPassword()
      )
    ));
  }

  void _loginWithFacebook() {
    widget.authBloc.add(LoginWithFacebookEvent());
  }

  void _login() {
    if (!_formKey.currentState.saveAndValidate()) {
      return;
    }
    final values = _formKey.currentState.value;
    final String email = values["email"];
    final String password = values["password"];

    widget.authBloc.add(LoginEvent(
      email: email,
      password: password
    ));
  }

  void _togglePasswordObscureText() {
    setState(() => _isPasswordTextObscure = !_isPasswordTextObscure);
  }
}