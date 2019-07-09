import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/People.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController _namePeopleController = TextEditingController();
  TextEditingController _agePeopleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var peoples = Provider.of<PeopleModel>(context);

    //peoples.create(new People(2, "Fabricia", 22));
    //peoples.create(new People(3, "Daniel", 25));

    //peoples.items.forEach((p)=>print(p.namePeople));

    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Pessoas"),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => _displayDialog(context),
//              peoples.create(
//                new People(1, "Israel", 26),
//              ),
          child: Icon(Icons.add),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        height: 500,
        child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            //itemCount: entries.length,
            itemCount: peoples.items.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => peoples.delete(peoples.items[index]),
                child: Container(
                  height: 50,
                  child: Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(peoples.items[index].idPeople.toString()),
                      Text(peoples.items[index].namePeople),
                      Text(peoples.items[index].agePeople.toString()),
                    ],
                  )),
                ),
              );
            }),
      ),
    );
  }

  _displayDialog(BuildContext context) async {
    var peoples = Provider.of<PeopleModel>(context);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Cadastro'),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _namePeopleController,
                    decoration: InputDecoration(hintText: "Seu nome"),
                  ),
                  TextField(
                    controller: _agePeopleController,
                    decoration: InputDecoration(hintText: "Sua idade"),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  _namePeopleController.clear();
                  _agePeopleController.clear();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('CADASTRAR'),
                onPressed: () {
                  peoples.create(new People(peoples.getLastId(), _namePeopleController.text, 80));
                  _namePeopleController.clear();
                  _agePeopleController.clear();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
