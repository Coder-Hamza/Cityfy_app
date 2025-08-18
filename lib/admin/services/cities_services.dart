import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class CitiesServices {
  SupabaseClient supabase = Supabase.instance.client;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add Cities

  Future<void> addCity(
    Uint8List image,
    String imagename,
    String name,
    String desc,
  ) async {
    try {
      // Upload Image To Supabase
      await supabase.storage
          .from('cities_images')
          .uploadBinary('images/$imagename', image);

      // Get Link From Supabase
      String imageUrl = supabase.storage
          .from("cities_images")
          .getPublicUrl('images/$imagename');

      // Generate Id For Cities

      var uuid = Uuid();

      String citiesId = uuid.v1();

      // Save Data In Firestore

      _db.collection('cities').doc(citiesId).set({
        'id': citiesId,
        'imageUrl': imageUrl,
        'name': name,
        'desc': desc,
      });
    } catch (e) {
      throw e.toString();
    }
  }
}
