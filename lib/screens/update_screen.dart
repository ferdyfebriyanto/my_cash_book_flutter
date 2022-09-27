import 'package:flutter/material.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  final int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nama"),
              TextField(),
              SizedBox(
                height: 20,
              ),
              Text("Tipe Transaksi"),
              ListTile(
                title: Text("Pemasukan"),
                leading: Radio(
                  groupValue: _value,
                  value: 1,
                  onChanged: (value) {},
                ),
              ),
              ListTile(
                title: Text("Pengeluaran"),
                leading: Radio(
                  groupValue: _value,
                  value: 2,
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Total"),
              TextField(),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
