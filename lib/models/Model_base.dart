
import 'package:floor/floor.dart';

class ModelBase{

  @PrimaryKey(autoGenerate: true)
  final int ?id;
  int ?serverId;
  ModelBase({this.id, this.serverId});

  // GETs
  int? getId(){
    return id;
  }

  int? getServerId(){
    return serverId;
  }

  // SETs
  void setServerId(int? serverId){
    this.serverId = serverId;
  }

}