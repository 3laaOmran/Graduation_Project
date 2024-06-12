class SellerDataModel {
  int? status;
  String? message;
  Data? data;


  SellerDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? balance;
  String? rate;
  int? sales;
  String? address;
  String? image;
  Certificates? certificates;
  String? joinedFrom;
  String? verifiedFrom;
  // Products? products;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    balance = json['balance'];
    rate = json['rate'];
    sales = json['sales'];
    address = json['address'];
    image = json['image'];
    certificates = json['certificates'] != null
        ? Certificates.fromJson(json['certificates'])
        : null;
    joinedFrom = json['joined_from'];
    verifiedFrom = json['verified_from'];
    // products = json['products'] != null
    //     ? Products.fromJson(json['products'])
    //     : null;
  }
}

class Certificates {
  String? healthApprovalCertificate;
  String? commercialResturantLicense;


  Certificates.fromJson(Map<String, dynamic> json) {
    healthApprovalCertificate = json['health_approval_certificate'];
    commercialResturantLicense = json['commercial_resturant_license'];
  }
}

// class Products {
//   int? count;
//   List<ProductData>? data;

//   Products.fromJson(Map<String, dynamic> json) {
//     count = json['count'];
//     if (json['data'] != null) {
//       data = <ProductData>[];
//       json['data'].forEach((v) {
//         data!.add(ProductData.fromJson(v));
//       });
//     }
//   }
// }

// class ProductData {
//   int? id;
//   String? name;
//   double? price;
//   String? discount;
//   String? netPrice;
//   List<String>? images;


//   ProductData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     price = json['price'];
//     discount = json['discount'];
//     netPrice = json['net_price'];
//     images = json['images'].cast<String>();
//   }
// }