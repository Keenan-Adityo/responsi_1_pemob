import 'package:flutter/material.dart';
import 'package:responsi1/bloc/registrasi_bloc.dart';
import 'package:responsi1/styles/test_styles.dart';
import 'package:responsi1/widgets/custom_form_field.dart';
import 'package:responsi1/widgets/success_dialog.dart';
import 'package:responsi1/widgets/warning_dialog.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  bool _isLoading = false;
  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();
  final _password2TextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Registrasi",
            style: heading,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomFormField(
                textboxController: _namaTextboxController,
                labelText: 'Nama',
              ),
              SizedBox(
                height: 10,
              ),
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
              CustomFormField(
                textboxController: _password2TextboxController,
                labelText: 'Konfirmasi Password',
                isObscure: true,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  child: Text(
                    "Registrasi",
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
                    // }
                  }),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

  void _submit() {
    setState(() {
      _isLoading = true;
    });
    RegistrasiBloc.registrasi(
            nama: _namaTextboxController.text,
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SuccessDialog(
                description: "Registrasi berhasil, silahkan login",
                okClick: () {
                  Navigator.pop(context);
                },
              ));
    }, onError: (error) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Registrasi gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
