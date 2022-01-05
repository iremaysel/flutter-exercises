import 'dart:async';

import 'package:flutter/material.dart';

class TimerLifecycle extends StatefulWidget {
  const TimerLifecycle({Key? key}) : super(key: key);

  @override
  _TimerLifecycleState createState() => _TimerLifecycleState();
}

class _TimerLifecycleState extends State<TimerLifecycle> with WidgetsBindingObserver{
  late Timer timer ;
  int count = 0;
  bool active = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (time) {
      if(active){
        setState(() {
          count +=1;
        });
      }
    });
    print("initState Çalıştı!");
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Dispose çalıştı!");
    timer.cancel();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void deactivate() {
    print("Deactivate çalıştı!");
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.inactive){
      active = false;
      print("inactive çalıştı!");
    }
    if(state == AppLifecycleState.paused){
      active = false;
      print("paused çalıştı!");
    }
    if(state == AppLifecycleState.resumed){
      print("resumed çalıştı!");
      active = true;
    }
    if(state == AppLifecycleState.detached){
      print("detached çalıştı!");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Build çalıştı");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB2A0D9),
        title: Text("Zamanlayıcı" ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("$count", style: TextStyle(color: Colors.black45, fontSize: 40, fontWeight: FontWeight.bold),),

          ],
        ),
      ),
    );
  }
}
