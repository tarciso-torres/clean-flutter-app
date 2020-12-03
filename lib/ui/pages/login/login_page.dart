import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


import '../../components/components.dart';
import '../../helpers/helpers.dart';
import 'components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage({this.presenter});


  @override
  Widget build(BuildContext context) {
    void _hideKeyboard() {
    final currentFocus = FocusScope.of(context);
    if(!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          presenter.mainErrorStream.listen((error) {
            if (error != null) {
              showErrorMessage(context: context, error: error.description);
            }
          });

          presenter.navigateToStream.listen((page) {
            if (page?.isNotEmpty == true) {
              Get.offAllNamed(page);
            }
          });
          return GestureDetector(
            onTap: _hideKeyboard,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LoginHeader(),
                  HeadLine1(text: R.strings.login),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Provider(
                      create: (_) => presenter,
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            EmailInput(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 32),
                              child: PasswordInput(),
                            ),
                            LoginButton(),
                            FlatButton.icon(
                                onPressed: presenter.goToSignUp,
                                icon: Icon(Icons.person),
                                label: Text(R.strings.addAccount))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
