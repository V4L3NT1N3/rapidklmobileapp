import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Tickets extends StatefulWidget {
  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  //details
  final List<String> tickets = ["RPD005", "RPD055", "RPD235", "RPD199"];
  final List<String> location = [
    "Maluri",
    "Cochrane",
    "Sri Raya",
    "Pasar Seni"
  ];
  final List<String> destination = ["Semantan", "Kajang", "Maluri", "Merdeka"];

  @override
  Widget build(BuildContext context) {
    //datetime
    final DateTime now = DateTime.now().add(Duration(days: 1));
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatteddate = formatter.format(now);

    //random number
    Random random = new Random();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page title
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20.0),
            child: Text(
              'My Tickets',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800]),
            ),
          ),

          // Search bar
          Container(
            margin: EdgeInsets.only(top: 20, left: 30, right: 30),
            child: TextField(
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 14),
                hintText: 'Search by station name eg. Maluri',
                suffixIcon: Tooltip(
                  message: 'Search functionality has not been implemented',
                  child: Icon(
                    Icons.search,
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey.withOpacity(0.2),
                contentPadding: EdgeInsets.all(20),
              ),
            ),
          ),

          // Menu cards
          Expanded(
            child: ListView.builder(
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  int randomNumber = random.nextInt(9) + 1;

                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Card(
                        elevation: 2,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                              color: Colors.red,
                              width: 5,
                            )),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 10, bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Start location
                                    Column(
                                      children: [
                                        Text('MRT',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600])),
                                        Container(
                                          width: 120,
                                          child: Text(
                                            location[index],
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.blueGrey[800],
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Arrow icon
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.blueGrey[800],
                                      size: 30,
                                    ),
                                    // End destination
                                    Column(
                                      children: [
                                        Text('MRT',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600])),
                                        Container(
                                          width: 120,
                                          child: Text(
                                            destination[index],
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.blueGrey[800],
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 20,
                                        ),
                                        splashRadius: 5,
                                        onPressed: () {})
                                  ],
                                ),

                                SizedBox(height: 25),

                                // Valid and ticket type
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Valid Until',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Text(
                                          formatteddate,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    // Ticket type details
                                    Column(
                                      children: [
                                        Text(
                                          'Ticket Quantity',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Text(
                                          randomNumber.toString(),
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.blueGrey[800],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
