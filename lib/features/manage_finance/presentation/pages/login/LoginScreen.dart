import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../../bloc/login/remote/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String email = "";
  String password = "";
  final LoginBloc bloc = sl();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: BlocProvider(
          create: (context){
            return bloc;
          },
          child: BlocListener<LoginBloc,LoginState>(
            listener: (context, state){
              if(state is LoginSuccess){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message))
                );
                Navigator.pushNamed(context, '/home');
              }
              if(state is LoginFailed){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message))
                );
              }
            },
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // log("Check for onpress");
                    bloc.add(AttemptLogin(email, password));
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/signup");
                  },
                  child: const Text('New User?'),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

  _buildAppBar(){
    return AppBar(
      title: const Text(
        'Login Page',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
