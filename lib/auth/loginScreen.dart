
import 'package:evently/apptheme.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/providers/settings_provide.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _isObscured=true;
  final _text=TextEditingController();
  final _password=TextEditingController();
  String? _passerror;
String? _errorText;
bool _validatepass(){
  final password=_password.text;
  if(password.isEmpty){
    setState(() {
      _passerror="please enter your password";
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
    }else {
      setState(() {
        _errorText=null;
        
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
    SettingsProvide settingsProvider=Provider.of<SettingsProvide>(context);
    return Scaffold(
      body: SafeArea(child: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                 Expanded(child:Image.asset("assets/images/Logo.png")),
                Expanded(
                  flex: 2,
                  child: Column(
                  children: [
                    Container(
                      padding:  const EdgeInsets.all(10),
                      child: TextFormField(
                        style: TextStyle(color: settingsProvider.isDark?Colors.white:Colors.black),
                        
                                  controller: _text,
                                
                                  decoration:InputDecoration(
                                    labelStyle: TextStyle(color: settingsProvider.isDark?Colors.white:Colors.black),
                                     
                                    prefixIcon: Icon(Icons.email,color: settingsProvider.isDark?Colors.white:Colors.black,),
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:  BorderSide(color:settingsProvider.isDark?Apptheme.blue:Colors.grey,width: 1)
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
                            style: TextStyle(color: settingsProvider.isDark?Colors.white:Colors.black),
                                  controller: _password,
                                  
                                  obscureText:_isObscured,
                                
                                  decoration:InputDecoration(
                                    labelStyle: TextStyle(color: settingsProvider.isDark?Colors.white:Colors.black),
            
                                  prefixIcon: Icon(Icons.lock,color: settingsProvider.isDark?Colors.white:Colors.black,),
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          _isObscured=!_isObscured;
                        
                        });
                      }, 
                      icon: Icon(
                        !_isObscured?Icons.visibility_outlined : Icons.visibility_off_outlined,color: settingsProvider.isDark?Colors.white:Colors.black,
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
                  const SizedBox(height: 8,),
                  Align(
                    alignment: Alignment.centerRight,
                  child: TextButton(onPressed: (){}, child: const Text("Forget Password?",style: TextStyle(
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xff5669FF),
                            color: Color(0xff5669FF)
                            ),),),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  
                  children: [
                  
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(onPressed: login,
                      
                      style: ElevatedButton.styleFrom(
                        
                        backgroundColor: const Color(0xff1877F2),
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        )
                        
                      
                        
                      ), child: const Text("Login",style:TextStyle(
                        
                        fontSize: 20,
                        color: Colors.white
                      ),
                      )
                      
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t Have Account ? ",style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: settingsProvider.isDark?Colors.white:Colors.black
                    )),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushNamed("register");
                    },
                      child: const Text("Create Account",style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff1877F2),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xff1877F2),),
                      )
                      )
                  ],
                ),
              ],
                )
            ),
            ]
            ),
          ),
        ],
      ),
      ),
    );
  }
    void login(){
    if(_validateemail()&&_validatepass()){
      FirebaseService.login( email: _text.text, password: _password.text).then((user){
        Provider.of<UserProvider>(context,listen: false).UpdateCurrentUser(user);
        Navigator.of(context).pushReplacementNamed("mainscreen");
      
      }).catchError((error){
            ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Text("invalid email or password",style: TextStyle(
            color: Colors.white,
            fontSize: 16
          ),),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
        print(error);
      });
    }
  }
}