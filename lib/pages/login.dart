import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learn_flutter101/pages/register.dart';
import 'package:learn_flutter101/pages/showtrip.dart';

class LoginPage extends StatefulWidget {
   LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   String text = '';
   int number = 0;
   String phoneNo = '';
   TextEditingController phoneNoCtl = TextEditingController();
   final TextEditingController phoneCt1 = TextEditingController();
   final TextEditingController passCt1 = TextEditingController();
   String? errorText;

  @override
   Widget build(BuildContext context) {
    return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(35,50,20,0),
                  child: GestureDetector(
                    onDoubleTap: ()
                    {
                      log("onDoubleTap is fired");
                    },
                    child: Image.asset('assets/images/logo.png')),
                ),
                 Padding(
                  padding: const EdgeInsets.fromLTRB(20,10,20,3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                    Text(
                    'หมายเลขโทรศัพท์',
                    style: TextStyle(fontSize: 20,color :Colors.black),
                  ),
                  TextField(
		                controller: phoneCt1,
		                // onChanged: (value) {
		                //  phoneNo = value;
		                // },
		                keyboardType: TextInputType.phone,
		                decoration: const InputDecoration(
		                	border: OutlineInputBorder(
				                borderSide:BorderSide(width: 1)
                    )
                    ),
	                ),
                ]
              ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,10,20,3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                    Text(
                    'รหัสผ่าน',
                    style: TextStyle(fontSize: 20,color :Colors.black),
                  ),
                  TextField(
                    controller: passCt1,
                    obscureText: true,
                    decoration: const InputDecoration(          
                    border: OutlineInputBorder(),
                    ),
	                ),
                   const SizedBox(height: 12),
            if (errorText != null)
              Text(errorText!, style: const TextStyle(color: Colors.red)),
                ]
              ),
              
                ),
                
                Row(
                  children: [
                    Padding(
                  padding: EdgeInsets.fromLTRB(20,10,0,0),
                  child: FilledButton(onPressed: register,
                  child: const Text('ลงทะเบียน',
                  style: TextStyle(fontSize: 25,color: Colors.white),),),
                    ),
                    Padding(
                  padding: EdgeInsets.fromLTRB(50,10,0,0),
                  child: FilledButton(
                      onPressed: login,
                      child: const Text(
	                    'เข้าสู่ระบบ',
                  style: TextStyle(fontSize: 25,color: Colors.white),)),
                  
                   )
                  ],
                ),
                Text(text ,style:const TextStyle(fontSize: 20))
              ],
            ),
          ),
      );
    }
              /*void login() {
    http.get(Uri.parse("http://YOUR_IP:3000/customers")).then(
      (value) {
        log(value.body);
      },
    ).catchError((error) {
      log('Error $error');
    });
  }*/
              
              void login() {
                setState(() {
                  errorText = null;
                });

                if (phoneCt1.text.trim().isEmpty || passCt1.text.trim().isEmpty) {
                  setState(() {
                    errorText = "กรุณากรอกหมายเลขโทรศัพท์และรหัสผ่าน";
                  });
                  return;
                }

              
                if (phoneCt1.text.trim() == "0812345678" && passCt1.text.trim() == "1234") {                  
                  setState(() {
                    errorText = null;
                  });                
                  Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => const ShowTripPage()),
                   );
                } else {
                    setState(() {
                    errorText = "เบอร์โทรหรือรหัสผ่านไม่ถูกต้อง";
                   });
                }
              }

              void register() {       
                setState(() {
                  errorText = null;
                });
                
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                     builder: (context) => const RegisterPage(),
                    ));
              }
              
}
              
