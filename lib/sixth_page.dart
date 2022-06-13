import 'package:flutter/material.dart';

class Sixthpage extends StatelessWidget {
  const Sixthpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor:Colors.pink.shade50,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white54,
                    border: Border.all(
                        color: Colors.pink.shade50,)),
                child: Column(children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.volume_up_rounded,
                        size: 30,
                      )),
                  const Text('speaker')
                ]),
              ),
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white54,
                    border: Border.all(
                        color: Colors.pink.shade50,)),
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.headphones,
                          size: 30,
                        )),
                    const Text('headmounted'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white54,
                    border: Border.all(
                        color: Colors.pink.shade50,)),
                child: Column(children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.earbuds_sharp,
                        size: 30,
                      )),
                  const Text('earbuds')
                ]),
              ),
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white54,
                    border: Border.all(
                        color: Colors.pink.shade50,)),
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'more..',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
