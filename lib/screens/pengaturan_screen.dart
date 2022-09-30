import 'package:flutter/material.dart';
import 'package:my_cash_book_flutter/db/database_instance.dart';
import 'package:my_cash_book_flutter/models/user_model.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({super.key});

  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController passwordLamaController = TextEditingController();
  TextEditingController passwordBaruController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: const Text(
                  'Ganti Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                controller: passwordLamaController,
                decoration: const InputDecoration(
                  labelText: 'Password Lama',
                ),
              ),
              TextField(
                controller: passwordBaruController,
                decoration: const InputDecoration(
                  labelText: 'Password Baru',
                ),
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Simpan'))
            ],
          ),
        ),
      ),
    );
  }
}
