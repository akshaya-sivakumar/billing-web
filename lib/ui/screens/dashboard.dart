import 'dart:convert';

import 'package:billing_web/ui/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  static String routeName = '/Dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<bool> isSelected = [true, false];

  List<Map<String, dynamic>> hallList = [
    {
      "hallName": "Jambo Hall",
      "eventList": ["7AM - 10AM", "8PM - 10PM"]
    },
    {"hallName": "Akila Hall", "eventList": []}
  ];

  List<Map<String, dynamic>> breakfastList = [
    {
      "name": "Karthikeyan",
      "menu": "110",
      "bill no": "187",
      "DD Bal": "Nil",
      "cost": 50
    },
    {
      "name": "Ayyapan Ashok Hall",
      "menu": "110",
      "bill no": "187",
      "DD Bal": "2000",
      "cost": 35
    },
  ];

  List<Map<String, dynamic>> lunchList = [
    {"menu": "110", "bill no": "187", "DD Bal": "RS", "cost": 15},
    {"menu": "110", "bill no": "187", "DD Bal": "PP", "cost": 100},
  ];

  List<Map<String, dynamic>> dinnerList = [
    {"menu": "110", "bill no": "187", "DD Bal": "RS", "cost": 40},
    {"menu": "110", "bill no": "187", "DD Bal": "PP", "cost": 50},
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      index: 1,
      // appBar: AppBar(),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.785,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Dashboard ",
                            style: GoogleFonts.adamina(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.calendar_month)
                        ],
                      ),
                      SizedBox(
                        height: 35,
                        child: ToggleButtons(
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text("Orders"),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text("Item"),
                            )
                          ],
                          selectedColor: Colors.white,
                          color: Colors.deepPurple,
                          fillColor: Colors.deepPurple,
                          borderColor: Colors.deepPurple,
                          onPressed: (int index) {
                            setState(() {
                              for (int buttonIndex = 0;
                                  buttonIndex < isSelected.length;
                                  buttonIndex++) {
                                if (buttonIndex == index) {
                                  isSelected[buttonIndex] = true;
                                } else {
                                  isSelected[buttonIndex] = false;
                                }
                              }
                            });
                          },
                          isSelected: isSelected,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TableCalendar(
                        firstDay: DateTime.utc(1000, 3, 14),
                        lastDay: DateTime.utc(2090, 3, 14),
                        availableGestures: AvailableGestures.all,
                        calendarBuilders: calendarBuilder(),
                        focusedDay: DateTime.now(),
                        // eventLoader: _getEventsForDay,
                        calendarFormat: CalendarFormat.week,
                        /*   selectedDayPredicate: (day) {
                          return isSameDay(day, day);
                        }, */
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            /*     select = true;
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay; */
                          });
                        },
                        onPageChanged: (focusedDay) {
                          //_focusedDay = focusedDay;
                        },
                        daysOfWeekVisible: false,
                        rowHeight: 80,

                        /*  headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.fromBorderSide(BorderSide(
                                  width: 0.5, color: Color(0xFF000000)))),
                          titleCentered: true,
                          titleTextStyle: TextStyle(fontSize: 18.0),
                        ), */
                        headerVisible: false,
                        calendarStyle: CalendarStyle(
                          markersMaxCount: 50,
                          outsideDaysVisible: true,
                          cellPadding: const EdgeInsets.all(10.0),
                          weekendDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300]!.withOpacity(0.6)),
                          holidayDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300]!.withOpacity(0.6)),
                          defaultDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300]!.withOpacity(0.6)),
                          cellMargin: const EdgeInsets.all(3.0),
                          /*  rowDecoration: BoxDecoration(
                            color: Colors.white,
                          ), */
                          defaultTextStyle: const TextStyle(
                              fontSize: 17, color: Color(0Xff000000)),
                          weekendTextStyle: const TextStyle(
                              fontSize: 17, color: Color(0Xff000000)),
                          holidayTextStyle: const TextStyle(
                              fontSize: 17, color: Color(0Xff000000)),
                          todayTextStyle: const TextStyle(
                              fontSize: 17, color: Colors.purple),
                          todayDecoration: BoxDecoration(
                              color: Colors.purple.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 1, color: Colors.purple)),
                          /*    selectedDecoration: const BoxDecoration(
                            color: Color(0Xff46b04a),
                          ), */
                        ))),
                SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 32, top: 20, right: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Hall",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              itemCount: hallList.length,
                              itemBuilder: (context, index) {
                                return hallRowbuilder(index);
                              },
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 32, top: 20, right: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Orders",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "See all",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        totalcostHead("Breakfast", "T-85"),
                        Expanded(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            itemCount: breakfastList.length,
                            itemBuilder: (context, index) {
                              return breakfastRowbuilder(index);
                            },
                          ),
                        ),
                        totalcostHead("Lunch", "T-115"),
                        Expanded(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            itemCount: lunchList.length,
                            itemBuilder: (context, index) {
                              return lunchRowbuilder(index, lunchList);
                            },
                          ),
                        ),
                        totalcostHead("Dinner", "T-90"),
                        Expanded(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            itemCount: dinnerList.length,
                            itemBuilder: (context, index) {
                              return lunchRowbuilder(index, dinnerList);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding totalcostHead(String title, cost) {
    return Padding(
      padding: EdgeInsets.only(left: 32, top: 10, bottom: 10, right: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            cost,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Container hallRowbuilder(int index) {
    return Container(
      height: 70,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.deepPurple),
            child: Icon(
              Icons.maps_home_work_outlined,
              color: Colors.white,
            )),
        SizedBox(
          width: 10,
        ),
        Text(
          hallList[index]["hallName"],
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 15,
        ),
        if (hallList[index]["eventList"].isNotEmpty)
          Expanded(
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: hallList[index]["eventList"].length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.deepPurple),
                    child: Center(
                        child: Text(
                      hallList[index]["eventList"][i],
                      style: TextStyle(color: Colors.white),
                    )),
                  );
                },
              ),
            ),
          )
      ]),
    );
  }

  CalendarBuilders calendarBuilder() {
    return CalendarBuilders(
      markerBuilder: (
        context,
        date,
        events,
      ) {
        //  if (events.isNotEmpty) {
        return Container(
          child: _buildEventsMarkerNum(date),
        );
        // }
        // return null;
      },
    );
  }

  Widget _buildEventsMarkerNum(DateTime day) {
    return buildCalendarDay(text: '${0}', day: day);
  }

  Widget buildCalendarDay({
    required String text,
    required DateTime day,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.center,
          // margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          width: 32,
          height: 29,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              dateFormatter(day),
              style: TextStyle(fontSize: 14, color: Colors.deepPurple),
            ),
          ),
        ),
      ],
    );
  }

  String dateFormatter(DateTime date) {
    dynamic dayData =
        '{ "1" : "Mon", "2" : "Tue", "3" : "Wed", "4" : "Thur", "5" : "Fri", "6" : "Sat", "7" : "Sun" }';

    return json.decode(dayData)['${date.weekday}'];
  }

  Container breakfastRowbuilder(int index) {
    return Container(
      height: 70,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.deepPurple),
                    child: const Icon(
                      Icons.food_bank,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          breakfastList[index]["name"],
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          // ignore: prefer_interpolation_to_compose_strings
                          " || Menu " + breakfastList[index]["menu"],
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "bill no: " + breakfastList[index]["bill no"],
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          " DD Bal: " + breakfastList[index]["DD Bal"],
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Text(
              breakfastList[index]["cost"].toString(),
              style: TextStyle(fontSize: 15, color: Colors.black),
            )
          ]),
    );
  }

  Container lunchRowbuilder(int index, List data) {
    return Container(
      height: 70,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.deepPurple),
                    child: const Icon(
                      Icons.food_bank,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          // ignore: prefer_interpolation_to_compose_strings
                          "Menu " + data[index]["menu"],
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "bill no: " + data[index]["bill no"],
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          data[index]["DD Bal"],
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Text(
              data[index]["cost"].toString(),
              style: TextStyle(fontSize: 15, color: Colors.black),
            )
          ]),
    );
  }
}
