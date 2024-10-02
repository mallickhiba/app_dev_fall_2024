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
          jsonDecode(response.body)['data'].map((data) => data['job']).toList();
      return jsonResponse.map((job) => Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding: const EdgeInsets.all(12.0),
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0), // Add vertical spacing
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          // BoxShadow(
                          //   color: Colors.grey.withOpacity(0.3),
                          //   spreadRadius: 3,
                          //   blurRadius: 5,
                          //   offset: Offset(0, 3), // changes position of shadow
                          // ),
                        ],
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            job.company.logo,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(job.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(job.company.name),
                            Text(
                                '${job.location.nameEn}, ${job.workplaceType.nameEn}, ${job.type.nameEn}'),
                          ],
                        ),
                        trailing: Text(
                          timeago.format(DateTime.parse(job.createdDate)),
                          style: TextStyle(color: Colors.grey),
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
