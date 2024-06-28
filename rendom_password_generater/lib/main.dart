import 'dart:math';

import 'settings.dart';
import 'package:flutter/widgets.dart';

import 'language.dart';
import 'package:http/http.dart' as http;
import 'viewText.dart';
import 'app.dart';
import 'contectUs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await Language.runTranslation();
  runApp(test());
}
class test extends StatefulWidget{
  const test({Key?key}):super(key:key);
  @override
  State<test> createState()=>_test();
}
class _test extends State<test>{
  var result="";
  TextEditingController Length=TextEditingController(text: "10");
  var smoalLetters=true;
  var capLitter=true;
  var numbers=true;
  var simple=true;
  var _=Language.translate;
  _test();
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      locale: Locale(Language.languageCode),
      title: App.name,
      themeMode: ThemeMode.system,
      home:Builder(builder:(context) 
    =>Scaffold(
      appBar:AppBar(
        title: const Text(App.name),), 
        drawer: Drawer(
          child:ListView(children: [
          DrawerHeader(child: Text(_("navigation menu"))),
          ListTile(title:Text(_("settings")) ,onTap:() async{
            await Navigator.push(context, MaterialPageRoute(builder: (context) =>SettingsDialog(this._) ));
            setState(() {
              
            });
          } ,),
          ListTile(title: Text(_("contect us")),onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ContectUsDialog(this._)));
          },),
          ListTile(title: Text(_("donate")),onTap: (){
            launch("https://www.paypal.me/AMohammed231");
          },),
  ListTile(title: Text(_("visite project on github")),onTap: (){
    launch("https://github.com/mesteranas/"+App.appName);
  },),
  ListTile(title: Text(_("license")),onTap: ()async{
    String result;
    try{
    http.Response r=await http.get(Uri.parse("https://raw.githubusercontent.com/mesteranas/" + App.appName + "/main/LICENSE"));
    if ((r.statusCode==200)) {
      result=r.body;
    }else{
      result=_("error");
    }
    }catch(error){
      result=_("error");
    }
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewText(_("license"), result)));
  },),
  ListTile(title: Text(_("about")),onTap: (){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(title: Text(_("about")+" "+App.name),content:Center(child:Column(children: [
        ListTile(title: Text(_("version: ") + App.version.toString())),
        ListTile(title:Text(_("developer:")+" mesteranas")),
        ListTile(title:Text(_("description:") + App.description))
      ],) ,));
    });
  },)
        ],) ,),
        body:Container(alignment: Alignment.center
        ,child: Column(children: [
          CheckboxListTile(value: smoalLetters, onChanged: (bool?value){
            setState(() {
              smoalLetters=value??true;
            });
          },title: Text(_("smoal letters")),),
                    CheckboxListTile(value: capLitter, onChanged: (bool?value){
            setState(() {
              capLitter=value??true;
            });
          },title: Text(_("capital letters")),),
                    CheckboxListTile(value: numbers, onChanged: (bool?value){
            setState(() {
              numbers=value??true;
            });
          },title: Text(_("numbers")),),
                    CheckboxListTile(value: simple, onChanged: (bool?value){
            setState(() {
              simple=value??true;
            });
          },title: Text(_("symbols")),),
          TextFormField(controller: Length,decoration: InputDecoration(label: Text(_("length")),),keyboardType: TextInputType.number,),
          ElevatedButton(onPressed: (){
            var all=[];
                    var sy="! @ # % ^ & * /";
        var sml="a b c d e f g h i j k l m n o p q r s t u v x y z";
        var kbl=sml.toUpperCase();
        var num="1 2 3 4 5 6 7 8 9 0";
        if (smoalLetters){
          all.addAll(sml.split(" "));
        }
        if (capLitter){
          all.addAll(kbl.split(" "));
        }
        if (numbers){
          all.addAll(num.split(" "));
        }
        if (simple){
          all.addAll(sy.split(" "));
        }
        if (all.isEmpty){
          setState(() {
            result="please choose one to generate random password";
          });
          return;
        }
        Random random=Random.secure();
        result=List.generate(int.parse(Length.text),(index)=>all.join('')[random.nextInt(all.length)]).join('');
        setState(() {
          
        });
          }, child: Text(_("generate"))),
          Text(result)
    
    
    
    ])),)));
  }
}
