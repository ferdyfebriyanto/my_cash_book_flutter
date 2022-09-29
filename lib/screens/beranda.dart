import 'package:flutter/material.dart';
import 'package:my_cash_book_flutter/charts/line_chart.dart';
import 'package:my_cash_book_flutter/db/database_instance.dart';
import 'package:my_cash_book_flutter/screens/create_screen.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  DatabaseInstance? databaseInstance;

  Future _refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Halaman Beranda"),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: databaseInstance!.totalPemasukan(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("-");
                  } else {
                    if (snapshot.hasData) {
                      return Text(
                          "Total pemasukan : Rp. ${snapshot.data.toString()}");
                    } else {
                      return Text("");
                    }
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: databaseInstance!.totalPengeluaran(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("-");
                  } else {
                    if (snapshot.hasData) {
                      return Text(
                          "Total pengeluaran : Rp. ${snapshot.data.toString()}");
                    } else {
                      return Text("");
                    }
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              LineChartSample7(),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Tombol meuju ke halaman create pemasukan
                        MaterialButton(
                          minWidth: 100,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateScreen()));
                          },
                          child: Expanded(
                            child:
                                Image.asset('assets/icons/pemasukan-icon.jpg'),
                          ),
                        ),
                        // Tombol meuju ke halaman create pengeluaran
                        MaterialButton(
                          minWidth: 100,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateScreen()));
                          },
                          child: Expanded(
                            child: Image.asset(
                                'assets/icons/pengeluaran-icon.jpg'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child:
                              Image.asset('assets/icons/detail-cash-icon.jpg'),
                        ),
                        Expanded(
                          child: Image.asset('assets/icons/setting-icon.jpg'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
