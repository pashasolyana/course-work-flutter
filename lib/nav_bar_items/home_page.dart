import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/country.dart';

import '../repository/convert_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Country fromCountry = datas[0];
  Country toCountry = datas[1];
  double value = 1;
  late Future<double> resFuture;
  @override
  void initState() {
    super.initState();
    _requestConvert();
  }

  _requestConvert() {
    resFuture = ConvertRepo().convert(
        fromCurr: fromCountry.currency,
        toCurr: toCountry.currency,
        value: value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.grey[100],
          title: Text('CURRENCY COVNERTER',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child : SingleChildScrollView(
          child: Column(
            children: [
              _buildCurrencyView(fromCountry, false),
               SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.indigo.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 3))
                        ]),
                    child: Center(
                      child: Text('=',
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.07, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        final temp = fromCountry;
                        fromCountry = toCountry;
                        toCountry = temp;
                        _requestConvert();
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                          color: Colors.indigo[50],
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.indigo)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Image.asset('assets/up-down.png', height: MediaQuery.of(context).size.height * 0.1),
                            Text('Switch Currencies',
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: MediaQuery.of(context).size.width * 0.05,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              FutureBuilder<double>(
                  future: resFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _buildCurrencyView(toCountry, true,
                          res: snapshot.data);
                    }
                    return SizedBox.shrink();
                  })
            ],
          ),
      )
      ),
    );
  }

  Container _buildCurrencyView(Country country, bool isDestination,
      {double? res}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: Colors.indigo.withOpacity(0.3), spreadRadius: 2, blurRadius: 4, offset: Offset(0, 3))]),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => _buildMenuCurrency(isDestination),
                child: Row(
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(5), child: Image.asset('assets/'+ country.urlFlag,height: MediaQuery.of(context).size.height * 0.06, width: MediaQuery.of(context).size.width * 0.06)),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(country.name, style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.035, fontWeight: FontWeight.w600)), Text(country.currency, style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.035, fontWeight: FontWeight.w400)),],),
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey)
                  ],
                ),
              ),
              TextFormField(
                key:
                    isDestination ? Key(res.toString()) : Key(value.toString()),
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.07, fontWeight: FontWeight.w500),
                initialValue: isDestination ? res.toString() : value.toString(),
                onFieldSubmitted: (val) {
                  setState(() {
                    value = double.parse(val);
                    _requestConvert();
                  });
                },
                decoration: InputDecoration(
                    hintText: '0.0',
                    enabled: !isDestination,
                    suffixIcon: Text(country.currency,
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, color: Colors.grey)),
                    suffixIconConstraints:
                    BoxConstraints(minWidth: 0, minHeight: 0)),
              )
            ]),
      ),
    );
  }

  _buildMenuCurrency(bool isDestination) {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoActionSheet(
              actions: _buildListActions(onPressed: (index) {
                setState(() {
                  isDestination
                      ? toCountry = datas[index]
                      : fromCountry = datas[index];
                  _requestConvert();
                  Navigator.pop(context);
                });
              }),
              cancelButton: CupertinoActionSheetAction(
                  isDestructiveAction: true,
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
            ));
  }

  List<Widget> _buildListActions({required Function(int) onPressed}) {
    var listActions = <Widget>[];
    for (var i = 0; i < datas.length; i++) {
      listActions.add(CupertinoActionSheetAction(
          onPressed: () => onPressed(i), child: Text(datas[i].name)));
    }
    return listActions;
  }
}
