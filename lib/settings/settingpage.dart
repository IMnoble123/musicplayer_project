import 'dart:io';
import 'package:firstproject/about/about.dart';
import 'package:firstproject/home_page.dart';
import 'package:firstproject/settings/filter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const Homepage()));
            },
            icon: const Icon(Icons.arrow_back_ios)),
            centerTitle: true,
        title: const Text('Settings'),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
      
        children: [
          const SizedBox(
            height: 30,
          ),
        const SizedBox(height: 30,),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const Filterpage()));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Filter',
                    style: TextStyle(fontSize: 15),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
          const Divider(
            indent: 12,
            endIndent: 10,
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const AboutScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'About',
                    style: TextStyle(fontSize: 15),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
          const Divider(
            indent: 12,
            endIndent: 10,
          ),
          const SizedBox(height: 400),
          ElevatedButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: const Text('Close'))
        ],
      ),
    );
  }
}
