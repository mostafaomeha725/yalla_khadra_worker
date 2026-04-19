// final charactersOnly = RegExp(r'^[a-zA-Z\u0600-\u06FF]+$'); // Prevent autofill
final charactersOnly = RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$');

bool isValidPhoneNumber(String phone, countryCode) {
  Map<String, String> phoneRegex = {
    "+971": r"^971[2-9][0-9]{7}$",
    "+966": r"^9665[0-9]{8}$",
    "+974": r"^974[3-7][0-9]{7}$",
    "+968": r"^968[79][0-9]{7}$",
    "+965": r"^965[569][0-9]{7}$",
    "+964": r"^964[7][0-9]{9}$",
    "+973": r"^973[3-9][0-9]{7}$",
  };

  return RegExp(phoneRegex[countryCode]!).hasMatch(phone.replaceFirst('+', ''));
}
