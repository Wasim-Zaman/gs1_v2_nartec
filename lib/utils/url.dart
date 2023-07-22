class URL {
  static String baseUrl = 'https://gtrack.info/api/search/member/gtin';
  static String digitalLink =
      'https://gtrack.info/api/search/member/gtin/digital/link';
  static String latLong = "https://gtrack.info/api/member/events";
  static String singleEvent = 'https://gtrack.info/api/member/single/events';
}

abstract class BaseUrl {
  // The server is changed to the production server
  static const String gs1 = 'https://gs1ksa.org';
  // static const String gs1 = 'https://gs1.org.sa';

  // static const String gs1WithPort = 'http://gs1ksa.org:7000';
  static const String gs1WithPort = 'https://gs1.org.sa:7000';

  static const String host = 'gs1ksa.org';
  // static const String host = 'gs1.org.sa';

  static const String hostWithPort = 'gs1ksa.org:7000';
  // static const String hostWithPort = 'gs1.org.sa:7000';
}
