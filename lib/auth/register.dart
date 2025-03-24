
import 'package:evently/firebase_service.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {

  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  bool _isObscured=true;
  final _text=TextEditingController();
  final _Nametext=TextEditingController();
  final _password=TextEditingController();
  String? _passerror;
String? _errorText;
String? _errorname;
bool _validatepass(){
  final password=_password.text;
  if(password.isEmpty){
    setState(() {
      _passerror="please enter your password";
    });
    return false;
  }else if(!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
    setState(() {
      _passerror="Password should contain special chracter";
    });
    return false;
  }else if(!password.contains(RegExp(r'[A-Z]'))){
    setState(() {
      _passerror="password should contain uppercase character";
    });
    return false;
  }
  else if(!password.contains(RegExp(r'[a-z]'))){
    setState(() {
      _passerror="password should contain lowercase character";
    });
    return false;
  }
  else if(!password.contains(RegExp(r'[\d]'))){
    setState(() {
      _passerror="password should contain numbers";
    });
    return false;
  }
  else if(password.length<8){
    setState(() {
      _passerror="password should be 8 chracters or more";
    });
    return false;
  }


  else{
    _passerror=null;
    return true;
  }
}
  bool _validateemail(){
    final email=_text.text;
    if(email.isEmpty){
      
      setState(() {
        _errorText="please enter your email";
      });
      return false;
    }else if(!email.endsWith("gmail.com")){
      setState(() {
        _errorText="please enter valid email address";
      });
      return false;
    }else {
      setState(() {
        _errorText=null;
        
      });
      return true;
    }
  }
  bool validatename(){
    String name=_Nametext.text;
    if(name.isEmpty){
      setState(() {
        _errorname="please enter your name";
      });
      return false;
    }
    else{
      setState(() {
        _errorname=null;
        
      });
      return true;
    }
  }
  @override
  void dispose(){
    _text.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
           Expanded(child:Image.asset("assets/images/Logo.png")),
          Expanded(
            flex: 2,
            child: Column(
            children: [
              Container(
                padding:  EdgeInsets.all(10),
                child: TextFormField(
                            controller: _Nametext,
                          
                            decoration:InputDecoration(
                              prefixIcon: Icon(Icons.person),
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.grey,width: 1)
                ),
                labelText: "Name",
                errorText: _errorname
                            ),
                
                          ),
              ),
              Container(
                padding:  EdgeInsets.all(10),
                child: TextFormField(
                            controller: _text,
                          
                            decoration:InputDecoration(
                              prefixIcon: Icon(Icons.email),
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.grey,width: 1)
                ),
                labelText: "Email",
                errorText: _errorText
                            ),
                
                          ),
              ),
          const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                            controller: _password,
                            
                            obscureText:_isObscured,
                          
                            decoration:InputDecoration(

                            prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(onPressed: (){
                  setState(() {
                    _isObscured=!_isObscured;
                  });
                }, 
                icon: Icon(
                  !_isObscured?Icons.visibility_outlined : Icons.visibility_off_outlined,
                ),),
                
                border:OutlineInputBorder(
                  
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.grey,width: 1)
                ),
                labelText: "Enter password",
                errorText: _passerror
                            ),
                
                          ),
              ),
            SizedBox(height: 8,),
            
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            
            children: [
            
              Container(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(onPressed:register,
                 
                
                style: ElevatedButton.styleFrom(
                  
                  backgroundColor: const Color(0xff1877F2),
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  )
                  
                
                  
                ), child: const Text("Create Account",style:TextStyle(
                  
                  fontSize: 20,
                  color: Colors.white
                ),
                )
                
                ),
              ),
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already Have Account ? ",style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              )),
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              },
                child: Text("Login",style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff1877F2),
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xff1877F2),),
                )
                )
            ],
          ),
            ],
          ),

          

          
          
         // SizedBox(height: 10,)
          

        ],
          )
      ),
      ]
      ),
      ),
    );
  }
  void register(){
    if(_validateemail()&&_validatepass()&&validatename()){
      FirebaseService.register(name: _Nametext.text, email: _text.text, password: _password.text).then((user){
        Provider.of<UserProvider>(context,listen: false).UpdateCurrentUser(user);
        Navigator.of(context).pushReplacementNamed("mainscreen");
      }).catchError((error){
        print(error);
      });
    }
  }
}