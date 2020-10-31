import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fun_prize/blocs/auth/auth_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_state.dart';
import 'package:fun_prize/utils/constants.dart';
import 'package:fun_prize/widgets/auth/cgu_privacy_policy_link.dart';


class SignUp extends StatefulWidget {
  final AuthBloc authBloc;
  final VoidCallback onLoginButtonTapped;

  const SignUp({Key key, this.onLoginButtonTapped, this.authBloc}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isPasswordTextObscure = true;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    EdgeInsets safeAreaPadding = MediaQuery.of(context).padding;
    Size screenSize = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      bloc: widget.authBloc,
      listener: (context, state) {
        if (state.signUpFinished) {
          this._showSignUpFinishedModal();
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: screenSize.height - safeAreaPadding.top - safeAreaPadding.bottom + (4/3),
            child: Center(
              child: FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            color: Theme.of(context).textTheme.display2.color
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
                              textColor: Theme.of(context).primaryColor,
                              onPressed: this.widget.onLoginButtonTapped,
                              child: Text("Se connecter"),
                            ),
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)
                              ),
                              color: Theme.of(context).primaryColor,
                              onPressed: _signUp,
                              child: Text("S'inscrire"),
                            )
                          ],
                        ),
                      ),
                      CGUPrivacyPolicyLink()
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
        borderSide: BorderSide(width: 0.5)
      ),
      labelText: "Adresse Email"
    ),
    validators: [
      FormBuilderValidators.required(errorText: "Ce champ est requis"),
      FormBuilderValidators.email(errorText: "Adresse mail non valide")
    ],
  );

  Widget get _usernameField => FormBuilderTextField(
    attribute: "username",
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

  Widget get _passwordAndConfirmationFields => FormBuilderTextField(
    attribute: "password",
    maxLines: 1,
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

    widget.authBloc.signUp(
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      password: password
    );
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
            textColor: Theme.of(context).primaryColor,
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          )
        ],
      )
    );
  }
}
