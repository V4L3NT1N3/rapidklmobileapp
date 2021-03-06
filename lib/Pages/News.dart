import 'package:flutter/material.dart';
import 'package:rapidkl/Services/User.dart';
import 'package:rapidkl/Services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with SingleTickerProviderStateMixin {
  //animated icon
  AnimationController _animationController;
  Animation _colorAnimation;
  Animation<double> _sizeAnimation;
  Animation _curve;
  IconData icon = Icons.notifications_on;
  int count = 0;

  @override
  setInt(int lol) async {
    int count = 0;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', count);
  }

  getInt() async {
    final prefs = await SharedPreferences.getInstance();
    final counter = prefs.getInt('counter') ?? 0;
    return counter;
  }

  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _curve = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCubic);

    _colorAnimation =
        ColorTween(begin: Colors.red, end: Colors.grey).animate(_curve);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 30, end: 35),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 35, end: 30),
        weight: 50,
      ),
    ]).animate(_curve);

    @override
    void dispose() {
      super.dispose();
      _animationController.dispose();
    }
  }

  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(children: [
        Row(
          children: [
            // Page title
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 40),
                child: Text(
                  'News',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800]),
                ),
              ),
            ),
            // Notification bell
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 210),
              child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, _) {
                    return IconButton(
                      icon: Icon(
                        icon,
                        color: _colorAnimation.value,
                        size: _sizeAnimation.value,
                      ),
                      splashRadius: 5,
                      onPressed: () {
                        if (count == 0) {
                          _animationController.forward();
                          count++;
                          icon = Icons.notifications_off;
                          setInt(count);
                        } else {
                          _animationController.reverse();
                          count = 0;
                          icon = Icons.notifications_on;
                          setInt(count);
                        }
                      },
                    );
                  }),
            )
          ],
        ),



        // News cards
        StreamBuilder<NewsFunc>(
          stream: UserNews(docname: 'newstuff').newsstuff,
          // ignore: missing_return
          builder: (context, snapshot) {
            NewsFunc newslol2 = snapshot.data;
            if (snapshot.hasData) {
              var arr = newslol2.news;
              var arr2 = newslol2.images;
              var arr3 = newslol2.caption;
              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: arr.length,
                    // ignore: missing_return
                    itemBuilder: (context, index) {
                      if(index == 0){
                        return Column(
                          children: [
                            Card(
                              margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 5),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 10.0,),
                                  Text(
                                    'Train Times',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey[800]),
                                  ),
                                  Divider(
                                    thickness: 2.0,
                                  ),
                                  Text('Next Train In :'),
                                  SizedBox(height: 20.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding : EdgeInsets.only(left: 3.0) ,
                                              child: Text('Kajang',style: TextStyle(fontWeight: FontWeight.bold),)),
                                          SizedBox(height: 10.0,),
                                          Text('3 mins'),
                                          SizedBox(height: 10.0,),
                                          Text('6 mins'),
                                          SizedBox(height: 10.0,),
                                          Text('9 mins'),
                                        ],
                                      ),
                                      SizedBox(width: 100.0, height: 40.0,
                                        child: Padding(
                                            padding: EdgeInsets.only(left: 19.0),
                                            child: Icon(Icons.access_time_outlined)),),
                                      Padding(
                                        padding: EdgeInsets.only(),
                                        child: Column(
                                          children: [
                                            Padding(
                                                padding : EdgeInsets.only(left: 8.0) ,
                                                child: Text('Sungai Buloh',style: TextStyle(fontWeight: FontWeight.bold),)),
                                            SizedBox(height: 10.0,),
                                            Text('3 mins'),
                                            SizedBox(height: 10.0,),
                                            Text('6 mins'),
                                            SizedBox(height: 10.0,),
                                            Text('9 mins'),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 10.0,),
                                ],
                              ),
                            ),
                        SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                        child: Container(
                        height: 120,
                          width: double.maxFinite,
                          child: Card(
                            margin:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            elevation: 2,
                            // Prevents picture from overriding card borders
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            borderOnForeground: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 120,
                                  width: 120,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Image.network(arr2[index],
                                      fit: BoxFit.fill),
                                ),
                                Positioned(
                                  left: 130,
                                  top: 15,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        arr[index],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey[800],
                                            fontSize: 22),
                                      ),
                                      Text(arr3[index],
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 110.0, top: 25),
                                        child: Text('2 hours ago',
                                            style:
                                            TextStyle(color: Colors.grey)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                          ],
                        );
                      }
                      else{
                        return GestureDetector(
                          child: Container(
                            height: 120,
                            child: Card(
                              margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 5),
                              elevation: 2,
                              // Prevents picture from overriding card borders
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              borderOnForeground: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 120,
                                    width: 120,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Image.network(arr2[index],
                                        fit: BoxFit.fill),
                                  ),
                                  Positioned(
                                    left: 130,
                                    top: 15,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          arr[index],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueGrey[800],
                                              fontSize: 22),
                                        ),
                                        Text(arr3[index],
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15)),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 110.0, top: 25),
                                          child: Text('2 hours ago',
                                              style:
                                              TextStyle(color: Colors.grey)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }),
              );
            } else {
              return Container(
                height: 10,
                width: 10,
              );
            }
          },
        ),
      ]),
    );
  }
}
