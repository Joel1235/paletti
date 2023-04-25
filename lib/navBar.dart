import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paletti_1/components/newEntry/newEntry.dart';
import 'components/dashborad/mainScreen.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Joe Mama'),
            accountEmail: const Text('joe.mama@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC-9Xm5dvI6hqtVo9MDNjTBfVxgJgCULLTbmJ9pUaCcN7nV5O_CKIJrSeXgdXjLo_GgjI&usqp=CAU',
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/upwk58792781-wikimedia-image.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=c59372bebd668731c4e888d3a51357ff'),
                  fit: BoxFit.cover,
                )),
          ),
          ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Dashboard'),
              //onTap: () => print ('Fahrerstandorte')
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainScreen()));
              }),
          ListTile(
              leading: const Icon(Icons.newspaper),
              title: const Text('New Entry'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => NewEntry())));
              }),
          ListTile(
              leading: const Icon(Icons.my_location),
              title: const Text('Fahrerstandorte'),
              onTap: () => print('Fahrerstandorte')),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Kartenübersicht'),
              onTap: () => print('Kartenübersicht')),
          ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Kundenübersicht'),
              onTap: () => print('Kundenübersicht')),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => print('Setting')),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Log out'),
              onTap: () => FirebaseAuth.instance.signOut()),
          //onPressed: () => FirebaseAuth.instance.signOut(),
        ],
      ),
    );
  }
}
