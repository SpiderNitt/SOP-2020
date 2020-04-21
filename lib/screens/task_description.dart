
import 'package:flutter/material.dart';
import 'package:inductions_20/Themes/styling.dart';
import 'widgets/custom_box.dart';
import 'package:url_launcher/url_launcher.dart';

class Task_description extends StatelessWidget{

final primary;

Task_description(this.primary);

Widget build(BuildContext context) {

return ListView(
    
  children:<Widget>[
      
    Padding(padding: const EdgeInsets.all(16.0),
    child: Container(
   
    width: 370, 
    child: Material(
           color: primary,
           elevation: 10.0,
           borderRadius: BorderRadius.circular(10.0),
           child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Text("Description:", style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                               color: theme.tertiaryColor,
                        )),
                    Text('''  
                    
EASY
1. Create a quiz game that takes multiple answers and shows a result to the user.
Specific features of the app should include:
➢ Tougher questions as the quiz progresses if the user is entering correct
answers.
➢ Must be easier to add another question to the questions set.
2. Create a web app which uses a search input and any API(s) of your choice to
display gifs on a page.
Specific features of the app should include:➢ Users must be able to search for gifs based on Character Name,
Emotion, why even name of TV series.
➢ The homepage should have recommended gifs based on search history.

HARD
Highest preference is given to UI.
1. Build a catalog page for a shop. A catalog page describes what products are
available in the shop. Use some build tool (Gulp, npm, Webpack, etc) to bundle
your files if you are using a framework.
Implement the following features:
➢ Have a big catalog file. For each item on the catalog, the following
information must be present on the page:
○ Image
○ Name
○ Price
○ Available Sizes
○ Quantity available
➢ Have a search bar to search for products.
➢ Have a cart where items can be added, and number of items can be
changed.
➢ It must be possible to view the cart with the items you've added (name,
image, price, quantity) and the grand total.
➢ The cart should be persisted between reloads.
➢ Work on a recommender system based on the users choices (complexity
and efficiency of the algorithm will be evaluated).
➢ The application should be very fast, and should not occupy excessive
memory footprint in the browser.
➢ Extra points if it could be implemented as a Progressive Web App. (PWA) ''', style: TextStyle(
                               fontSize: 17,
                               color: theme.fontColor
                        ))

                        
                        
                      ],
   ),), )),
   Padding(padding: const EdgeInsets.all(16.0),
   child: Container(
   width: 370, 
   child: Material(
          color: primary,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(10.0),
          child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                      Padding( 
                      padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
                      child:Text(' Resources:', style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                               color: theme.tertiaryColor
                             ))), 
                      for(int i=0; i<4; i++)
                      Padding(
                      padding: const EdgeInsets.all(3.0),
                     
                      child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget>[
                      Text('link description', style: TextStyle(
                               fontSize: 17,
                               color: theme.fontColor)       
                      ),
                      Custom_box('''https://github.com/thrishik7/ML-algos''',(){  
                      launch('https://github.com/thrishik7/ML-algos');},370,38,15,primary,0,0,0),
                      
                      ])
                      )],
    ),), )),
  ]);
}

}