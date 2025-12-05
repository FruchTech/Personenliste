import 'dart:io';
import 'package:flutter/material.dart';

ImageProvider getImageProvider(String? picture) {
  if (picture == null || picture.isEmpty) {
    return const AssetImage("assets/img/placeholder.png");
  }

  // URL
  if (picture.startsWith("http")) {
    return NetworkImage(picture);
  }

  // Asset?
  if (picture.startsWith("assets/")) {
    return AssetImage(picture);
  }

  // Lokale Datei
  final file = File(picture);
  if (file.existsSync()) {
    return FileImage(file);
  }

  // Fallback
  return const AssetImage("assets/img/placeholder.png");
}
