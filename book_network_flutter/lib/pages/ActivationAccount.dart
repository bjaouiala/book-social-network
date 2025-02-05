import 'package:book_network_flutter/NavigationAnimation.dart';
import 'package:book_network_flutter/helpers/helpers.dart';
import 'package:book_network_flutter/models/Auth/TokenResponse.dart';
import 'package:book_network_flutter/pages/login-page.dart';
import 'package:book_network_flutter/services/Auth_service.dart';
import 'package:flutter/material.dart';

class ActivatioAccount extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ActivationAccountState();
  }

}

class ActivationAccountState extends State<ActivatioAccount>{
  final List<TextEditingController> _controllres = [];
    final List<FocusNode> _focusNodes = [];
    String activationCode = '';
    Color _borderColer=Colors.black;
    int codeLength = 6;

    @override
      void initState(){
      super.initState();
      for(int i = 0 ; i < codeLength ; i++){
        _controllres.add(TextEditingController());
        _focusNodes.add(FocusNode());
      }
    }

    void _fetchToken() async{
  
      try{
        Tokenresponse response = await authService.getToken(activationCode);
        setState(() {
        _borderColer = Colors.green;
        });

        try{
          await authService.activationAccount(response.token);
        }catch(e){
          rethrow;
        }
       
      }catch (e){
        setState(() {
          _borderColer = Colors.red;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("please verify your code",style: TextStyle(color: Colors.red)),duration: Duration(seconds: 3),));
        });
      } 
    }

    void onCodeComplete(){
      activationCode = _controllres.map((e)=> e.text).join();
      _fetchToken();
    }

    void clearAll(){
      setState(() {
        for(var controller in _controllres){
          controller.clear();
        }
        if(_focusNodes.isNotEmpty){
            FocusScope.of(context).requestFocus(_focusNodes[0]);
        }

        _borderColer =Colors.black;
        activationCode = '';

      });
    }

    @override
      void dispose(){
      super.dispose();
      for(var controller in _controllres){
        controller.dispose();
      }
      for(var focusNode in _focusNodes){
        focusNode.dispose();
      }
    }

    

    
     
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(96, 96, 96, 1),
      appBar: AppBar(
        title: const Text("Activation Account"),
        toolbarHeight: 80,
        titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child:Column(
            children:  [
             const Text(
                "A confirmation code was sent to your email please enter the code to verify your account",
                style: TextStyle(color: Colors.black,fontSize: 16),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 7,
                children: List.generate(codeLength, (index){
              return SizedBox(
                width: MediaQuery.of(context).size.width / (codeLength + 2),
                child: TextFormField(
                  controller: _controllres[index],
                  focusNode: _focusNodes[index],
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  decoration: InputDecoration(
                    counterText: "",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: _borderColer)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: _borderColer)
                    )
                  ),
                  onChanged: (value)  {
                    if(value.isNotEmpty){
                      if(index < codeLength - 1  ){
                        FocusScope.of(context).requestFocus(_focusNodes[index+1]);
                      }else if(index == codeLength -1){
                        FocusScope.of(context).unfocus();
                        onCodeComplete();
                      }
                      
                    }else if(value.isEmpty && index > 0 ){
                      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                    }
                  },
                ),
              );
            })
              ),
              const SizedBox(height: 20,),
              TextButton(onPressed: clearAll,
               child: const Text("Clear all",style: TextStyle(color: Colors.white,fontSize: 18),))
            ],
          )
        ),
        ),

    );
    
}


  }
