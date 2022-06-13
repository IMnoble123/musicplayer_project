import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String? appVersion;
  @override
  void initState() {
    main();
    super.initState();
  }

  Future<void> main() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          // Positioned(
          //   left: MediaQuery.of(context).size.width / 2,
          //   top: MediaQuery.of(context).size.width / 5,
          // //   // child: SizedBox(
          // //   //   width: MediaQuery.of(context).size.width,
          // //   //   child: const Image(
          // //   //       fit: BoxFit.fill, image: AssetImage('assets/ic launcher')),
          // //   // ),
          // // ),
          // // // Container(
          // // //   child: null,
          // ),
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.pink.shade50,
              elevation: 0,
              title: const Text('About',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            backgroundColor: Colors.pink.shade50,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 15,
                        
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                        clipBehavior: Clip.antiAlias,
                        child: const SizedBox(
                          width: 90,
                          child: Image(
                              image: AssetImage('assets/githublogo1.png')),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'myMusic',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        'v$appVersion',
                        style: const TextStyle(color: Color.fromARGB(255, 138, 135, 135)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    child: Column(
                      children: [
                        const Text(
                        'This is an open-source project and can be found on',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, color: Color.fromARGB(255, 119, 115, 115)),
                        ),
                        TextButton(
                          onPressed: () {
                            launchUrl(Uri.parse(
                                'https://github.com/IMnoble123'));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Image(
                              image: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? const AssetImage('assets/icon1.jpg')
                                  : const AssetImage('assets/icon1.jpg'),
                            ),
                          ),
                        ),
                        const Text(
                        'if you liked my work',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, color: Color.fromARGB(255, 136, 131, 131)),
                        ),
                        const Text(
                        'show some star to the repo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, color: Color.fromARGB(255, 136, 131, 131)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
