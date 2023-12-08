class StringUtils {
  static String getAgoraUid(String uid) {
    return uid.replaceFirst("-", '');
  }
}