import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_cash_book_flutter/db/database_instance.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int _value = 1;

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance.database();
    super.initState();
  }

  // Variable/State untuk mengambil tanggal
  DateTime selectedDate = DateTime.now();

  //  Initial SelectDate FLutter
  Future<void> _selectDate(BuildContext context) async {
    // Initial DateTime FIinal Picked
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      print(formattedDate);
      setState(() {
        selectedDate = picked;
        dateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Transaksi"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Keterangan"),
              TextField(
                controller: nameController,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Tipe Transaksi"),
              ListTile(
                title: Text("Pemasukan"),
                leading: Radio(
                    groupValue: _value,
                    value: 1,
                    onChanged: (value) {
                      setState(() {
                        _value = int.parse(value.toString());
                      });
                    }),
              ),
              ListTile(
                title: Text("Pengeluaran"),
                leading: Radio(
                    groupValue: _value,
                    value: 2,
                    onChanged: (value) {
                      setState(() {
                        _value = int.parse(value.toString());
                      });
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Total"),
              TextField(
                controller: totalController,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Tanggal"),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Masukkan Tanggal",
                ),
                onTap: () {
                  _selectDate(context);
                },
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    int idInsert = await databaseInstance.insert({
                      'name': nameController.text,
                      'type': _value,
                      'total': totalController.text,
                      'created_at': dateController.text,
                      'updated_at': dateController.text,
                    });
                    print("sudah masuk : " + idInsert.toString());
                    Navigator.pop(context);
                  },
                  child: Text("Simpan")),
            ],
          ),
        )),
      ),
    );
  }
}
