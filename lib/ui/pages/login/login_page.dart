import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import 'components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {

  final LoginPresenter presenter;

  const LoginPage({Key key, this.presenter}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
          builder: (context) {
            widget.presenter.isloadingStream.listen((isLoading) { 
            if(isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
            });

            widget.presenter.mainErrorStream.listen((error) {
              if(error != null) {
                showErrorMessage(context: context, error: error);
              }
            });
            return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                LoginHeader(),
                  HeadLine1(text: 'login'),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Provider(
                        create: (_) => widget.presenter,
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              EmailInput(),
                              Padding(
                                padding: const EdgeInsets.only(top: 8, bottom: 32),
                                child: PasswordInput(),
                              ),
                              LoginButton(),
                              FlatButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.person),
                                label: Text('Criar Conta'))
                            ],
                          ),),
                      ),
                    )
                ],
              ),
            );
          },
        ),
    );
  }
}



