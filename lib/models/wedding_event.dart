import 'package:flutter/material.dart';

class WeddingEvent {
  final String id;
  final String title;
  final String subtitle;
  final String date;
  final String time;
  final String venue;
  final String address;
  final String dressCode;
  final IconData icon;
  final String mapUrl;

  const WeddingEvent({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
    required this.venue,
    required this.address,
    required this.dressCode,
    required this.icon,
    this.mapUrl = "",
  });
}
