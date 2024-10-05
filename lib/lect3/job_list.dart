import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;

class Company {
  final String name;
  final String logo;

  Company({required this.name, required this.logo});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      logo: json['logo'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logo': logo,
    };
  }
}

class Location {
  final String nameEn;

  Location({required this.nameEn});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      nameEn: json['name_en'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name_en': nameEn,
    };
  }
}

class WorkplaceType {
  final String nameEn;

  WorkplaceType({required this.nameEn});

  factory WorkplaceType.fromJson(Map<String, dynamic> json) {
    return WorkplaceType(
      nameEn: json['name_en'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name_en': nameEn,
    };
  }
}

class Type {
  final String nameEn;

  Type({required this.nameEn});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      nameEn: json['name_en'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name_en': nameEn,
    };
  }
}

class Job {
  final String title;
  final Company company;
  final Location location;
  final WorkplaceType workplaceType;
  final Type type;
  final String createdDate;

  Job({
    required this.title,
    required this.company,
    required this.location,
    required this.workplaceType,
    required this.type,
    required this.createdDate,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      title: json['title'],
      company: Company.fromJson(json['company']),
      location: Location.fromJson(json['location']),
      workplaceType: WorkplaceType.fromJson(json['workplace_type']),
      type: Type.fromJson(json['type']),
      createdDate: json['created_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company.toJson(),
      'location': location.toJson(),
      'workplace_type': workplaceType.toJson(),
      'type': type.toJson(),
      'created_date': createdDate,
    };
  }
}

class JobListState extends StatefulWidget {
  const JobListState({super.key});

  @override
  State<JobListState> createState() => _JobListState();
}

class _JobListState extends State<JobListState> {
  List<Job> jobs = [];

  Future<List<Job>> fetchAllJobs() async {
    final response = await http
        .get(Uri.parse('https://mpa0771a40ef48fcdfb7.free.beeceptor.com/jobs'));

    if (response.statusCode == 200) {
      List jsonResponse =
          jsonDecode(utf8.decode(response.body.codeUnits))['data']
              .map((data) => data['job'])
              .toList();
      return jsonResponse.map((job) => Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 1,
        backgroundColor: Colors.white, // Set the background color to white

        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Jobs',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Notifications',
            onPressed: () {
              //add notif page
            },
          ),
        ],
      ),
      backgroundColor: Colors.white, // Set the background color to white

      body: Center(
        child: FutureBuilder<List<Job>>(
          future: fetchAllJobs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Failed to load jobs');
            } else if (snapshot.hasData) {
              final jobs = snapshot.data!;
              return ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal:
                          16.0, // Add horizontal padding to control the box width
                    ),
                    child: Container(
                      decoration: BoxDecoration(
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                job.company.logo,
                                width: 55,
                                height: 55,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    job.title,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    job.company.name,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '${job.location.nameEn} · ${job.workplaceType.nameEn} · ${job.type.nameEn}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      timeago.format(
                                          DateTime.parse(job.createdDate)),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
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
              return const Text('No jobs available');
            }
          },
        ),
      ),
    );
  }
}
