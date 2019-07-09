import 'dart:collection';

import 'package:flutter/foundation.dart';


class PeopleModel extends ChangeNotifier{

  final List<People> _peoples = [];

  UnmodifiableListView<People> get items => UnmodifiableListView(_peoples);
  int get totalItems => items.length;

  void create(People people){
    _peoples.add(people);

    notifyListeners();
  }

  void read(People people){
    _peoples.contains(people);

    notifyListeners();
  }

  void update(People people){

  }

  void delete(People people){
    _peoples.remove(people);

    notifyListeners();
  }

  int getLastId(){
    if(_peoples.length > 0){
      int lastId = _peoples.last.idPeople + 1;
      return lastId++;
    }else{
      return 1;
    }
  }

}

class People{
  final int idPeople;
  final String namePeople;
  final int agePeople;

  People(this.idPeople, this.namePeople, this.agePeople);

}