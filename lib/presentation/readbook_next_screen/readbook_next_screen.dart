import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';

class ReadbookNextScreen extends StatelessWidget {
  const ReadbookNextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  SizedBox(
                      height: 671.v,
                      width: double.maxFinite,
                      child: Stack(alignment: Alignment.topCenter, children: [
                        Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                                width: 326.h,
                                child: Text(
                                    "Harry giữ được lòng hết sức không hét lên, nhưng gần như là suýt. Sinh vật nhỏ trên giường có đôi tai to như dơi và đôi mắt màu xanh phồng to như quả banh tennis. Harry ngay lập tức nhận ra đó chính là thứ đã theo dõi anh từ hàng rào vườn sáng nay.\n\nKhi họ nhìn nhau, Harry nghe tiếng của Dudley từ hành lang.\n\n\"Xin để tôi giúp bạn cởi áo, ông và bà Mason?\"\n\nSinh vật này bò xuống giường và cúi rất sâu đến mức đầu mũi dài, mỏng của nó chạm vào thảm. Harry nhận ra rằng nó đang mặc một cái túi gối cũ, với những khe hở dành cho cánh tay và chân.\n\n\"Er—xin chào,\" Harry nói cảm giác hồi hộp.\n\n\"Harry Potter!\" Sinh vật nói với giọng cao mà Harry chắc chắn là có thể nghe từ tầng dưới. \"Dobby đã muốn gặp anh từ lâu, thưa ông… Điều vinh dự lắm ạ…\"\n\n\"Th-thưa cảm ơn,\" Harry nói, cố gắng trườn dọc theo bức tường và ngồi vào chiếc ghế bàn học cạnh Hedwig, đang ngủ trong lồng lớn của mình. Anh muốn hỏi, \"Anh là gì?\" nhưng nghĩ rằng điều đó nghe có vẻ thô lỗ, vì thế anh nói, \"Anh là ai?\"\n\n\"Dobby, thưa ông. Chỉ là Dobby. Dobby, nô lệ trong nhà,\" sinh vật nói.\n\n\"Ồ—thật ư?\" Harry nói. \"Er—Tôi không muốn thiếu lịch sự hay gì cả, nhưng—đây không phải là thời điểm thích hợp để có một nô lệ trong phòng ngủ của tôi.\"\n\nTiếng cười giả dối, trầm từ phòng khách của cô cũng vang lên. Sinh vật này gục đầu.\n\n\"Không phải là tôi không vui vì được gặp bạn,\" Harry nói nhanh chóng, \"nhưng, er, có lý do cụ thể nào anh ở đây không?\"\n\n\"Ồ, vâng, thưa ông,\" Dobby nói nghiêm túc. \"Dobby đến để nói với ông, thưa ông… Điều này khó khăn, thưa ông… Dobby đang băn khoăn phải bắt đầu từ đâu…\"\n\n\"Ngồi xuống,\" Harry lịch sự nói, chỉ vào chiếc giường.\n\nVới nỗi sợ hãi, sinh vật này bật khóc—rất ồn ào.\n\n\"N-ngồi xuống!\" nó rít lên. \"Không bao giờ… không bao giờ…\"\n\nHarry nghĩ rằng anh nghe thấy tiếng các giọng từ tầng dưới lắng xuống.\n\n\"Xin lỗi,\" anh thì thầm, \"Tôi không có ý làm tổn thương bạn hay gì cả.\"\n\n\"Tổn thương Dobby!\" nghẹn ngào sinh vật này. \"Dobby chưa bao giờ được một phù thủy yêu cầu ngồi xuống—như một người bình đẳng—\"\n\nHarry, cố gắng nói \"Xin lặng\" và trở nên an ủi đồng thời, dẫn Dobby trở lại giường nơi nó ngồi co ro, trông giống như một con búp bê to và rất xấu xí. Cuối cùng nó đã kiểm soát được chính mình và ngồi với đôi mắt lớn, hướng về Harry với vẻ say đắm.\n\n\"Anh chưa bao giờ gặp nhiều phù thủy đáng tin,\" Harry cố gắng an ủi nó.\n\nDobby lắc đầu. Sau đó, mà không cảnh báo, nó nhảy dựng lên và bắt đầu đập liên tục đầu mình vào cửa sổ, la lên, \"Dobby xấu! Dobby xấu!\"\n\n\"Đừng—bạn đang làm gì?\" Harry xì lên và kéo Dobby trở lại giường—Hedwig đã tỉnh dậy với một tiếng kêu lớn và đập cánh mạnh mẽ vào thanh lồng.\n\n\"Dobby phải phạt mình, thưa ông,\" nói sinh vật này, mắt tròn xoay. \"Dobby suýt nói xấu về gia đình của mình, thưa ông…\"\n\n\"Gia đình của bạn?\"\n\n\"Gia đình phù thủy mà Dobby phục vụ, thưa ông… Dobby là một nô lệ nhà—buộc phải phục vụ một gia đình và một ngôi nhà mãi mãi…\"\n\n\"Họ có biết bạn ở đây không?\" Harry tò mò hỏi.\n\nDobby rùng mình.\n\n\"Ồ, không ạ, không… Dobby sẽ phải phạt mình rất nặng nếu đến gặp ông, thưa ông. Dobby sẽ phải đóng tai mình vào cửa lò vi sóng vì điều này. Nếu họ biết, thưa ông—\"\n\n\"Nhưng họ có nhận ra nếu bạn đóng tai mình vào cửa lò vi sóng?\"\n\n\"Dobby nghi ngờ điều đó, thưa ông. Dobby luôn phải phạt mình vì một điều gì đó, thưa ông. Họ để Dobby tự làm điều đó, thưa ông. Đôi khi họ nhắc nhở Dobby phải tự phạt mình thêm…\"\n\n\"Nhưng tại sao bạn không rời đi? Thoát khỏi?\"\n\"Một nô lệ nhà phải được tự do, thưa ông. Nhưng gia đình sẽ không bao giờ thả Dobby ra… Dobby sẽ phục vụ gia đình cho đến khi Dobby chết, thưa ông…\"",
                                    maxLines: 39,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style:
                                        CustomTextStyles.bodySmallRegular12))),
                        _buildAppBar(context)
                      ])),
                  SizedBox(height: 34.v),
                  CustomImageView(
                      imagePath: ImageConstant.imgMovecomponent4,
                      height: 44.v,
                      width: 299.h,
                      radius: BorderRadius.circular(22.h)),
                  SizedBox(height: 34.v)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 42.v,
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgClose,
            margin: EdgeInsets.only(left: 25.h, top: 18.v, bottom: 9.v),
            onTap: () {
              onTapClose(context);
            }),
        centerTitle: true,
        title: AppbarSubtitleTwo(text: "Once There Were Wolves"));
  }

  /// Navigates back to the previous screen.
  onTapClose(BuildContext context) {
    Navigator.pop(context);
  }
}
