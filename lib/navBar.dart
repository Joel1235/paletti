import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('Joe Mama'),
              accountEmail: Text('joe.mama@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC-9Xm5dvI6hqtVo9MDNjTBfVxgJgCULLTbmJ9pUaCcN7nV5O_CKIJrSeXgdXjLo_GgjI&usqp=CAU',
                      width: 90,
                      height: 90,
                  ),
                 ),
              ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: NetworkImage(
                  'https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/upwk58792781-wikimedia-image.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=c59372bebd668731c4e888d3a51357ff'
                ),
                fit: BoxFit.cover,
              )
            ),
          ),
          ListTile(
            title: Text('Palettenübersicht'),
            onTap: () => print ('Palettenübersicht')
          ),
          ListTile(
              title: Text('Fahrerstandorte'),
              onTap: () => print ('Fahrerstandorte')
          ),
          ListTile(
              title: Text('Aufträge'),
              onTap: () => print ('Aufträge')
          ),
          Divider(),
          ListTile(
              title: Text('Kartenübersicht'),
              onTap: () => print ('Kartenübersicht')
          )
        ],
      ),
    );
  }
}
