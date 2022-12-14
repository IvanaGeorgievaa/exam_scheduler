import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_3_191118/model/user.dart';

import '../widgets/authentication_form.dart';

class AuthenticationScreen extends StatefulWidget {
  static const routeName = "/auth";

  final bool Function(User user)? _loginFunction;
  final bool Function(User user)? _registerFunction;

  final Function? _navigateToMainScreen;

  const AuthenticationScreen(
      this._loginFunction, this._registerFunction, this._navigateToMainScreen,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => AuthenticationScreenState();
}

class AuthenticationScreenState extends State<AuthenticationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _validate(String? username, String? password) {
    if (username == null || username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Username is required!"),
          duration: Duration(seconds: 1),
        ),
      );
      return false;
    }

    if (password == null || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password is required!"),
          duration: Duration(seconds: 1),
        ),
      );
      return false;
    }

    return true;
  }

  void _login() {
    if (_validate(_usernameController.text, _passwordController.text)) {
      User loginUser = User(_usernameController.text, _passwordController.text);
      bool isSuccessful = widget._loginFunction!(loginUser);
      if (isSuccessful) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Successfully logged in as ${loginUser.username}"),
            duration: const Duration(seconds: 2),
          ),
        );
        widget._navigateToMainScreen!();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Failed to log in!"),
              duration: Duration(seconds: 2)),
        );
      }
    }
  }

  void _register() {
    if (_validate(_usernameController.text, _passwordController.text)) {
      User newUser = User(_usernameController.text, _passwordController.text);
      bool result = widget._registerFunction!(newUser);

      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("You Registered successfully"),
          duration: Duration(seconds: 3),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to register!"),
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("User Authentication"),
        ),
        body: Column(
          children: [
            Expanded(
              child: AuthenticationForm(_formKey, [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      hintText: "Username",
                    ),
                    obscureText: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      _login();
                    },
                    child: const Text("Login"),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        _register();
                      },
                      child: const Text("Register"),
                    ))
              ]),
            ),
          ],
        ));
  }
}
