import 'dart:convert';
import 'dart:io';

import 'package:hiring_task/models/login-models/profile/member_profile_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class MemberProfileServices {
  static Future<int> updateProfile({
    File? image,
    String? companyNameEng,
    String? companyNameAr,
    String? mobile,
    String? mobileExtension,
    String? countryName,
    String? countryShortName,
    String? cityName,
    String? stateName,
    String? zip,
    String? address,
    String? address1,
    String? additionalNo,
    String? otherLandline,
    String? district,
    String? website,
    String? numberOfStaff,
    String? buildingNo,
    String? unitNo,
    String? qrCode,
    String? companyId,
    File? addressImage,
    String? userId,
  }) async {
    // print image path to see its formate
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${BaseUrl.gs1}/api/member/profile/update'),
    );

    request.fields['user_id'] = userId ?? '';
    request.fields['company_name_eng'] = companyNameEng ?? '';
    request.fields['company_name_arabic'] = companyNameAr ?? '';
    request.fields['mobile'] = mobile ?? '';
    request.fields['mbl_extension'] = mobileExtension ?? '';
    request.fields['country'] = countryName ?? '';
    request.fields['country_shortName'] = countryShortName ?? '';
    request.fields['city'] = cityName ?? '';
    request.fields['state'] = stateName ?? '';
    request.fields['zip'] = zip ?? '';
    request.fields['address'] = address ?? '';
    request.fields['address1'] = address1 ?? '';
    request.fields['additional_number'] = additionalNo ?? '';
    request.fields['other_landline'] = otherLandline ?? '';
    request.fields['district'] = district ?? '';
    request.fields['website'] = website ?? '';
    request.fields['no_of_staff'] = numberOfStaff ?? '';
    request.fields['building_no'] = buildingNo ?? '';
    request.fields['unit_number'] = unitNo ?? '';
    request.fields['qr_corde'] = qrCode ?? '';
    request.fields['companyID'] = companyId ?? '';

    // Add image file to request
    var imageStream = http.ByteStream(image!.openRead());
    var imageLength = await image.length();
    var imageMultipartFile = http.MultipartFile(
      'image',
      imageStream,
      imageLength,
      filename: image.path,
    );

    print("image multipart file: ${imageMultipartFile.filename}");
    request.files.add(imageMultipartFile);

    var addressImageStream = http.ByteStream(addressImage!.openRead());
    var addressImageLength = await addressImage.length();
    var addressImageMultipartFile = http.MultipartFile(
      'address_image',
      addressImageStream,
      addressImageLength,
      filename: image.path,
    );
    request.files.add(addressImageMultipartFile);

    print('sending....');

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print("Response body: $responseBody");
      if (response.statusCode == 200) {
        print(responseBody);
        return 200;
      } else if (response.statusCode == 422) {
        throw Exception(responseBody);
      } else if (response.statusCode == 500) {
        print(response.statusCode);
        throw Exception('Internal Server Error!');
      } else {
        print(response.statusCode);
        return response.statusCode;
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<MemberProfileModel> getMemberProfile(int userId) async {
    const String url = '${BaseUrl.gs1}/api/member/profile';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'user_id': userId.toString(),
          },
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Host': BaseUrl.host,
        },
      );
      if (response.statusCode == 200) {
        return MemberProfileModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      rethrow;
    }
  }
}
