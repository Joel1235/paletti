import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paletti_1/components/locationMap/locationMap.dart';
import 'package:paletti_1/components/newEntry/newEntry.dart';
import 'components/dashborad/mainScreen.dart';
import 'components/externApi/extApi.dart';
import 'components/OrganizationPage/organizationPage.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    var mail = FirebaseAuth.instance.currentUser?.email.toString();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('logged in as: '),
            accountEmail: Text('$mail'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg',
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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => LocationMap())));
              }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Organisation'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => OrganizationPage())));
              }),
          ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Externe Api'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => ExtApi())));
              }),
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
