import 'package:flutter/material.dart';

import '../../components/components.dart';
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
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red[900],
                    content: Text(error, textAlign: TextAlign.center,),
                  )
                );
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
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          StreamBuilder<String>(
                            stream: widget.presenter.emailErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight,),
                                  errorText: snapshot.data?.isEmpty == true ? null : snapshot.data
                                ),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: widget.presenter.validateEmail,
                              );
                            }
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 32),
                            child: StreamBuilder<String>(
                              stream: widget.presenter.passwordErrorStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Senha',
                                    icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight,),
                                    errorText: snapshot.data?.isEmpty == true ? null : snapshot.data
                                  ),
                                  obscureText: true,
                                  onChanged: widget.presenter.validatePassword,
                                );
                              }
                            ),
                          ),
                          StreamBuilder<Object>(
                            stream: widget.presenter.isFormValidStream,
                            builder: (context, snapshot) {
                              return RaisedButton(
                                onPressed: snapshot.data == true ? widget.presenter.auth : null,
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
          );
          },
        ),
    );
  }
}