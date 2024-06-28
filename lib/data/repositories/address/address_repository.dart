
import 'package:TShop/data/repositories/authentication/authentication_repository.dart';
import 'package:TShop/features/personalization/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddressRepository extends GetxController{
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddresses() async {
    try{
      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) throw 'Không tìm thấy người dùng!';

      final result = await _db.collection('Users').doc(userId).collection('Addresses').get();
      return result.docs.map((documentSnapshot) => AddressModel.fromDocumentSnapshot(documentSnapshot)).toList();
    }catch(e) {
      throw 'Có lỗi xảy ra trong quá trình Fetch Address Data.!';
    }  
  }

  // Clear the 'selected' field for all addresses
  Future<void> updateSelectedField(String adddressId, bool selected) async{
    try{
      final userId = AuthenticationRepository.instance.authUser.uid;
      await _db.collection('Users').doc(userId).collection('Addresses').doc(adddressId).update({'SelectedAddress': selected});
    } catch(e){
      throw 'Lỗi khi cập nhật địa chỉ.!';
    } 
  }

  // Store new user order
  Future<String> addAddress(AddressModel address) async{
    try{
      final userId = AuthenticationRepository.instance.authUser.uid;
      final currentAddress = await _db.collection('Users').doc(userId).collection('Addresses').add(address.toJson());
      return currentAddress.id;
    }catch(e){
      throw 'Xảy ra lưu khi lưu địa chỉ. Vui lòng thử lại!';
    }
  }
}