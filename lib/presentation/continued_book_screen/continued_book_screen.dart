import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_subtitle_five.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';

class ContinuedBookScreen extends StatelessWidget {
  const ContinuedBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: Column(children: [
                  SizedBox(
                      width: 325.h,
                      child: Text(
                          "\"Harry đã kiềm chế không hét lên, nhưng gần như là vậy. Sinh vật nhỏ trên giường có đôi tai to giống dơi và đôi mắt màu xanh lồi ra to bằng quả tennis. Harry ngay lập tức nhận ra rằng đó chính là sinh vật đã theo dõi anh từ hàng rào vườn sáng nay.\n\nKhi họ nhìn nhau, Harry nghe tiếng Dudley từ hành lang.\n\n\"Có thể tôi lấy áo cho Mr. và Mrs. Mason không?\"\nSinh vật trượt khỏi giường và cúi thấp tới mức đầu mũi dài và mảnh mai của nó chạm vào thảm. Harry nhận ra rằng nó đang mặc một cái gì đó giống như một cái vỏ gối cũ, với các lỗ rách cho tay và chân.\n\"Ừ, xin chào,\" Harry nói cứng nhắc.\n\n\"Harry Potter!\" Sinh vật nói bằng giọng cao mà Harry chắc chắn sẽ nghe rõ từ trên cầu thang. \"Dobby đã lâu rồi muốn gặp anh, ngài… Đó là một vinh dự lớn…\"\n\n\"Cảm ơn,\" Harry nói, bò dọc theo tường và ngồi vào ghế bàn làm việc của mình, kế bên Hedwig, đang ngủ trong lồng to. Anh muốn hỏi, \"Anh là ai?\" nhưng nghĩ rằng sẽ nghe quá thô lỗ, nên anh nói, \"Anh là ai?\"\n\"Dobby, ngài. Chỉ là Dobby. Dobby là một linh lực nhà, ngài,\" sinh vật nói.\n\n\"Ồ, thật sao?\" Harry nói. \"Ừ, tôi không muốn phô trương hoặc gì cả, nhưng—đây không phải là thời điểm thích hợp cho tôi có một linh lực nhà trong phòng ngủ của mình.\"\n\nTiếng cười giả tạo cao của cô cô Petunia vang lên từ phòng khách. Sinh vật trượt đầu xuống.\n\"Không phải là tôi không vui khi gặp anh,\" Harry nhanh chóng nói, \"nhưng, à, có lý do cụ thể gì anh đang ở đây không?\"\n\n\"Ồ, có, ngài,\" Dobby nói chân thành. \"Dobby đến nói với ngài, ngài… điều đó khó khăn lắm, ngài… Dobby không biết bắt đầu từ đâu…\"\n\n\"Ngồi xuống,\" Harry nói lịch sự, chỉ vào giường.\nMột cách kinh hoàng, linh lực nhà bùng lên khóc—rất ồn ào.\n\n\"Ngồi xuống!\" nó la hét. \"Chẳng bao giờ… bao giờ…\"\nHarry nghĩ rằng anh nghe thấy tiếng nói phía dưới dậy.\n\"Tôi xin lỗi,\" anh thì thầm, \"Tôi không có ý xúc phạm anh hoặc cái gì cả.\"\n\n\"Xúc phạm Dobby!\" sinh vật nghẹn ngào. \"Dobby chưa bao giờ được hỏi ngồi xuống bởi một phù thủy—như ngang hàng—\"\n\nHarry, cố gắng nói \"Xin im lặng!\" và nhìn an ủi cùng một lúc, dìu Dobby trở lại giường—Hedwig đã tỉnh dậy với tiếng kêu rất lớn và đang đập cánh mạnh mẽ chống lại thanh gà.\n\n\"Dobby phải phạt chính mình, ngài,\" linh lực nhà nói, người đã điều chỉnh mắt hơi mơ mịt. \"Dobby gần như nói xấu về gia đình của mình, ngài…\"\n\n\"Gia đình của anh?\"\n\n\"Gia đình phục vụ của Dobby, ngài… Dobby là linh lực nhà—bị ràng buộc phục vụ một nhà và một gia đình mãi mãi…\"\n\n\"Họ có biết anh ở đây không?\" Harry hỏi tò mò.\n\nDobby rùng mình.\n\n\"Ồ, không, ngài, không… Dobby sẽ phải tự phạt mình rất mạnh vì đến gặp anh, ngài. Dobby sẽ phải nhét tai mình vào cửa lò vi sóng vì điều này. Nếu họ biết, ngài—\"\n\"Nhưng họ sẽ không để ý nếu anh nhét tai mình vào cửa lò vi sóng?\"\n\n\"Dobby nghi ngờ, ngài. Dobby luôn phải tự phạt mình vì cái gì đó, ngài. Họ để Dobby tự mình xử lí, ngài. Đôi khi họ nhắc nhở tôi phải tự xử phạt nhiều hơn…\"\n\n\"Nhưng tại sao anh không trốn đi? Thoát khỏi?\"\n\n\"Một linh lực nhà phải được tự do, ngài. Và gia đình sẽ không bao giờ thả Dobby ra… Dobby sẽ phục vụ gia đình đến khi chết, ngài…\"\"",
                          maxLines: 32,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: CustomTextStyles.bodySmallRegular12)),
                  SizedBox(height: 83.v),
                  CustomImageView(
                      imagePath: ImageConstant.imgMovecomponent4,
                      height: 44.v,
                      width: 299.h,
                      radius: BorderRadius.circular(22.h)),
                  SizedBox(height: 5.v)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 50.v,
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgClose,
            margin: EdgeInsets.only(left: 25.h, top: 16.v, bottom: 17.v),
            onTap: () {
              onTapClose(context);
            }),
        centerTitle: true,
        title: AppbarSubtitleFive(text: "Harry Potter - Chamber of Secrets"));
  }

  /// Navigates back to the previous screen.
  onTapClose(BuildContext context) {
    Navigator.pop(context);
  }
}
