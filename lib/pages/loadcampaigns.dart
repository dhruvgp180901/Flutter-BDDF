import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lifeshare/utils/customWaveIndicator.dart';

class LoadcampaignsPage extends StatefulWidget {
  @override
  _LoadcampaignsPageState createState() => _LoadcampaignsPageState();
}

class _LoadcampaignsPageState extends State<LoadcampaignsPage> {
  List<String> names = [];
  List<String> contents = [];
  List<String> images=[];
  Widget _child;

  @override
  void initState() {
    _child = WaveIndicator();
    getDonors();
    super.initState();
  }

  Future<Null> getDonors() async {
    await Firestore.instance
        .collection('Campaign Details')
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        for (int i = 0; i < docs.documents.length; ++i) {
          names.add(docs.documents[i].data['name']);
          contents.add(docs.documents[i].data['content']);
          images.add(docs.documents[i].data['image']);
        }
      }
    });
    setState(() {
      _child = myWidget();
    });
  }
  Widget myWidget() {
    
    return Scaffold(
      backgroundColor: Color.fromARGB(1000, 221, 46, 68),
      appBar: AppBar(          
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Campaigns",
          style: TextStyle(
            fontSize: 50.0,
            fontFamily: "SouthernAire",
            color: Colors.white,
          ),
        ),
         leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.reply,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ClipRRect(
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0)),
        child: Container(
          height: 800.0,
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(names[index],style: TextStyle(fontWeight: FontWeight.bold),),
                      
                      Align(
                        alignment: Alignment.centerRight,
                        
                        // child: IconButton(
                        //   icon: Icon(Icons.message),
                        //   onPressed: () {launch(('sms://1234'));},
                        //   color: Color.fromARGB(1000, 221, 46, 68),
                        // ),
                      ),
                      Text(contents[index]),
                      Align(
                        alignment: Alignment.topLeft,
                        // child: IconButton(
                        //   icon: Icon(Icons.message),
                        //   onPressed: () {launch(('sms://1234'));},
                        //   color: Color.fromARGB(1000, 221, 46, 68),
                        // ),
                      ),
                      
                    ],
                    
                  ),
                  
                  // leading: CircleAvatar(
                  //   child: Text(
                  //     contents[index],
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  //   backgroundColor: Color.fromARGB(1000, 221, 46, 68),
                  // ),
                  // trailing: IconButton(
                  //   icon: Icon(Icons.phone),
                  //   onPressed: () {launch(('tel://1234'));},
                  //   color: Color.fromARGB(1000, 221, 46, 68),
                  // ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}