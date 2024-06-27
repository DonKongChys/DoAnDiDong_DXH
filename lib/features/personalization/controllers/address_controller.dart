
import 'package:TShop/data/repositories/address/address_repository.dart';
import 'package:TShop/features/personalization/models/address_model.dart';
import 'package:TShop/utils/constants/image_string.dart';
import 'package:TShop/utils/helpers/network_manager.dart';
import 'package:TShop/utils/popups/full_screen_loader.dart';
import 'package:TShop/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();


  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  // Fetch all user specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async{
    try{
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere((element) => element.selectedAddress, orElse: () => AddressModel.empty());

      return addresses;
    } catch(e) {
      TLoaders.errorSnackBar(title :'Không tìm thấy địa chỉ!', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async{
    try{
      // Get.defaultDialog(
      //   title: '',
      //   onWillPop: () async {return false;},
      //   barrierDismissible: false,
      //   backgroundColor: Colors.transparent,
      //   content: TCircularLoader(50, Colors.blue),
      // );
      // Clear the 'selected' field
      if(selectedAddress.value.id.isNotEmpty){
        await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }
      // Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;
      //Set the 'selected' field to true for the newly selected address
      await addressRepository.updateSelectedField(selectedAddress.value.id, true);
    }catch(e){
      TLoaders.errorSnackBar(title: 'Lỗi khi selection', message: e.toString());
    }
  }
  // Add new address
  Future addNewAddress() async{
    try{
      // Start Loading
      TFullScreenLoader.openLoadingDialog('Đang lưu...', TImages.docerAnimation);

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save address data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(address);

      //Update selected address status
      address.id = id;
      await selectAddress(address);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      //Show success message
      TLoaders.successSnackBar(title: 'Thông báo', message: 'Thêm email thành công!');

      //Refresh Addressses Data 
      refreshData.toggle();

      // Reset fields
      resetFormFields();

      //Redirect
      Navigator.of(Get.context!).pop();
    }catch(e){
      //Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Không tìm thấy địa chỉ', message: e.toString());
    }
  }

  void  resetFormFields(){
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}