import 'package:flutter/material.dart';
import 'package:responsi1/bloc/logout_bloc.dart';
import 'package:responsi1/bloc/manajemen_stress_bloc.dart';
import 'package:responsi1/model/manajemen_stress.dart';
import 'package:responsi1/pages/login_page.dart';
import 'package:responsi1/pages/stress_detail_page.dart';
import 'package:responsi1/pages/stress_form_page.dart';
import 'package:responsi1/styles/test_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manajemen Stres',
          style: heading,
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StressFormPage()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(
                'Logout',
                style: normal,
              ),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: ManajemenStressBloc.getStress(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListStress(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListStress extends StatelessWidget {
  final List? list;
  const ListStress({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemStress(
            stress: list![i],
          );
        });
  }
}

class ItemStress extends StatelessWidget {
  final ManajemenStress stress;
  const ItemStress({Key? key, required this.stress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StressDetailPage(
                      stress: stress,
                    )));
      },
      child: Card(
        color: Colors.black,
        child: ListTile(
          title: Text(
            "Faktor : ${stress.stress_factor!} (Level ${stress.stress_level.toString()})",
            style: TextStyle(
              fontFamily: 'Georgia',
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            "Pengobatan : ${stress.coping_strategy}",
            style: TextStyle(
              fontFamily: 'Georgia',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
