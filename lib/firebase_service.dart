

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService{
  static CollectionReference<Event>geteventscollection(){
    return FirebaseFirestore.instance.collection("events").withConverter<Event>(
      fromFirestore:(docsnapshot, _) =>Event.forJson (docsnapshot.data()!) , 
      toFirestore: (event, _) => event.toJson(),);

  }
  static CollectionReference<Usermodel>getuserscollection(){
    return FirebaseFirestore.instance.collection("Users").withConverter<Usermodel>(
      fromFirestore:(docsnapshot, _) =>Usermodel.fromJson (docsnapshot.data()!) , 
      toFirestore: (User, _) => User.toJson(),);

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
  static Future<List<Event>>geteventsfromfirestor(String? categoryID)async{
    CollectionReference<Event>eventscollection=geteventscollection();
    late QuerySnapshot<Event>querySnapshot;
    DateTime now = DateTime.now();
    DateTime today =DateTime(now.year, now.month, now.day);
 

    if(categoryID!=null&&categoryID!="0"){
      
      querySnapshot= await eventscollection.where("categoryID",isEqualTo: categoryID).where("date",isGreaterThanOrEqualTo: today).orderBy("date").get();


    }
      else{
          querySnapshot= await eventscollection.where("date",isGreaterThanOrEqualTo: today).orderBy("date").get();
        
      }
    return querySnapshot.docs.map((docsnapshot)=>docsnapshot.data()).toList();

  }
  static Future<Usermodel>register({
    required String name,
    required String email,
    required String password
  })async{
    UserCredential Credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
   Usermodel user= Usermodel(email: email, name: name, id: Credential.user!.uid,favEvents: []);
    CollectionReference<Usermodel>userscollection=getuserscollection();
    userscollection.doc(Credential.user!.uid).set(user);
    return user;
  }
 static Future <Usermodel>login({
    required String email,
    required String password
  })async{
    UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    CollectionReference<Usermodel>userscollection=getuserscollection();
    DocumentSnapshot<Usermodel>usersnapshot= await userscollection.doc(credential.user!.uid).get();
  
    return usersnapshot.data()!;
    
  }
  static Future<void> logout()async{
    await FirebaseAuth.instance.signOut();
  }
  static Future<void> addToFav(String eventid)async{
    CollectionReference<Usermodel>userscollection=getuserscollection();
    userscollection.doc(FirebaseAuth.instance.currentUser!.uid).update({"favEvents":FieldValue.arrayUnion([eventid])});

  }
  static Future<void> removeFromFav(String eventid)async{
    CollectionReference<Usermodel>userscollection=getuserscollection();
    userscollection.doc(FirebaseAuth.instance.currentUser!.uid).update({"favEvents":FieldValue.arrayRemove([eventid])});
    
  }
}