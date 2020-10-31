import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fun_prize/widgets/auth/cgu_privacy_policy.dart';


class CGUPrivacyPolicyLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text.rich(
        TextSpan(
          text: "En vous inscrivant sur Prize&Fun, vous acceptez nos ",
          style: TextStyle(
            color: Theme.of(context).textTheme.display2.color
          ),
          children: [
            TextSpan(
              text: "CGU",
              style: TextStyle(
                  color: Theme.of(context).primaryColor
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GCUPrivacyPolicy(
                      pdf: PDFWidget.CGU,
                    )
                ))
            ),
            TextSpan(
              text: " et notre ",
              style: TextStyle(
                  color: Theme.of(context).textTheme.display2.color
              ),
            ),
            TextSpan(
              text: "Politique de confidentialité",
              style: TextStyle(
                  color: Theme.of(context).primaryColor
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GCUPrivacyPolicy(
                      pdf: PDFWidget.PRIVACY_POLICY,
                    )
                ))
            ),
          ]
        ),
      ),
    );
  }

}
