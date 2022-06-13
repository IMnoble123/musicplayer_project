import 'package:firstproject/sixth_page.dart';
import 'package:flutter/material.dart';

class Fifthpage extends StatelessWidget {
  const Fifthpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor:Colors.pink.shade50,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const Text('Sound Effects'),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const Sixthpage()));
                    },
                    child: const Text(
                      'head set type',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
            const Divider(
              color: Colors.black,
            )
          ],
        ),
      ),
    ));
  }
}
