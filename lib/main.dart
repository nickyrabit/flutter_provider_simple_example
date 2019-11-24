import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'app_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider<AppState>(
          builder: (_) => AppState(),
          child: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextDisplay(),
              TextEditWidget(),
              RaisedButton(
                onPressed: ()=> appState.fetchData(),
                child: Text("Fetching data"),
              ),

              ResponseDisplay(),
            ],
          ),
        ),
      ),
    );
  }
}

class ResponseDisplay extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: appState.isFetching ? CircularProgressIndicator() : appState.getResponseJson() != null ? ListView.builder(

        primary: false,
        shrinkWrap: true,
        itemCount: appState.getResponseJson().length,
        itemBuilder: (context, index) {

          return ListTile(

            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  appState.getResponseJson()[index]['avatar']),
            ),
            title: Text(
              appState.getResponseJson()[index]["first_name"],
            ),

          );
        },
      )
          : Text("Press Button above to fetch data"),
    );
  }
}

class TextEditWidget extends StatefulWidget {
  @override
  _TextEditWidgetState createState() => _TextEditWidgetState();
}


class _TextEditWidgetState extends State<TextEditWidget> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Container(
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          labelText: "Some Text",
          border: OutlineInputBorder(),
        ),
        onChanged: (changed) => appState.setDisplayText(changed),
        onSubmitted: (submitted) => appState.setDisplayText(submitted),
      ),
    );
  }
}


class TextDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState  = Provider.of<AppState>(context);
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Text(appState.getDisplayText,
      style: TextStyle(fontSize: 24),),
    );
  }
}