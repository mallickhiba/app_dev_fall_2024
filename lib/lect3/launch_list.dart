import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class Launch {
  String? missionName;
  String? missionId;
  List<String>? manufacturers;
  List<String>? payloadIds;
  String? wikipedia;
  String? website;
  String? twitter;
  String? description;

  Launch(
      {this.missionName,
      this.missionId,
      this.manufacturers,
      this.payloadIds,
      this.wikipedia,
      this.website,
      this.twitter,
      this.description});

  Launch.fromJson(Map<String, dynamic> json) {
    missionName = json['mission_name'];
    missionId = json['mission_id'];
    manufacturers = json['manufacturers'].cast<String>();
    payloadIds = json['payload_ids'].cast<String>();
    wikipedia = json['wikipedia'];
    website = json['website'];
    twitter = json['twitter'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mission_name'] = missionName;
    data['mission_id'] = missionId;
    data['manufacturers'] = manufacturers;
    data['payload_ids'] = payloadIds;
    data['wikipedia'] = wikipedia;
    data['website'] = website;
    data['twitter'] = twitter;
    data['description'] = description;
    return data;
  }
}

class LaunchListState extends StatefulWidget {
  const LaunchListState({super.key});

  @override
  State<LaunchListState> createState() => _LaunchListState();
}

class _LaunchListState extends State<LaunchListState> {
  List<Launch> launches = [];

  Future<List<Launch>> fetchAllLaunches() async {
    final response =
        await http.get(Uri.parse('https://api.spacexdata.com/v3/missions'));

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((launch) => Launch.fromJson(launch)).toList();
    } else {
      throw Exception('Failed to load launches');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Space Missions'),
        backgroundColor: const Color.fromARGB(255, 10, 90, 82),
      ),
      body: Center(
        child: FutureBuilder<List<Launch>>(
          future: fetchAllLaunches(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Failed to load launches');
            } else if (snapshot.hasData) {
              final launches = snapshot.data!;
              return ListView.builder(
                itemCount: launches.length,
                itemBuilder: (context, index) {
                  final launch = launches[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal:
                          16.0, // Add horizontal padding to control the box width
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white, // Set the background to white
                        border: Border.all(
                          color:
                              Colors.grey.withOpacity(0.2), // Thin grey border
                          width: 1.0,
                        ),
                        borderRadius:
                            BorderRadius.circular(15), // Rounded corners
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            16.0), // Padding inside the Container
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              launch.missionName ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              launch.description ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: launch.payloadIds?.map((payloadId) {
                                    final random = Random();
                                    return Chip(
                                      label: Text(payloadId),
                                      backgroundColor: Color.fromARGB(
                                        255, // Set alpha to 255 (fully opaque)
                                        random.nextInt(256), // Random red value
                                        random
                                            .nextInt(256), // Random green value
                                        random
                                            .nextInt(256), // Random blue value
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    );
                                  }).toList() ??
                                  [],
                            ),
                            const SizedBox(height: 8.0),
                            Align(
                              alignment:
                                  Alignment.centerRight, // Align to the right
                              child: IconButton(
                                icon: const Icon(Icons.arrow_downward),
                                tooltip: 'More',
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text('No launches available');
            }
          },
        ),
      ),
    );
  }
}
