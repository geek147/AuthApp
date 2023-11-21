import 'dart:async';

import 'package:auth_app_flutter/bloc/auth_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../routes/app_routers.gr.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({
    super.key,
    required this.userName,
    required this.email,
    required this.password,
  });

  final String userName;
  final String email;
  final String password;
  static const routeName = '/otp-page';

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  List<TextEditingController> listOtpController = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  Timer? _timer;
  int _start = 30;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
        setState(() {
          _start = 30;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          AutoRouter.of(context).pushAndPopUntil(
            const LoginRoute(),
            predicate: (_) => false,
          );
        }

        if (state is AuthError) {
          final snackBar = SnackBar(
            content: Text(state.message),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('OTP Verification'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter the OTP sent to your number ending in 11',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildTextField(1),
                    buildTextField(2),
                    buildTextField(3),
                    buildTextField(4),
                    buildTextField(5),
                    buildTextField(6),
                  ],
                ),
                const SizedBox(height: 20),
                if (_start != 30)
                  Text(
                    'Resend OTP in $_start seconds',
                    style: const TextStyle(color: Colors.grey),
                  ),
                const SizedBox(height: 20),
                if (_start == 30)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _start = 30;
                      });
                      _startTimer();
                    },
                    child: const Text('Resend OTP'),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String input = "";
                    for (final controller in listOtpController) {
                      input = input + controller.text;
                    }
                    if (input == '111111') {
                      context.read<AuthBloc>().add(
                            SignUpEvent(
                              password: widget.password,
                              userName: widget.userName,
                              email: widget.email,
                            ),
                          );
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Please input correct OTP code'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text('Verify OTP'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTextField(int index) {
    return Container(
      width: 40,
      margin: const EdgeInsets.all(8),
      height: 40,
      child: TextField(
        controller: listOtpController[index - 1],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        onSubmitted: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        maxLength: 1,
        maxLines: 1,
        autofocus: false,
        style: const TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: const EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
