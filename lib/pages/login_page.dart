import 'package:flutter/material.dart';
import 'package:responsi1/styles/test_styles.dart';
import 'package:responsi1/widgets/custom_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Login",
            style: heading,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomFormField(
                textboxController: _emailTextboxController,
                labelText: 'Email',
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10,
              ),
              CustomFormField(
                textboxController: _passwordTextboxController,
                labelText: 'Password',
                isObscure: true,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  child: Text(
                    "Login",
                    style: heading,
                  ),
                  onPressed: () {
                    print(_emailTextboxController.text);
                    print(_passwordTextboxController.text);
                    // var validate = _formKey.currentState!.validate();
                    // if (validate) {
                    //   if (!_isLoading) _submit();
                    // }
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum punya akun?"),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(onPressed: () {}, child: Text("Registrasi"))
                ],
              )
            ],
          ),
        ));
  }
}
