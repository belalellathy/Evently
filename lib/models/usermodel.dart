class Usermodel {
  String id;
  String name;
  String email;
  List<String> favEvents=[];
  Usermodel({
     required this.favEvents,required this.id,required this.name,required this.email});
      Usermodel.fromJson(Map<String,dynamic>json):id=json["id"],name=json["name"],email=json["email"],
      favEvents=(json["favEvents"]as List).cast<String>();
      Map<String,dynamic> toJson()=>{"id":id,"name":name,"email":email,"favEvents":favEvents};
}