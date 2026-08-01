import 'package:flutter/material.dart';
import '../../../data/models/doctor_model.dart';
import '../utility/app_colors.dart';
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
      name: "Dr. Sophie Martin",
      specialty: "Cardiologue",
      image: "https://images.unsplash.com/photo-1559839734-2b71ea197ec2",
      rating: 4.9,
      experience: "12 ans",
      about: "Spécialiste des maladies cardiovasculaires.",
    ),
    Doctor(
      name: "Dr. Jean Dupont",
      specialty: "Dermatologue",
      image: "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d",
      rating: 4.8,
      experience: "10 ans",
      about: "Expert en dermatologie et soins de la peau.",
    ),
    Doctor(
      name: "Dr. Claire Bernard",
      specialty: "Neurologue",
      image: "https://images.unsplash.com/photo-1594824476967-48c8b964273f",
      rating: 4.9,
      experience: "11 ans",
      about: "Spécialiste du système nerveux et du cerveau.",
    ),
    Doctor(
      name: "Dr. Pierre Laurent",
      specialty: "Orthopédiste",
      image: "https://images.unsplash.com/photo-1622253692010-333f2da6031d",
      rating: 4.7,
      experience: "14 ans",
      about: "Traitement des os, articulations et blessures sportives.",
    ),
    Doctor(
      name: "Dr. Marie Dubois",
      specialty: "Pédiatre",
      image: "https://images.unsplash.com/photo-1651008376811-b90baee60c1f",
      rating: 4.8,
      experience: "9 ans",
      about: "Soins médicaux pour nourrissons et enfants.",
    ),
    Doctor(
      name: "Dr. Antoine Moreau",
      specialty: "Dentiste",
      image: "https://images.unsplash.com/photo-1537368910025-700350fe46c7",
      rating: 4.6,
      experience: "8 ans",
      about: "Dentisterie générale et esthétique.",
    ),
    Doctor(
      name: "Dr. Émilie Robert",
      specialty: "Gynécologue",
      image: "https://randomuser.me/api/portraits/women/52.jpg",
      rating: 4.9,
      experience: "13 ans",
      about: "Santé et bien-être des femmes.",
    ),
    Doctor(
      name: "Dr. Nicolas Petit",
      specialty: "Psychiatre",
      image: "https://images.unsplash.com/photo-1614608682850-e0d6ed316d47",
      rating: 4.7,
      experience: "7 ans",
      about: "Traitement et accompagnement en santé mentale.",
    ),
    Doctor(
      name: "Dr. Camille Rousseau",
      specialty: "ORL",
      image: "https://images.unsplash.com/photo-1551884170-09fb70a3a2ed",
      rating: 4.8,
      experience: "10 ans",
      about: "Spécialiste des oreilles, du nez et de la gorge.",
    ),
    Doctor(
      name: "Dr. Julien Lefevre",
      specialty: "Ophtalmologue",
      image: "https://images.unsplash.com/photo-1582750433449-648ed127bb54",
      rating: 4.9,
      experience: "15 ans",
      about: "Diagnostic et chirurgie des yeux.",
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
      appBar:  AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      title: const Text(
        "Find Doctors",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Color(0xff1E293B),
          fontFamily: "mn",
        ),
      ),
    ),
      body: Column(
        children: [
      Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 22),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchText = value;
          });
        },
        style: const TextStyle(
          fontFamily: 'mn',
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: "Search doctor, specialty...",
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontFamily: 'mn',
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.primaryColor,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.2,
            ),
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
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.04),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [

                        Hero(
                          tag: doctor,
                          child: CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.grey.shade100,
                            backgroundImage: NetworkImage(doctor.image),
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                doctor.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff1E293B),
                                  fontFamily: 'mn',
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                doctor.specialty,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  fontFamily: 'mn',
                                ),
                              ),

                              const SizedBox(height: 12),

                              Row(
                                children: [

                                  const Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                    size: 18,
                                  ),

                                  const SizedBox(width: 5),

                                  Text(
                                    doctor.rating.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'mn',
                                    ),
                                  ),

                                  const SizedBox(width: 18),

                                  Icon(
                                    Icons.workspace_premium_rounded,
                                    size: 18,
                                    color: Colors.blueGrey.shade400,
                                  ),

                                  const SizedBox(width: 5),

                                  Expanded(
                                    child: Text(
                                      doctor.experience,
                                      style: const TextStyle(
                                        fontFamily: 'mn',
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),

                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(.08),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: AppColors.primaryColor,
                          ),
                        ),

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