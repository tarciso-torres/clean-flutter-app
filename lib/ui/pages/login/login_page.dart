import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatelessWidget {

  final LoginPresenter presenter;

  const LoginPage({Key key, this.presenter}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LoginHeader(),
              HeadLine1(text: 'login'),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      StreamBuilder<String>(
                        stream: presenter.emailErrorStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight,),
                              errorText: snapshot.data?.isEmpty == true ? null : snapshot.data
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: presenter.validateEmail,
                          );
                        }
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 32),
                        child: StreamBuilder<String>(
                          stream: presenter.passwordErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight,),
                                errorText: snapshot.data?.isEmpty == true ? null : snapshot.data
                              ),
                              obscureText: true,
                              onChanged: presenter.validatePassword,
                            );
                          }
                        ),
                      ),
                      StreamBuilder<Object>(
                        stream: presenter.isFormValidStream,
                        builder: (context, snapshot) {
                          return RaisedButton(
                            onPressed: snapshot.data == true ? () {} : null,
                            child: Text('Entrar'.toUpperCase()),
                          );
                        }
                      ),
                      FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                        label: Text('Criar Conta'))
                    ],
                  ),),
              )
          ],
        ),
      ),
    );
  }
}