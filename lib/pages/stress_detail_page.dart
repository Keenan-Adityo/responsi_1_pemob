import 'package:flutter/material.dart';

import 'package:responsi1/bloc/manajemen_stress_bloc.dart';
import 'package:responsi1/model/manajemen_stress.dart';
import 'package:responsi1/pages/home_page.dart';
import 'package:responsi1/pages/stress_form_page.dart';
import 'package:responsi1/styles/test_styles.dart';
import 'package:responsi1/widgets/custom_form_field.dart';
import 'package:responsi1/widgets/warning_dialog.dart';

class StressDetailPage extends StatefulWidget {
  ManajemenStress? stress;

  StressDetailPage({
    Key? key,
    this.stress,
  }) : super(key: key);

  @override
  State<StressDetailPage> createState() => _StressDetailPageState();
}

class _StressDetailPageState extends State<StressDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Stress Detail",
            style: heading,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              Text(
                "Faktor : ${widget.stress!.stress_factor}",
                style: normal,
              ),
              Text(
                "Level : ${widget.stress!.stress_level}",
                style: normal,
              ),
              Text(
                "Coping : ${widget.stress!.coping_strategy}",
                style: normal,
              ),
              ElevatedButton(
                  child: Text(
                    "Edit Stress",
                    style: heading.copyWith(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StressFormPage(
                                  stress: widget.stress,
                                )));
                  }),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  child: Text(
                    "Hapus Stress",
                    style: heading.copyWith(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black),
                  ),
                  onPressed: () => confirmHapus()),
            ],
          ),
        ));
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text(
        "Yakin ingin menghapus data ini?",
        style: TextStyle(fontFamily: 'Georgia'),
      ),
      actions: [
//tombol hapus
        OutlinedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black)),
          child: const Text(
            "Ya",
            style: TextStyle(fontFamily: 'Georgia', color: Colors.white),
          ),
          onPressed: () {
            ManajemenStressBloc.deleteStress(id: widget.stress!.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomePage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
//tombol batal
        OutlinedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black)),
          child: const Text(
            "Batal",
            style: TextStyle(fontFamily: 'Georgia', color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
