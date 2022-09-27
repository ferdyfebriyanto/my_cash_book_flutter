import 'package:flutter/material.dart';
import 'package:my_cash_book_flutter/screens/create_screen.dart';
import 'package:my_cash_book_flutter/screens/update_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Cash Book',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("Yakin"),
      onPressed: () {},
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Peringatan"),
      content: Text("Apakah anda yakin ingin menghapus data ini?"),
      actions: [
        okButton,
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Kelola Keuangan'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateScreen(),
              ));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text('Total Pemasukan : Rp. 1000'),
            SizedBox(height: 10),
            Text('Total Pengeluaran : Rp. 500'),
            ListTile(
              title: Text("Makan Siang"),
              subtitle: Text("Rp. 200.000"),
              leading: Icon(
                Icons.download,
                color: Colors.green,
              ),
              trailing: Wrap(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdateScreen(),
                        ));
                      },
                      icon: Icon(Icons.edit),
                      color: Colors.grey),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
