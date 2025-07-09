import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyProject(),
    );
  }
}

class MyProject extends StatelessWidget {
  const MyProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tekrar"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: TextFieldWidgetKullanimi(),
    );
  }
}
class TextFieldWidgetKullanimi extends StatefulWidget {
  const TextFieldWidgetKullanimi({super.key});

  @override
  State<TextFieldWidgetKullanimi> createState() => _TextFieldWidgetKullanimiState();
}

class _TextFieldWidgetKullanimiState extends State<TextFieldWidgetKullanimi> {

  late TextEditingController _emailController;
  late FocusNode _focusNode;
  int maxLineCount = 1;

  @override
  void initState(){
    super.initState();
    _emailController = TextEditingController();
    _focusNode =FocusNode();
    _focusNode.addListener((){
      setState(() {
        maxLineCount = _focusNode.hasFocus ? 3 : 1;
      });
    });
  }

  @override
  void dispose(){
    _emailController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextField(
            focusNode: _focusNode,
            controller: _emailController,
            maxLines: maxLineCount,
            //Açılacak olan klavye türü
            keyboardType: TextInputType.emailAddress,
            //Klavyedeki(Android) ana butonunun ne olacağı
            textInputAction: TextInputAction.done,

            //Seçili gelme olayı
            //autofocus: true,
            //Satır sayısı
            //maxLines: 5,
            //Girilecek karakter sayısı (TC)
            maxLength: 11,
            //İmleç rengi
            cursorColor: Colors.red,
            decoration: InputDecoration(
              //Kayan bilgi yazısı
              labelText: "Username",
              //İpucu
              hintText: "Kullanıcı adınızı giriniz",
              icon: Icon(Icons.add),
              //Sol tarafa eklenen icon
              prefix: Icon(Icons.person),
              //Sağ taraf iconu
              suffixIcon: Icon(Icons.cancel),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              //Arka plan rengi verme izni
              filled: true,
              fillColor: Colors.green.shade300,
            ),
            //Klavye ile yapılan her değişikliği algılar
            onChanged: (String gelenDeger){
              
            },
            //Klavyedeki done tuşuna basınca çalışır ya da fiel dan çıkınca 
            onSubmitted: (String gelenDeger){

            },

          ),
        ),
        TextField(),
      ],
    );

  }
}