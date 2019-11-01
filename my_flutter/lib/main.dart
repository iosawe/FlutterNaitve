import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() async {
  runApp(_buildRootWidget(ui.window.defaultRouteName));
}
Widget _buildRootWidget(String route){
  return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _widgetForRoute(route),
    );
}
Widget _widgetForRoute(String route){
  switch(route){
    case 'route1':
      return MyHomePage(title: 'methodhandle',);
    case 'route2':
     return IosCallFlutter(title: 'eventhandle',);
    default:
      // return IosCallFlutter(title: 'hello',);
       return Center(
        child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
      );
  }
}


class IosCallFlutter extends StatefulWidget {
  IosCallFlutter({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _IosCallFlutter createState() => _IosCallFlutter();
}

class _IosCallFlutter extends State<IosCallFlutter> {
  // 注册一个通知
  static const EventChannel eventChannel = const EventChannel('com.pages.your/native_post');

  // 渲染前的操作，类似viewDidLoad
  @override
  void initState() {
    super.initState();
    // 监听事件，同时发送参数12345
    eventChannel.receiveBroadcastStream(12345).listen(_onEvent,onError: _onError);
  }

  String naviTitle = 'title' ;
  // 回调事件
  void _onEvent(Object event) {
    setState(() {
      naviTitle =  event.toString();
    });
  }
  // 错误返回
  void _onError(Object error) {

  }




   _incrementCounter()  {
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(naviTitle),
            Text(
              'hello',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){_incrementCounter();},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // num _countr;
  static const methodChannel = const MethodChannel('com.pages.your/native_get');
   _incrementCounter() async {
    // await methodChannel.invokeMethod('func1');
    // await methodChannel.invokeMethod('func2','flutter-pase-param');
    // Map<String, dynamic> map = {"code": "200", "data":[1,2,3]};
    // await methodChannel.invokeMethod('func1',map);
    // 创建一个给native的channel (类似iOS的通知）

    String result = await methodChannel.invokeMethod('func3');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(title: new Text(result),);
      }
    );
    // dynamic result;
    // try {
    //   result = await methodChannel.invokeMethod('func3');
    // } on PlatformException {
    //   result = "error";
    // }
    // if (result is String) {
    //   AlertDialog(title: new Text(result),);
      
    // }
  
    // setState(() {
     
    //   _counter++;
    // });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){_incrementCounter();},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IosCallFlutter(title: 'call flutter'),
    );
  }
}