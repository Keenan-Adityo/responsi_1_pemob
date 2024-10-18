import 'package:flutter/material.dart';

import 'package:responsi1/bloc/manajemen_stress_bloc.dart';
import 'package:responsi1/model/manajemen_stress.dart';
import 'package:responsi1/pages/home_page.dart';
import 'package:responsi1/styles/test_styles.dart';
import 'package:responsi1/widgets/custom_form_field.dart';
import 'package:responsi1/widgets/warning_dialog.dart';

class StressFormPage extends StatefulWidget {
  ManajemenStress? stress;
  StressFormPage({
    Key? key,
    this.stress,
  }) : super(key: key);

  @override
  State<StressFormPage> createState() => _StressFormPageState();
}

class _StressFormPageState extends State<StressFormPage> {
  bool _isLoading = false;
  final _factorTextboxController = TextEditingController();
  final _copingTextboxController = TextEditingController();
  final _levelTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            (widget.stress) != null ? "Edit Stress" : "Create Stress",
            style: heading,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomFormField(
                textboxController: _factorTextboxController,
                labelText: 'Faktor Stress',
              ),
              SizedBox(
                height: 10,
              ),
              CustomFormField(
                textboxController: _copingTextboxController,
                labelText: 'Coping Strategy',
              ),
              SizedBox(
                height: 10,
              ),
              CustomFormField(
                textboxController: _levelTextboxController,
                labelText: 'Level Stress',
                inputType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  child: Text(
                    (widget.stress) != null ? "Edit Stress" : "Create Stress",
                    style: heading.copyWith(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {
                    print(_factorTextboxController.text);
                    print(_copingTextboxController.text);
                    // var validate = _formKey.currentState!.validate();
                    // if (validate) {
                    if (!_isLoading) {
                      if (widget.stress != null) {
                        edit();
                      } else {
                        create();
                      }
                    }
                    // ;
                    // _submit();
                  }),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

  void create() {
    setState(() {
      _isLoading = true;
    });
    ManajemenStress createStress = ManajemenStress(id: null);
    createStress.stress_factor = _factorTextboxController.text;
    createStress.coping_strategy = _copingTextboxController.text;
    createStress.stress_level = int.parse(_levelTextboxController.text);
    ManajemenStressBloc.addStress(stress: createStress).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const HomePage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  edit() {
    print(widget.stress!.id!);
    setState(() {
      _isLoading = true;
    });
    ManajemenStress updateStress = ManajemenStress(id: widget.stress!.id!);
    updateStress.stress_factor = _factorTextboxController.text;
    updateStress.coping_strategy = _copingTextboxController.text;
    updateStress.stress_level = int.parse(_levelTextboxController.text);
    ManajemenStressBloc.updateStress(stress: updateStress).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const HomePage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
