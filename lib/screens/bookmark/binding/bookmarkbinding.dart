import 'package:get/get.dart';
import 'package:ketitik/screens/bookmark/bookmarkcontroller.dart';


class BookMarkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookmarkController());
  }
}
