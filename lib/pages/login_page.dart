import 'package:flutter/material.dart';
import 'package:responsi1/bloc/login_bloc.dart';
import 'package:responsi1/helpers/user_info.dart';
import 'package:responsi1/pages/home_page.dart';
import 'package:responsi1/pages/registrasi_page.dart';
import 'package:responsi1/styles/test_styles.dart';
import 'package:responsi1/widgets/custom_form_field.dart';
import 'package:responsi1/widgets/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
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
                    style: heading.copyWith(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {
                    print(_emailTextboxController.text);
                    print(_passwordTextboxController.text);
                    // var validate = _formKey.currentState!.validate();
                    // if (validate) {
                    if (!_isLoading) _submit();
                    // ;
                    // _submit();
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum punya akun?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrasiPage(),
                            ));
                      },
                      child: Text("Registrasi"))
                ],
              )
            ],
          ),
        ));
  }

  void _submit() {
    setState(() {
      _isLoading = true;
    });
    LoginBloc.login(
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) async {
      if (value.code == 200) {
        await UserInfo().setToken(value.token!);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const WarningDialog(
                  description: "Login gagal, silahkan coba lagi",
                ));
      }
    }, onError: (error) {
      print(error);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Login gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
