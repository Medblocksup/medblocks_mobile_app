import 'package:flutter/material.dart';
import '../../../data/models/doctor_model.dart';
import 'doctor_details_screen.dart';


class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<Doctor> doctors = [
    Doctor(
      name: "Dr. Sarah Johnson",
      specialty: "Cardiologist",
      image: "https://i.pravatar.cc/300?img=1",
      rating: 4.9,
      experience: "12 Years",
      about: "Expert in heart diseases and treatments.",
    ),
    Doctor(
      name: "Dr. Michael Lee",
      specialty: "Dermatologist",
      image: "https://i.pravatar.cc/300?img=2",
      rating: 4.8,
      experience: "9 Years",
      about: "Skin care and cosmetic specialist.",
    ),
    Doctor(
      name: "Dr. Emma Wilson",
      specialty: "Neurologist",
      image: "https://i.pravatar.cc/300?img=3",
      rating: 4.7,
      experience: "11 Years",
      about: "Brain and nervous system specialist.",
    ),
    Doctor(
      name: "Dr. James Brown",
      specialty: "Orthopedic",
      image: "https://i.pravatar.cc/300?img=4",
      rating: 4.9,
      experience: "14 Years",
      about: "Bone and joint treatment expert.",
    ),
    Doctor(
      name: "Dr. Olivia Davis",
      specialty: "Pediatrician",
      image: "https://i.pravatar.cc/300?img=5",
      rating: 4.8,
      experience: "10 Years",
      about: "Child healthcare specialist.",
    ),
    Doctor(
      name: "Dr. Daniel Taylor",
      specialty: "Dentist",
      image: "https://i.pravatar.cc/300?img=6",
      rating: 4.6,
      experience: "8 Years",
      about: "Dental surgery and cosmetic dentistry.",
    ),
    Doctor(
      name: "Dr. Sophia Martin",
      specialty: "Gynecologist",
      image: "https://i.pravatar.cc/300?img=7",
      rating: 4.9,
      experience: "13 Years",
      about: "Women's health specialist.",
    ),
    Doctor(
      name: "Dr. William Clark",
      specialty: "Psychiatrist",
      image: "https://i.pravatar.cc/300?img=8",
      rating: 4.7,
      experience: "7 Years",
      about: "Mental health and therapy expert.",
    ),
    Doctor(
      name: "Dr. Isabella Moore",
      specialty: "ENT Specialist",
      image: "https://i.pravatar.cc/300?img=9",
      rating: 4.8,
      experience: "10 Years",
      about: "Ear, nose and throat specialist.",
    ),
    Doctor(
      name: "Dr. Ethan White",
      specialty: "Ophthalmologist",
      image: "https://i.pravatar.cc/300?img=10",
      rating: 4.9,
      experience: "15 Years",
      about: "Eye care and surgery specialist.",
    ),
  ];

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = doctors.where((doctor) {
      return doctor.name.toLowerCase().contains(searchText.toLowerCase()) ||
          doctor.specialty.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xffF6F8FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Find Doctor",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search doctors...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDoctors.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            DoctorDetailsScreen(doctor: doctor),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(.05),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage:
                          NetworkImage(doctor.image),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                doctor.specialty,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    doctor.rating.toString(),
                                  ),
                                  const SizedBox(width: 15),
                                  const Icon(
                                    Icons.work_outline,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    doctor.experience,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}