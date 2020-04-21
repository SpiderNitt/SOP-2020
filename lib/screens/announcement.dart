
import 'package:flutter/material.dart';
import 'package:inductions_20/Themes/styling.dart';
import 'package:inductions_20/screens/widgets/Announcementbox.dart';
class   Announcement extends StatefulWidget{
  


  AnnouncementState createState() => AnnouncementState();


}
class AnnouncementState extends State<Announcement> with SingleTickerProviderStateMixin {

 

  @override
  void initState() {
     
    super.initState();
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
        appBar: AppBar(
        title: Text('''Announcement'''),
        backgroundColor: theme.blackColor ,
        ),
        
        body: ListView(
    
            children:<Widget>[
           
          Announcementbox('''Anjenaya''','''21/4/2020''',''' 5:30pm''','''the deadline of web task3 has been extended to 5/2/2020 \nhappy COding :)''', width),
          Announcementbox('''Anjenaya''','''21/4/2020''',''' 5:30pm''','''the deadline of web task3 has been extended to 5/2/2020 \nhappy COding :)''', width),
          Announcementbox('''Anjenaya''','''21/4/2020''',''' 5:30pm''','''the deadline of web task3 has been extended to 5/2/2020 \nhappy COding :)''', width),
          Announcementbox('''Anjenaya''','''21/4/2020''',''' 5:30pm''','''the deadline of web task3 has been extended to 5/2/2020 \nhappy COding :)''', width),
          ],
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

