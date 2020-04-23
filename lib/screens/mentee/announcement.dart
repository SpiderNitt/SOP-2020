import 'package:flutter/material.dart';
import 'package:inductions_20/theme/mentee.dart';
import 'package:inductions_20/screens/mentee/widgets/Announcementbox.dart';
import 'package:inductions_20/screens/mentee/data/announcement.dart';
import 'package:inductions_20/screens/navigation/mentee_navigation.dart';
import 'package:inductions_20/screens/navigation/mentee_navigation.dart';


class Announcement extends StatefulWidget{

Announcement();
  
AnnouncementState createState() => AnnouncementState();


}
class AnnouncementState extends State<Announcement> with SingleTickerProviderStateMixin {

List _messages=[];
List date=[];
List time=[];

ScrollController scrollController;
 
  @override
  void initState() {
      scrollController = ScrollController();
    get_announcement(); 
    super.initState();
}

Future<void>get_announcement() async{
    
  Announcement_list announcement_list = Announcement_list();
  await announcement_list.extractProgressDetails();
  announcement_list.announcements.forEach((k,v){
  _messages.add("$v");
  String date1= "$k".substring(0, 10);

  int hr =int.parse("$k".substring(11,13))+5;
   int min =int.parse("$k".substring(14,16))+30;
   int sec= int.parse("$k".substring(17,19));
  if(min>=60)
  { hr++;
    min=min-60;
   }
   date.add(date1);
   time.add("$hr:$min:$sec");

  
    });

    
}





  
  double commentwidth;
  @override
  Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width <= 400) {
   commentwidth=210;} else if (width <= 600) {
   commentwidth=230;} else if (width <= 900) {
   commentwidth=290;} else {
   commentwidth=390;}  
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
         backgroundColor:theme.primaryColor,
      //    drawer: MenteeCustomDrawer() ,
     
        appBar: AppBar(
        title: Text('''Announcement'''),
        backgroundColor: theme.blackColor ,
        ),
        
        body: ListView.builder(
              controller: scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
              
          Announcementbox('''Anjenaya''','''${date[index]}''','''${time[index]}''','''${_messages[index]}''', width);
               } 
        ),    
          
        
           ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

