import 'package:flutter/material.dart';
import 'package:my_cash_book_flutter/db/database_instance.dart';
import 'package:my_cash_book_flutter/models/transaksi_model.dart';
import 'package:my_cash_book_flutter/screens/create_screen.dart';
import 'package:my_cash_book_flutter/screens/update_screen.dart';

class DetailCashFlow extends StatefulWidget {
  const DetailCashFlow({Key? key}) : super(key: key);

  @override
  State<DetailCashFlow> createState() => _DetailCashFlowState();
}

class _DetailCashFlowState extends State<DetailCashFlow> {
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

  showAlertDialog(BuildContext contex, int idTransaksi) {
    Widget okButton = TextButton(
      child: Text("Yakin"),
      onPressed: () {
        //delete disini
        databaseInstance!.hapus(idTransaksi);
        Navigator.of(contex, rootNavigator: true).pop();
        setState(() {});
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Peringatan !"),
      content: Text("Anda yakin akan menghapus ?"),
      actions: [okButton],
    );

    showDialog(
        context: contex,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Cash Flow"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateScreen()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
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
                    return Text("Total pemasukan: Rp. 0");
                  }
                }
              },
            ),
            SizedBox(
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
                    return Text("Total pengeluaran: Rp. 0");
                  }
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<TransaksiModel>>(
                future: databaseInstance!.getAll(),
                builder: (context, snapshot) {
                  print('HASIL : ' + snapshot.data.toString());
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  } else {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(snapshot.data![index].name!),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index].total!.toString(),
                                      style: TextStyle(
                                        color: Color(0xFF0084FF),
                                      ),
                                    ),
                                    Text(snapshot.data![index].updatedAt!
                                        .toString()),
                                  ],
                                ),
                                leading: snapshot.data![index].type == 1
                                    ? Icon(
                                        Icons.download,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.upload,
                                        color: Colors.red,
                                      ),
                                trailing: Wrap(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateScreen(
                                                        transaksiModel: snapshot
                                                            .data![index],
                                                      )))
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.grey,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          showAlertDialog(context,
                                              snapshot.data![index].id!);
                                        },
                                        icon: Icon(Icons.delete,
                                            color: Colors.red))
                                  ],
                                ),
                              );
                            }),
                      );
                    } else {
                      return Text("Tidak ada data");
                    }
                  }
                })
          ],
        )),
      ),
    );
  }
}
