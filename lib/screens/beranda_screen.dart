import 'package:flutter/material.dart';
import 'package:my_cash_book_flutter/charts/line_chart.dart';
import 'package:my_cash_book_flutter/db/database_instance.dart';
import 'package:my_cash_book_flutter/screens/create_screen.dart';
import 'package:my_cash_book_flutter/screens/detail_cash_screen.dart';
import 'package:my_cash_book_flutter/screens/pengaturan_screen.dart';

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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
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
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    primary: false,
                    crossAxisCount: 2,
                    children: <Widget>[
                      Card(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateScreen()));
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/cash-in.jpg',
                                height: 128,
                              ),
                              Text('Tambah Pemasukan'),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateScreen()));
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/cash-out.jpg',
                                height: 128,
                              ),
                              Text('Tambah Pengeluaran'),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailCashFlow()));
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/cash-detail.jpg',
                                height: 128,
                              ),
                              Text('Detail Cash Flow'),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Pengaturan()));
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/setting.jpg',
                                height: 128,
                              ),
                              Text('Pengaturan'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
