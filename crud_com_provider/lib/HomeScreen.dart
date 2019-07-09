import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/People.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController _namePeopleController = TextEditingController();
  TextEditingController _agePeopleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var peoples = Provider.of<PeopleModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Pessoas"),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => _displayDialog(context, null),
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        height: double.maxFinite,
        child: peoples.items.isNotEmpty ? ListView.builder(
            padding: const EdgeInsets.all(8.0),
            //itemCount: entries.length,
            itemCount: peoples.items.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => peoples.delete(peoples.items[index]),
                onLongPress: ()=> _displayDialog(context, peoples.items[index]),
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
            }) : Center(child: Text("Nenhuma pessoa cadastrada"),),
      ),
    );
  }

  _displayDialog(BuildContext context, People people) async {
    var peoples = Provider.of<PeopleModel>(context);
    if(people != null){
      int id = people.idPeople;
      _namePeopleController.text = people.namePeople;
    }
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
                    keyboardType: TextInputType.number,
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
                  peoples.create(new People(peoples.getLastId(), _namePeopleController.text, 50));
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
