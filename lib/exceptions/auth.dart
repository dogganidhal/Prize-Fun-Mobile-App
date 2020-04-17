import 'package:flutter/services.dart';

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  factory AuthException.fromPlatformException(PlatformException exception) => AuthException(
    _getMessage(exception.code)
  );

  static String _getMessage(String code) {
    switch(code) {
      case 'ERROR_INVALID_EMAIL':
        return "Adresse email non valide";
      case 'ERROR_WRONG_PASSWORD':
        return "Mot de passe incorrect";
      case 'ERROR_USER_NOT_FOUND':
        return "Utilisateur non trouvé";
      case 'ERROR_USER_DISABLED':
        return "Utilisateur désactivé";
      case 'ERROR_TOO_MANY_REQUESTS':
        return "Erreur, trop de requêtes";
      case 'ERROR_OPERATION_NOT_ALLOWED':
        return "Connexion non autorisée";
      case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        return "Compte existe avec une autre méthode de connexion";
      default:
        return null;
    }
  }
}