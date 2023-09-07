import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


// Todo : Simple Register API with Post
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Sign Up Api")),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email"
              ),
            ),
            SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: passController,
              decoration: InputDecoration(
                  hintText: "Password",
              ),
            ),

            SizedBox(
              height: 40,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: (){
                    signUpAPI(emailController.text.toString(), passController.text.toString());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                  child: Text("Sign Up", style: TextStyle(fontSize: 20),),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }



  void signUpAPI(String email, String password) async{
    try{
      Response response = await post(
        Uri.parse("https://reqres.in/api/register"),
        body: {
          'email' : email,
          'password': password,
        }
      );

      if(response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print(data["token"]);
        print("Account Created Successfully");
      } else {
        print("Failed");
      }

    } catch(e){
      print(e.toString());
    }

  }
}
