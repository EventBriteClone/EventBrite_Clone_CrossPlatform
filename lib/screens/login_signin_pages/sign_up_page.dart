import '../../reusable_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        
      ),
      
      body: Column(
        children: [
          CustomTextField(
            hintText: "ggfh",
          ),
      SizedBox(height: 40,),

          CustomTextField(
            hintText: "Confirm email",
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween ,
            
            children: [
            SizedBox(
              height: 60,
              width: 200,
              child: CustomTextField(
              hintText: "Enter first name",
                      ),
            ),
            Container(
              height: 60,
              width: 200,
              child: CustomTextField(
              hintText: "Enter surname",
                      ),
            ),
          
            ],
            
          ),
      SizedBox(height: 40,),

          CustomTextField(
            hintText: 'tgr',
          ),
          //Text("password must have at least 8 charachters"),    

      ]),
    );
  }
}