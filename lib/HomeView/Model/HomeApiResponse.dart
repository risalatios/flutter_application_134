import 'package:flutter/material.dart';

class ApiResponse {
  final bool success;
  final String summary;
  final List<Products> dataList;

  ApiResponse({
    required this.success,
    required this.summary,
    required this.dataList,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['data']['success'] ?? false,
      summary: json['data']['summary'] ?? '',
      dataList: (json['data']['data'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}


class HomeDataApiResponse {
  final Data? data;
  final int? status;
  final String? msg;

  HomeDataApiResponse({
    this.data,
    this.status,
    this.msg,
  });

  factory HomeDataApiResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return HomeDataApiResponse(data: null, status: null, msg: null);
    }
    return HomeDataApiResponse(
      data: Data.fromJson(json['data']),
      status: json['status'],
      msg: json['msg'],
    );
  }
}

class Data {
  final bool? success;
  final String? summary;
  final List<Post>? posts;

  Data({
    this.success,
    this.summary,
    this.posts,
  });

  factory Data.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Data(success: null, summary: null, posts: null);
    }
    return Data(
      success: json['success'],
      summary: json['summary'],
      posts: (json['data'] as List<dynamic>?)
          ?.map((postJson) => Post.fromJson(postJson))
          .toList(),
    );
  }
}

class Post {
  final String? title;
  final String? datatype;
  final List<Datum>? data;

  Post({
    this.title,
    this.datatype,
    this.data,
  });

  factory Post.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Post(title: null, datatype: null, data: null);
    }
    return Post(
      title: json['title'],
      datatype: json['datatype'],
      data: (json['data'] as List<dynamic>?)
          ?.map((datumJson) => Datum.fromJson(datumJson))
          .toList(),
    );
  }
}


class Datum {
  final String? title;
  final String? description;
  final String? thumbnail;
  final String? boutiqueName;
  final String? email;
  final String? profilePic;
  final String? coverPic;
  final Address? address;
  final List<Products>? products;

  //banner
  final int? id;
  final String? category;
  final int? categoryId;
  final DateTime? validFrom;
  final DateTime? validTo;
  final DateTime? createdAt;
  final String? bannerUrl;
  final String? bannerType;
  //

  //cat
  final String? imageUrl;

  //product
   final String? itemName;
   final double? itemPrice;
   //
  final String? name;
   

  Datum({
    this.title,
    this.description,
    this.thumbnail,
    this.boutiqueName,
    this.email,
    this.profilePic,
    this.coverPic,
    this.address,
    this.products,
   

    //banner
    this.id,
    this.category,
    this.categoryId,
    this.validFrom,
    this.validTo,
    this.createdAt,
    this.bannerUrl,
    this.bannerType,
    //

    //cat
     this.imageUrl,

    
    //product
    this.itemName,
    this.itemPrice,

    //boutique
    this.name,
  

  });

  factory Datum.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Datum(
        title: null,
        description: null,
        thumbnail: null,
        boutiqueName: null,
        email: null,
        profilePic: null,
        coverPic: null,
        address: null,
        products: null,
       
     

        //banner
        id: null,
        category: null,
        categoryId: null,
        validFrom: null,
        validTo: null,
        createdAt: null,
        bannerUrl: null,
        bannerType: null,

        //cat
       imageUrl: null,
     
       //product
       itemName: null,
       itemPrice: null,

       //boutique
       name: null,

      );
    }
    return Datum(
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      boutiqueName: json['boutique_name'],
      email: json['email'],
      profilePic: json['profile_pic'],
      coverPic: json['cover_pic'],
      address: Address.fromJson(json['address']),
      products: (json['products'] as List<dynamic>?)
          ?.map((productJson) => Products.fromJson(productJson))
          .toList(),

      //banner
      id: json['id'],
      category: json['category'],
      categoryId: json['category_id'],
      validFrom: json['valid_from'] != null ? DateTime.parse(json['valid_from']) : null,
      validTo: json['valid_to'] != null ? DateTime.parse(json['valid_to']) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      bannerUrl: json['banner_url'],
      bannerType: json['banner_type'],

      //cat
      imageUrl: json['image_url'],

       //Product
      itemName: json['item_name'], 
      itemPrice: (json['item_price'] ?? 0.0).toDouble(),

      //boutique
      name: json['name'], 
      //
    );
  }
}

class Address {
  final String? city;
  final String? state;
  final String? line1;
  final String? line2;
  final String? pincode;
  final String? landmark;

  Address({
    this.city,
    this.state,
    this.line1,
    this.line2,
    this.pincode,
    this.landmark,
  });

  factory Address.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Address(city: null, state: null, line1: null, line2: null, pincode: null, landmark: null);
    }
    return Address(
      city: json['city'],
      state: json['state'],
      line1: json['line_1'],
      line2: json['line_2'],
      pincode: json['pincode'],
      landmark: json['landmark'],
    );
  }
}

class Products {
  final String itemName;
  final String? description;
  final String itemMainPic;
  final double itemPrice;
  final String imageUrl;

  Products({
    required this.itemName,
    this.description,
    required this.itemMainPic,
    required this.itemPrice,
    required this.imageUrl,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      itemName: json['item_name'] ?? '',
      description: json['description'],
      itemMainPic: json['item_main_pic'] ?? '',
      itemPrice: (json['item_price'] ?? 0.0).toDouble(),
      imageUrl: json['image_url'] ?? '',
    );
  }
}