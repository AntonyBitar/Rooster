import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {
  final isOpened = true.obs;
  bool isMenuOpened = true;
  final isMenuOpened1 = true.obs;

  final isMobile = false.obs;
  final selectedTab = 'dashboard_summary'.obs;

  setIsMenuOpened(bool value) {
    isMenuOpened = value;
    isMenuOpened1.value=value;
    update();
  }

  String userName = '';
  setName(String value){
    userName=value;
    update();
  }


  String companyName = '';
  var companyAddress = '';

  setCompanyName(String val){
     companyName = val;
     update();
  }
  setCompanyAddress(String val){
    companyAddress = val;
     update();
  }
  // toggleIsOpenedValue() {
  //   isOpened.value = !isOpened.value;
  //   update();
  // }
  setIsMobile(bool value) {
    isMobile.value = value;
    update();
  }


  OverlayEntry? mainMenuOverlay;
  OverlayEntry? subMenuOverlay;

  void hideMenus() {
    mainMenuOverlay?.remove();
    subMenuOverlay?.remove();
    mainMenuOverlay = null;
    subMenuOverlay = null;
  }


  // late AnimationController animationController;
  // late Animation<double> widthAnimation;
  // double relativeWidth=0;

  // setRelativeWidth(double val){
  //   relativeWidth=val;
  //   update();
  // }

  // forwardController(){
  //   animationController.forward();
  //   update();
  // }
  //
  // reverseController(){
  //   animationController.reverse();
  //   update();
  // }

}
