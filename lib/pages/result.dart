import 'package:flutter/material.dart';
import 'package:map/pages/show.dart';
import 'package:map/services/api.dart';
import 'package:map/widgets/common.dart';
import 'package:mapbox_search/mapbox_search.dart';

class ResultPage extends StatelessWidget {
  final String inputText;
  const ResultPage({
    Key? key,
    required this.inputText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Result',
          style: TextStyle(color: Colors.black),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: BackButton(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<MapBoxPlace>?>(
        future: placesSearch(inputText: inputText),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: customCircularIndicator());
          } else if (snapshot.data?.length == null) {
            return Center(
                child: flexibleText(
              text: 'No data',
              fontWeight: FontWeight.bold,
            ));
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            padding: const EdgeInsets.all(18),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (_, index) {
              final data = snapshot.data?[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowPage(data: data!),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      flexibleText(
                        text: data?.placeName ?? '',
                        alignment: Alignment.topLeft,
                        overflow: TextOverflow.ellipsis,
                        padding: const EdgeInsets.only(left: 7),
                      ),
                      flexibleText(
                        text: data?.text ?? '',
                        textColor: Colors.grey,
                        fontSize: 14,
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 10),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
