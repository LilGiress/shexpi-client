

import 'package:flutter/material.dart';
import 'package:mycar/constance/constance.dart';
import 'package:mycar/modules/drawer/drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75 < 400 ? MediaQuery.of(context).size.width * 0.72 : 350,
        child: Drawer(
          child: AppDrawer(
           // selectItemName: 'Home',
          ),
        ),
      ),
      // appBar: AppBar(
       
        
      // ),
      //drawer: AppDrawer(),

      //extendBodyBehindAppBar: true,
      
      body: Container(
        
        child: const Center(
          
        child: Text('Press the button with a label below!'),
    ),
      ),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () {
        // Add your onPressed code here!
      },
      label: const Text('Demander une livraison', style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal),),
      icon: const Icon(Icons.delivery_dining_rounded,size: 40, color:Colors.white ,),
      backgroundColor: Colors.pink,
    ),
  );
    
  }
   List<Container> section4 = [
     Container(
  padding: const EdgeInsets.all(10),
  child:Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
              leading: Icon(Icons.headset_mic,color: Colors.blueAccent,),
              title: Text('Assistance'),
              subtitle: Text('Nos équipes d\'assistance vous accompagnent 24h/24 et 7 jours sur 7.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LISTEN'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
      ],
    ),
    
  ),
),
      Container(
  padding: const EdgeInsets.all(10),
  child:Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
              leading: Icon(Icons.map,color: Colors.blueAccent,),
              title: Text('Decouverte'),
              subtitle: Text('Profitez de vos livraisons en découvrant toutes les facettes de votre ville.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LISTEN'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
      ],
    ),
    
  ),
),
      Container(
  padding: const EdgeInsets.all(10),
  child:Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
              leading: Icon(Icons.delivery_dining,color: Colors.blueAccent,),
              title: Text('Réseau de livraison'),
              subtitle: Text('Nos avons un vaste réseau de clients, réputés de la restauration et le e-commerce.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LISTEN'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
      ],
    ),
    
  ),
),
 Container(
  padding: const EdgeInsets.all(10),
  child:Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
              leading: Icon(Icons.wallet_giftcard,color: Colors.blueAccent,),
              title: Text('Paiement'),
              subtitle: Text('Vous recevez vos paiements chaque semaine par mobile money ou carte bancaire.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LISTEN'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
      ],
    ),
    
  ),
)
     ];
}
