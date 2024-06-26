import 'package:cleaneo_driver_app/Home/Pickup/Components/rating_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_svg/svg.dart';

class TwoText extends StatefulWidget {
  const TwoText({Key? key}) : super(key: key);

  @override
  _TwoTextState createState() => _TwoTextState();
}

class _TwoTextState extends State<TwoText> {
  int _selectedIndex = 0;
  final List<String> _tabNames = ['Pending', 'Delivered'];

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    final List<List<Map<String, List<Map<String, String>>>>> _todaytabData = [
      [
        // Daily data
        {
          "ongoing": [
            {
              "orderNumber": "1",
              "time": "10:00 AM",
              "onlineMode": "Yes",
              "earning": "₹ 180"
            },
            {
              "orderNumber": "2",
              "time": "11:30 AM",
              "onlineMode": "No",
              "earning": "₹ 200"
            },
          ]
        }
      ],
      [
        // Weekly data
        {
          "orders": [
            {
              "orderNumber": "1",
              "dateandtime": "04 Jul 2021 at 8:09 pm",
              "location": "PDPU Crossroad Kudasan",
              "name": "Shweta",
              "number": "+91 95255 26542",
              "cash": "₹250.00"
            },
            {
              "orderNumber": "1",
              "dateandtime": "04 Jul 2021 at 8:09 pm",
              "location": "PDPU Crossroad Kudasan",
              "name": "Shweta",
              "number": "+91 95255 26542",
              "cash": "₹250.00"
            },
          ]
        }
      ],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _tabNames.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    width: mQuery.size.width * 0.495,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _selectedIndex == index
                              ? const Color(0xFF29B2FE)
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _tabNames[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _selectedIndex == index
                              ? const Color(0xFF29B2FE)
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // Content based on tab selection
        if (_selectedIndex == 0)
          Expanded(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/noorders.svg',
                    width: 320, // Adjust the width as needed
                    height: 320, // Adjust the height as needed
                  ),
                ],
              ),
            ),
          ),
        if (_selectedIndex == 1)
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: _todaytabData[_selectedIndex][0]["orders"]!.length,
              itemBuilder: (BuildContext context, int index) {
                var order = _todaytabData[_selectedIndex][0]["orders"]![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '${order['dateandtime']}',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 181, 181, 181),
                                fontSize: mQuery.size.height * 0.012,
                                fontFamily: 'SatoshiBold'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Container(
                          height: mQuery.size.height * 0.28,
                          margin: const EdgeInsets.only(bottom: 21.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(
                                  0,
                                  0,
                                ), // changes the position of the shadow
                              ),
                            ],
                          ),
                          child: ListView(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 50.0,
                                color: const Color(0xFFF3FBFF),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.shopping_bag_outlined,
                                            color: const Color(0xFF48BDFE),
                                          ),
                                          const SizedBox(
                                            width: 6.0,
                                          ),
                                          Text(
                                            'Order ${order['orderNumber']}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    mQuery.size.height * 0.015,
                                                fontFamily: 'SatoshiBold'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: mQuery.size.height * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Location',
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 152, 152, 152),
                                              fontSize:
                                                  mQuery.size.height * 0.012,
                                              fontFamily: 'SatoshiBold'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.home,
                                          color: Colors.blue,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        Text(
                                          '${order['location']}',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize:
                                                  mQuery.size.height * 0.012,
                                              fontFamily: 'SatoshiMedium'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Divider(
                                      color: Color.fromARGB(255, 212, 212, 212),
                                      thickness: 0.7,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Customer Detail',
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 152, 152, 152),
                                              fontSize:
                                                  mQuery.size.height * 0.012,
                                              fontFamily: 'SatoshiBold'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        const ProfilePicture(
                                          name: "",
                                          radius: 18,
                                          fontsize: 10,
                                          img:
                                              "https://a.storyblok.com/f/191576/1200x800/faa88c639f/round_profil_picture_before_.webp",
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${order['name']}',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: mQuery.size.height *
                                                      0.012,
                                                  fontFamily: 'SatoshiMedium'),
                                            ),
                                            Text(
                                              '${order['number']}',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: mQuery.size.height *
                                                      0.012,
                                                  fontFamily: 'SatoshiMedium'),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(child: Container()),
                              SizedBox(height: 3,),
                              GestureDetector(
                                onTap:()
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return RatingPage();
                                  }));
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(6.0),
                                        bottomRight: const Radius.circular(6.0)),
                                    color: Color(0xFF29B2FE),
                                  ),
                                  height: mQuery.size.height * 0.035,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      'SUBMIT REVIEW',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: mQuery.size.height * 0.012,
                                          fontFamily: 'SatoshiBold'),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
