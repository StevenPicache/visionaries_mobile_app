


class Services{

//  String JobName;
//  String JobDescription;
//  String recommended_Solutions;

  int id;
  String name;
  String quote;
  String origin;
  bool isFinished;


  //Services({this.JobName, this.JobDescription, this.recommended_Solutions});

  Services({this.id, this.name, this.quote, this.origin, this.isFinished=false});

  void setStatus(bool param1)
  {
     this.isFinished = param1;
  }

  bool getStatus()
  {
    return this.isFinished;
  }

}