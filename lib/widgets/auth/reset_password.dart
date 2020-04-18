import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fun_prize/blocs/reset_password/reset_password_bloc.dart';
import 'package:fun_prize/blocs/reset_password/reset_password_event.dart';
import 'package:fun_prize/blocs/reset_password/reset_password_state.dart';
import 'package:fun_prize/utils/constants.dart';


class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final ResetPasswordBloc _resetPasswordBloc = ResetPasswordBloc();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    EdgeInsets safeAreaPadding = MediaQuery.of(context).padding;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener(
        bloc: _resetPasswordBloc,
        listener: (context, state) {
          if (state is PasswordResetSuccessfulState) {
            _showEmailSentModal();
          }
        },
        child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
          bloc: _resetPasswordBloc,
          builder: (context, state) => Stack(
            children: [
              if (state is ResetPasswordState && state.isLoading != null && state.isLoading)
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  child: LinearProgressIndicator()
                ),
              Positioned.fill(
                child: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height: screenSize.height - safeAreaPadding.top - safeAreaPadding.bottom - kToolbarHeight,
                    child: Center(
                      child: _requestCode(context)
                    ),
                  ),
                ),
              ),
              )
            ]
          ),
        ),
      ),
    );
  }

  Widget _requestCode(BuildContext context) => FormBuilder(
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
              "Mot de passe oublié",
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
              "Renseigner votre email pour continuer",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.display2.color
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(height: 32),
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
          SizedBox(height: 32),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)
              ),
              textColor: Theme.of(context).primaryColor,
              onPressed: _submitResetRequest,
              child: Text("Demander un code de réinitialization"),
            ),
          ),
        ],
      ),
    ),
  );

  void _submitResetRequest() {
    if (!_formKey.currentState.saveAndValidate()) {
      return;
    }
    final email = _formKey.currentState.value['email'];

    _resetPasswordBloc.add(RequestResetCodeEvent(email: email));
  }

  void _showEmailSentModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        title: Text("Demande de réinitialization"),
        content: Text(
          "Votre demande de réinitialization a bien été prise en compte!\n"
          "Veuillez consulter votre boite email pour les instructions de création d'un nouveau mot de passe"
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: () async {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          )
        ],
      )
    );
  }
}