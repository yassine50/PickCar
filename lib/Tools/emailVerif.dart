class EmailVerif {
 static  bool isEmail(String input) {
  // Regular expression pattern for matching an email address
  RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  // Check if the input string matches the email pattern
  return emailRegex.hasMatch(input);
}
}