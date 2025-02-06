

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event.dart';

class FirebaseService{
  static CollectionReference<Event>geteventscollection(){
    return FirebaseFirestore.instance.collection("events").withConverter<Event>(
      fromFirestore:(docsnapshot, _) =>Event.forJson (docsnapshot.data()!) , 
      toFirestore: (event, _) => event.toJson(),);

  }
  static Future<void> addEventToFirestore(Event event)async{
      CollectionReference<Event>eventscollection= geteventscollection();
      DocumentReference<Event>docref= eventscollection.doc();
      event.id=docref.id;
      return docref.set(event);
  }
 static Future<void> overwriteEvent(Event event ) {
     CollectionReference<Event>eventscollection= geteventscollection();
      DocumentReference<Event>docref= eventscollection.doc(event.id);
      
      return docref.set(event);
    

  }
  static Future<List<Event>>geteventsfromfirestor()async{
    CollectionReference<Event>eventscollection=geteventscollection();
    QuerySnapshot<Event>querySnapshot=await eventscollection.get();
    return querySnapshot.docs.map((docsnapshot)=>docsnapshot.data()).toList();

  }
}