

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TCloudHelperFunctions {

  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot){
    if(snapshot.connectionState == ConnectionState.waiting){
      return const Center(child: CircularProgressIndicator(),);
    }

    if(!(snapshot.hasData) || snapshot.data==null){
      return const Center(child: Text('Không có dữ liệu'),);

    }

    if(snapshot.hasError){
      return const  Center(child: Text('Đã xảy ra lỗi gì đó!'),);
    }

    return null;
  }


  static Widget? checkMultiRecordState<T>({required AsyncSnapshot<List<T>> snapshot, Widget? loader, Widget? error, Widget? nothingFound}){
    if(snapshot.connectionState == ConnectionState.waiting){
      return const Center(child: CircularProgressIndicator(),);
    }

     if(!(snapshot.hasData) || snapshot.data==null){
      return const Center(child: Text('Không có dữ liệu'),);

    }

    if(snapshot.hasError){
      return const  Center(child: Text('Đã xảy ra lỗi gì đó!'),);
    }

    return null;
  }


  // Create reference with an inital file path and name  and retrive the dowload url
  static Future<String> getURLFromFilePathAndName(String path) async {
    try {
      if(path.isEmpty) return '';
      final ref = FirebaseStorage.instance.ref().child(path);
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch(e){
      throw e.toString();
    } on PlatformException catch(e){
      throw e.toString();
    } catch (e) {
      throw 'Đã xảy ra lỗi gì đó! $e';
    }
  }



}