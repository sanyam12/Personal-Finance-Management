import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/features/manage_finance/presentation/bloc/signup/remote/signup_bloc.dart';

import '../../../../../injection_container.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignupBloc bloc = sl();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: BlocProvider(
          create: (context){
            return bloc;
          },
          child: BlocListener<SignupBloc, SignupState>(
            listener: (context, state){
              if(state is SignupSuccess){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Registered as new user"))
                );
                Navigator.popAndPushNamed(context, '/home');
              }
              if(state is SignupFailed){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message))
                );
              }
            },
            child: Column(
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
                    bloc.add(AttemptSignup(email, password));
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Old User?'),
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
        'Create new Account',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
