import 'dart:math';

import 'package:flutter/material.dart';
import 'package:login_web/api_service.dart';
import 'package:login_web/doctor/doctor.dart';
import 'package:login_web/doctor/detallesdoctor.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  static final List<String> imageUrls = [
    'https://t4.ftcdn.net/jpg/01/34/29/31/360_F_134293169_ymHT6Lufl0i94WzyE0NNMyDkiMCH9HWx.jpg',
    'https://www.shutterstock.com/image-illustration/male-doctor-avatar-3d-illustration-260nw-2205299083.jpg',
    'https://www.shutterstock.com/image-illustration/male-doctor-avatar-3d-illustration-260nw-2205299083.jpg',
    'https://st3.depositphotos.com/1432405/12513/v/450/depositphotos_125136404-stock-illustration-doctor-icon-flat-style.jpg',
    'https://st2.depositphotos.com/4226061/9064/v/950/depositphotos_90647730-stock-illustration-female-doctor-avatar-icon.jpg',
  ];

  const DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    final int randomImageIndex = Random().nextInt(imageUrls.length);
    return GestureDetector(
      onTap: () {
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDetailsScreen(doctor: doctor),
          ),
        );
      },
      child: Container(
        width: 300.0,
        height: 300.0,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(imageUrls[randomImageIndex],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: 300.0,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${doctor.nombres} ${doctor.apellidos}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Especialidades: ${doctor.especialidades.join(", ")}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      doctor.descripcion,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
