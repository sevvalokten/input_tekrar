import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

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
      body: TextFormFieldKullanimi(),
    );
  }
}
class TextFormFieldKullanimi extends StatefulWidget {
  const TextFormFieldKullanimi({super.key});

  @override
  State<TextFormFieldKullanimi> createState() => _TextFormFieldKullanimiState();
}

class _TextFormFieldKullanimiState extends State<TextFormFieldKullanimi> {
  late final String _email, _password, _userName;
  final _formKey = GlobalKey<FormState>(); // Flutter’daki bir Form widget’ına erişebilmek için kullanılan bir anahtar. Form içindeki doğrulama ve kaydetme işlemlerini kontrol etmek için kullanılır.
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          //validate işlemini ne zaman çalıştıracağını belirler.
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                onSaved: (gelenUserName){
                  _userName = gelenUserName!;
                },
                //texteditingcontrollera ihityaç duymaz. Çünkü onSaved vardır.
                //varsayılan değeri tanımlar
                //initialValue: "sevvalokten",
                decoration: InputDecoration(
                  //hata mesajlarının rengini değiştirir.
                  errorStyle: TextStyle(color: Colors.red),
                  labelText: "Kullanıcı Adı",
                  hintText: "Username",
                  border: OutlineInputBorder()
                ),
                validator: (girilenUserName){
                  if(girilenUserName!.isEmpty){
                    return "Kullanıcı adı boş olamaz";
                  }
                  if (girilenUserName!.length < 4){
                    return  "5 karakterden az olamaz";
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 10,),

              TextFormField(
                onSaved: (gelenMail){
                  _email = gelenMail!;
                },
                //texteditingcontrollera ihityaç duymaz. Çünkü onSaved vardır.
                //varsayılan değeri tanımlar
                //initialValue: "sevvalokten",
                decoration: InputDecoration(
                  //hata mesajlarının rengini değiştirir.
                  errorStyle: TextStyle(color: Colors.red),
                  labelText: "Email ",
                  hintText: "Email",
                  border: OutlineInputBorder()
                ),
                validator: (girilenEmail){
                  if (!EmailValidator.validate(girilenEmail!)){
                    return "Geçerli bir e-mail giriniz";
                  }else{
                    return null;
                  }
                   }
              ),
              SizedBox(height: 10,),

              TextFormField(
                onSaved: (gelenSifre){
                  _password = gelenSifre!;
                },
                //texteditingcontrollera ihityaç duymaz. Çünkü onSaved vardır.
                //varsayılan değeri tanımlar
                //initialValue: "sevvalokten",
                decoration: InputDecoration(
                  //hata mesajlarının rengini değiştirir.
                  errorStyle: TextStyle(color: Colors.red),
                  labelText: "Şifre ",
                  hintText: "Password",
                  border: OutlineInputBorder()
                ),
                validator: (girilenPass){
                  if(girilenPass!.isEmpty){
                    return "Şifre boş olamaz";
                  }
                  if (girilenPass!.length < 4){
                    return  "Şifre en az 5 karakter olmalı";
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 10,),

              SizedBox(
                height: 55,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey, width: 3)
                    )
                  ),
                  onPressed: (){
                    //validate tamamlandı mı kontrol etmek için
                    bool _isValidate = _formKey.currentState!.validate();
                    if (_isValidate){
                      //textFormField dan gelen verileri kaydetme işlemidir.
                      _formKey.currentState!.save();
                      String result = "username: $_userName\nemail: $_email\şifre: $_password";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            result,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          ),
                      );
                      //save işlemi olduktan sonra textformfieldleri temizler
                      _formKey.currentState!.reset();
                    }
                  },
                  child: Text("Onayla")),
              )


            ],
          )),
        ),
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