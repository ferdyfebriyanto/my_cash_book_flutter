import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_cash_book_flutter/db/database_instance.dart';
import 'package:my_cash_book_flutter/models/transaksi_model.dart';

class UpdateScreen extends StatefulWidget {
  final TransaksiModel transaksiModel;
  const UpdateScreen({Key? key, required this.transaksiModel})
      : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int _value = 1;

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance.database();
    nameController.text = widget.transaksiModel.name!;
    totalController.text = widget.transaksiModel.total!.toString();
    dateController.text = widget.transaksiModel.updatedAt.toString();
    _value = widget.transaksiModel.type!;

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
        title: Text("Update"),
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
              Text("Nominal"),
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
                    await databaseInstance.update(widget.transaksiModel.id!, {
                      'name': nameController.text,
                      'type': _value,
                      'total': totalController.text,
                      'updated_at': dateController.text,
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Update")),
            ],
          ),
        )),
      ),
    );
  }
}
