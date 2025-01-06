import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/data/image_path.dart';
import 'package:weatherapp/utils/apptext.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _click = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Container(
        padding:
            const EdgeInsets.only(top: 65, left: 20, right: 20, bottom: 20),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(background[1]),
          ),
        ),
        child: Stack(
          children: [
            _click == true
                ? Positioned(
                    top: 80,
                    left: 20,
                    right: 20,
                    child: Container(
                      // color: Colors.amber,
                      height: 45,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            Positioned(
              top: 30,
              left: 10,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              data: "kerala",
                              color: Colors.white,
                              fw: FontWeight.w700,
                              size: 18,
                            ),
                            AppText(
                              data: "Good Morning",
                              color: Colors.white,
                              fw: FontWeight.w400,
                              size: 14,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _click = !_click;
                        print("Button toggled: $_click");
                        print("clicked");
                      });
                    },
                    icon: Icon(
                      _click == true ? Icons.close : Icons.search,
                      size: 32,
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: const Alignment(0, -0.6),
              child: Image.asset(imagePath[6]),
            ),
            Align(
              alignment: const Alignment(0, 0),
              child: Container(
                height: 130,
                width: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      data: "20°c",
                      color: Colors.white,
                      fw: FontWeight.bold,
                      size: 32,
                    ),
                    AppText(
                      data: "Snow",
                      color: Colors.white,
                      fw: FontWeight.bold,
                      size: 26,
                    ),
                    AppText(
                      data: formattedDate,
                      color: Colors.white,
                    ),
                    AppText(
                      data: formattedTime,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.75),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(29),
                  color: Colors.black.withOpacity(0.4),
                ),
                height: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/img/temperature-high.png',
                              height: 55,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  data: "Temp Max",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                ),
                                AppText(
                                  data: "20°C",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/img/temperature-low.png',
                              height: 55,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  data: "Temp Max",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                ),
                                AppText(
                                  data: "20°C",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 2,
                      endIndent: 20,
                      indent: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/img/sun.png',
                              height: 55,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  data: "Temp Max",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                ),
                                AppText(
                                  data: "20°C",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/img/moon.png',
                              height: 45,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  data: "Temp Max",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                ),
                                AppText(
                                  data: "20°C",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
