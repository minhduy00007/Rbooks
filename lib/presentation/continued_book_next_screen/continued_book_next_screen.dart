import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_subtitle_five.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';

class ContinuedBookNextScreen extends StatelessWidget {
  const ContinuedBookNextScreen({Key? key}) : super(key: key);

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
                      width: 326.h,
                      child: Text(
                          "\"Ron,\" thì thầm Harry, rón rén tiến đến cửa sổ và đẩy nó lên để họ có thể nói chuyện qua thanh sắt. \"Ron, làm sao mà bạn đã—? Cái gì đang—?\"\n\nBất ngờ đến nỗi miệng Harry ngả ra khi tác động đầy đủ của những gì anh thấy ấn tượng anh. Ron đang ngả ra ngoài cửa sổ sau của một chiếc ô tô màu ngọc lam cũ, đang đậu giữa không trung. Cười vui vẻ với Harry từ ghế trước là Fred và George, hai anh em sinh đôi lớn tuổi hơn của Ron.\n\n\"Khỏe không, Harry?\" George hỏi.\n\n\"Đã có chuyện gì vậy?\" Ron nói. \"Tại sao mà cậu không trả lời thư của tôi? Tôi đã mời cậu ở khoảng mười hai lần, sau đó bố về nhà và nói rằng cậu bị cảnh cáo chính thức vì sử dụng ma thuật trước muggle—\"\n\n\"Không phải là tôi—và làm sao ông ấy biết?\"\n\n\"Ông ấy làm việc cho Bộ, \"Ron nói. \"Cậu biết rằng chúng ta không được phép thực hiện phép thuật ngoài trường—\"\n\n\"Cậu nên nói,\" Harry nói, nhìn vào chiếc ô tô đang bay.\n\n\"Ồ, điều này không tính,\" Ron nói. \"Chúng ta chỉ mượn cái này. Đó là của Ba, chúng tôi không phù phép nó. Nhưng thực hiện phép thuật trước những muggle cậu sống cùng—\"\n\n\"Tôi đã nói rồi, tôi không làm—nhưng giờ mà giải thích sẽ mất quá lâu—nhìn này, cậu có thể nói cho họ ở Hogwarts biết rằng gia đình Dursley đã giam tôi lại và không cho tôi quay về, và rõ ràng tôi không thể phù phép bản thân ra, vì Bộ sẽ nghĩ đó là phép thuật thứ hai trong ba ngày, nên—\"\n\n\"Dừng việc nói nhảm,\" Ron nói. \"Chúng tôi đã đến đón cậu về nhà với chúng tôi.\"\n\n\"Nhưng cậu cũng không thể phù phép tôi ra—\"\n\n\"Chúng tôi không cần phải,\" Ron nói, lắc đầu về ghế trước và cười. \"Cậu quên rằng tôi có ai đi cùng.\"\n\n\"Buộc nó xung quanh thanh sắt,\" Fred nói, ném đầu dây cho Harry.\n\n\"Nếu gia đình Dursley thức dậy, tôi sẽ chết,\" Harry nói khi buộc chặt dây quanh một thanh sắt và Fred bắt đầu xe.\n\n\"Đừng lo,\" Fred nói, \"và lùi lại.\"\n\nHarry rút vào bóng tối bên cạnh Hedwig, người dường như đã nhận ra tầm quan trọng của việc này và giữ im lặng. Xe càng vang lên càng lớn và đột nhiên, với tiếng kêu rắc rối, thanh sắt bị kéo sạch ra khỏi cửa sổ khi Fred lái thẳng lên không trung. Harry chạy trở lại cửa sổ để thấy thanh sắt treo lơ lửng vài bước trên mặt đất. Thở hổn hển, Ron kéo chúng lên vào xe. Harry lắng nghe lo lắng, nhưng không có âm thanh nào từ phòng ngủ của Dursleys.\nKhi thanh sắt đã an toàn trong ghế sau cùng với Ron, Fred đậu xe ngược lại gần cửa sổ của Harry.\n\"Vào đi,\" Ron nói.\n\"Nhưng tất cả đồ của Hogwarts—cây đũa—chổi của tôi—\"\n\"Chúng ở đâu?\"\n\"Bị khóa trong tủ dưới cầu thang, và tôi không thể ra khỏi phòng này—\"\n\"Không vấn đề,\" George nói từ ghế trước bên phải. \"Ra khỏi đường, Harry.\"\nFred và George leo như mèo qua cửa sổ vào phòng của Harry. Bạn phải công nhận điều đó, nghĩ Harry, khi George lấy một chiếc ghim tóc bình thường từ túi của anh và bắt đầu mở khóa.\n\"Rất nhiều phù thủy nghĩ rằng đó là lãng phí thời gian, biết các thủ thuật của muggle loại này,\" Fred nói, \"nhưng chúng tôi cảm thấy đó là kỹ năng đáng học, dù chúng có hơi chậm.\"\nCó một tiếng kêu nhỏ và cửa mở ra.\n\"Vậy—chúng tôi sẽ lấy chiếc hòm của cậu—cậu lấy bất cứ thứ gì cần thiết từ phòng cậu và đưa cho Ron,\" George thì thầm.\n\"Chú ý bậc cầu thang cuối—nó kêu cọng cọng,\" Harry thì thầm lại khi hai anh em biến mất ra lan can tối.\nHarry vội vã xung quanh phòng, thu thập đồ đạc của mình và đưa chúng qua cửa sổ cho Ron. Sau đó, anh đi giúp Fred và George kéo chiếc hòm lên cầu thang. Harry nghe thấy dấu ho của Chú Vernon.\nCuối cùng, hết hơi, họ đến tầng, rồi đưa hòm qua phòng của Harry đến cửa sổ mở. Fred leo trở lại trong xe để kéo với Ron, và Harry cùng George đẩy từ phòng ngủ. Từng chút một, chiếc hòm trượt qua cửa sổ.\nChú Vernon ho ho lại.\n\"Thêm một chút nữa,\" Fred thở hổn hển, đang kéo từ trong xe. \"Một đợt đẩy mạnh—\"\nHarry và George đẩy vai vào hòm và nó trượt ra khỏi cửa sổ vào ghế sau của xe.\n\"Được rồi, chúng ta đi,\" George thì thầm.\nNhưng khi Harry leo lên mép cửa sổ, có một tiếng kêu to đột ngột từ phía sau anh, ngay sau đó là tiếng gầm gừ của Chú Vernon.\n\"CHÚ VẸT ẤY!\"\n\"Tôi quên Hedwig!\"\nHarry chạy lại phòng khi đèn trên lan can sáng lên—anh nhặt lồng Hedwig, lao đến cửa sổ và đưa nó ra ngoài cho Ron. Anh đang leo trở lại trên ngăn tủ khi Chú Vernon đập cửa chưa khoá và nó vỡ tung.\nTrong một khoảnh khắc, Chú Vernon đứng như khung cửa; rồi hắn phát ra một tiếng gầm giận dữ như bò và lao vào Harry, nắm chặt chân anh.\nRon, Fred và George nắm lấy tay Harry và kéo mạnh nhất có thể.\n\"Petunia!\" Chú Vernon hống hách. \"Hắn đang chạy trốn! HẮN ĐANG CHẠY TRỐN!\"\nNhưng gia đình Weasley giơ cao cả tay kéo và chân Harry trượt ra khỏi tay Chú Vernon—Harry đã vào xe—anh đã đóng cửa sổ lại—\n\"Đạp ga mạnh lên, Fred!\" Ron hét lên, và chiếc xe đột ngột lao về phía mặt trăng.\nHarry không thể tin được—anh được tự do. Anh hạ cửa sổ, bầu không khí đêm thổi qua tóc, và nhìn lại những mái nhà nhỏ dần thu nhỏ của Privet Drive. Chú Vernon, Cô Petunia và Dursley đều đứng, ngớ ngẩn, ngoài cửa sổ của Harry.\n\"Hẹn gặp lại mùa hè tới!\" Harry la lên.",
                          maxLines: 35,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: CustomTextStyles.bodySmallRegular12)),
                  SizedBox(height: 33.v),
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
        height: 42.v,
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgClose,
            margin: EdgeInsets.only(left: 25.h, top: 18.v, bottom: 9.v),
            onTap: () {
              onTapClose(context);
            }),
        centerTitle: true,
        title: AppbarSubtitleFive(text: "Harry Potter - Chamber of Secrets"),
        styleType: Style.bgFill);
  }

  /// Navigates back to the previous screen.
  onTapClose(BuildContext context) {
    Navigator.pop(context);
  }
}
