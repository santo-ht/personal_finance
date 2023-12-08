import 'package:flutter/widgets.dart';

class UIHelper {
  static const double verticalSpaceExtraSmallVal = 4.0;
  static const double verticalSpaceSmallVal = 8.0;
  static const double verticalSpaceMediumVal = 16.0;
  static const double verticalSpaceLargeVal = 24.0;
  static const double verticalSpaceExtraLargeVal = 48;

  static const double horizontalSpaceExtraSmallVal = 4;
  static const double horizontalSpaceSmallVal = 8.0;
  static const double horizontalSpaceMediumVal = 16.0;
  static const double horizontalSpaceLargeVal = 24.0;
  static const double horizontalSpaceExtraLargeVal = 48.0;

  static SizedBox verticalSpaceExtraSmall() =>
      verticalSpace(verticalSpaceExtraSmallVal);
  static SizedBox verticalSpaceSmall() => verticalSpace(verticalSpaceSmallVal);
  static SizedBox verticalSpaceMedium() =>
      verticalSpace(verticalSpaceMediumVal);
  static SizedBox verticalSpaceLarge() => verticalSpace(verticalSpaceLargeVal);
  static SizedBox verticalSpaceExtraLarge() =>
      verticalSpace(verticalSpaceExtraLargeVal);

  static SizedBox verticalSpace(double height) => SizedBox(height: height);

  static SizedBox horizontalSpaceExtraSmall() =>
      horizontalSpace(horizontalSpaceExtraSmallVal);
  static SizedBox horizontalSpaceSmall() =>
      horizontalSpace(horizontalSpaceSmallVal);
  static SizedBox horizontalSpaceMedium() =>
      horizontalSpace(horizontalSpaceMediumVal);
  static SizedBox horizontalSpaceLarge() =>
      horizontalSpace(horizontalSpaceLargeVal);
  static SizedBox horizontalSpaceExtraLarge() =>
      horizontalSpace(horizontalSpaceExtraLargeVal);

  static SizedBox horizontalSpace(double width) => SizedBox(width: width);
}
