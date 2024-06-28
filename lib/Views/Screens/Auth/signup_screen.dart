
import 'package:flutter/material.dart';
import 'package:tiktok_clone/Views/Screens/Auth/login_screen.dart';
import 'package:tiktok_clone/Views/Widgets/text_input_field.dart';
import 'package:tiktok_clone/constants.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('TikTok Clone', style: TextStyle(fontSize: 35, color: buttonColor, fontWeight: FontWeight.w900,),),
            const Text('Register', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700,),),
            const SizedBox(height: 25,),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.person, size: 100,),
                ),
                Positioned(bottom: -10, left: 80 ,child: IconButton(onPressed: ()=> authController.pickImage(), icon: const Icon(Icons.add_a_photo),),),
              ],
            ),
            const SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _usernameController,
                labelText: "Username",
                icon: Icons.person,
              ),
            ),
            const SizedBox(height: 25,),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _emailController,
                labelText: "Email",
                icon: Icons.email,
              ),
            ),
            const SizedBox(height: 25,),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                labelText: "Password",
                icon: Icons.lock,
                isObscure: true,
              ),
            ),
            const SizedBox(height: 30,),
            Container(
              width: MediaQuery.of(context).size.width-40,
              height: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.all(Radius.circular(5),),
              ),
              child: InkWell(
                onTap: ()=> authController.registerUser(_usernameController.text, _emailController.text, _passwordController.text, authController.profilePhoto),
                child: const Center(child: Text('Register', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,),),),
              ),
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? ", style: TextStyle(fontSize: 20,),),
                InkWell(
                  onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen(),),),
                  child: Text("Login", style: TextStyle(fontSize: 20, color: buttonColor,),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
