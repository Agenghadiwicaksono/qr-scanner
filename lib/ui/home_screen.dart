import 'package:flutter/material.dart';
import 'package:qr_scanner_code/ui/build_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/profile-pict.png'),
                ),
                SizedBox(width: 10,),
                Column(
                  children: [
                    Text('Hallo, Ageng', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(height: 5,),
                    Text('Front-End Developer', 
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to',
                  style: TextStyle(
                    fontSize: 15
                  ),
                ),
                Text(
                  'QR Scanner Generator',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                BuildButton(
                  icon: Icons.qr_code, 
                  label: "Create", 
                  iconColor: Colors.white, 
                  backgroundColor: Colors.blue, 
                  onTap: (){
                    Navigator.pushNamed(context, '/create');
                  }
                ),
                BuildButton(
                  icon: Icons.qr_code_scanner_sharp, 
                  label: "Scan", 
                  iconColor: Colors.red, 
                  backgroundColor: Colors.red.withOpacity(.5), 
                  onTap: (){
                    Navigator.pushNamed(context, '/scan');
                  }
                ),
                BuildButton(
                  icon: Icons.send_sharp, 
                  label: "Send", 
                  iconColor: Colors.green, 
                  backgroundColor: Colors.green.withOpacity(.5), 
                  onTap: (){}
                ),
                BuildButton(
                  icon: Icons.print, 
                  label: "Print", 
                  iconColor: Colors.purple, 
                  backgroundColor: Colors.purple.withOpacity(.5), 
                  onTap: (){}
                )
              ],
            )
          )
        ],
      ),
    );
  }
}