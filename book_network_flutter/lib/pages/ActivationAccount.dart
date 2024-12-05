import 'package:book_network_flutter/helpers/helpers.dart';
import 'package:book_network_flutter/models/Auth/TokenResponse.dart';
import 'package:book_network_flutter/services/Auth_service.dart';
import 'package:flutter/material.dart';

class ActivatioAccount extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ActivationAccountState();
  }

}

class ActivationAccountState extends State<ActivatioAccount>{
  final int codeLength=6;
  final List<TextEditingController> _controller= [];
  final List<FocusNode> _focusNodes = [];
  String activationCode = '';
  String recivedToken = '';
  Color _color = Colors.black;
  bool _isEditable = true;

    Future<void> _fetchToken(String code) async {
    try {
      Tokenresponse token = await authService.getToken(code);
      setState(() {
        recivedToken = token.token;
        _color = Colors.green;
      });
    } catch (e) {
     setState(() {
      _color = Colors.red; // Ensure this is wrapped in setState to trigger a rebuild.
    });
    }
  }

  @override
  void initState(){
    super.initState();
    for(int i=0; i<codeLength; i++){
      _controller.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
  }


  @override
  void dispose(){
    super.dispose();
    for(var focusNode in _focusNodes){
      focusNode.dispose();
    }
    for(var controller in _controller){
      controller.dispose();
    }
  }
   
   void _onCodeComplete(){
    setState(() {

      activationCode = _controller.map((e)=> e.text).join();
       _fetchToken(activationCode);
    });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(96, 96, 96, 1),
      appBar: AppBar(
        title: const Text("Activation Account"),
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Center(
            child: Row(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: List.generate(codeLength, (index){
                return SizedBox(
                  width: 50,
                  child: Padding(padding: const EdgeInsets.all(2),
                    child: TextFormField(
                    controller: _controller[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    enabled: _isEditable,
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:  BorderSide(color: _color,width: 2)
                        
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey,width: 2)
                      )
                    ),
                    onChanged: (value){
                      if(value.isNotEmpty && index > 0){
                        if(index < codeLength - 1){
                          FocusScope.of(context).requestFocus(_focusNodes[index+1]);
                        }else{
                          FocusScope.of(context).unfocus();
                        }
                      }else{
                        FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                      }
                       if (index == codeLength - 1 && value.isNotEmpty) {
                          _onCodeComplete();
                        }
                    },
                  ),
                  ),
                
                );

              }),
            ),
          ),
        ),
         )
    );
  }
}