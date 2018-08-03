import UIKit
import Alamofire
import SwiftyJSON

class ServiceManager {

    func processService(urlRequest: ComunicateService.Router, completion: @escaping (_ success: Bool, _ errorMessages: String?, _ responseData: JSON?)-> Void) {
        
        Util.showProgress()
        
        do {
            try Alamofire.request(urlRequest.asURLRequest()).debugLog().responseJSON(options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableContainers])
            {
                (response) -> Void in
                
                switch response.result
                {
                case .success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        
                        print(json)
                        if (json.dictionaryObject![Constant.c_res_type] as? String)! != "Error" {
                            Util.dissmissProgress()
                            
//                            UserDefault.saveUser(user: User(json: json))
                            completion(true, nil, json[Constant.c_res_data])
                            
                        } else {
                            Util.dissmissProgress()
                            if let error = (json.dictionaryObject![Constant.c_res_message])! as? [String] {
                                completion(false, error[0], nil)
                            }
                            else {
                                completion(false, "Something went wrong", nil)
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                    Util.dissmissProgress()
                    completion(false, nil, nil)
                }
            }
        } catch let error{
            print(error)
            Util.dissmissProgress()
            completion(false, nil, nil)
        }
    }
    
}// End ServiceManager

class ServiceManagerModel {
    //    MARK:- Login
    func processLogin(json: JSON?, completion: @escaping (_ isComplete: Bool)-> Void) {
        if let response_json = json {
            UserDefault.saveUser(user: User(json: response_json))
            completion(true)
        }
        completion(false)
    }

    //    MARK:- Categories
    func processCategories(json: JSON?, completion: @escaping (_ isComplete: Bool, _ categories: [Category]? )-> Void) {
        if let response_json = json {

            var category_arr = [Category]()

            for i in 0 ..< response_json.count {
                let jsonValue = response_json.arrayValue[i]
                let cData = Category(json: jsonValue)
                category_arr.append(cData)
            }

            completion(true, category_arr)
        }
        completion(false, nil)
    }
    
    //    MARK:- Products
    func processProducts(json: JSON?, completion: @escaping (_ isComplete: Bool, _ products: [Product]? )-> Void) {
        if let response_json = json {
            
            var product_arr = [Product]()
            
            for i in 0 ..< response_json.count {
                let jsonValue = response_json.arrayValue[i]
                let pData = Product(json: jsonValue)
                product_arr.append(pData)
            }
            
            completion(true, product_arr)
        }
        completion(false, nil)
    }
    
    //    MARK:- Address
    func processAddressList(json: JSON?, completion: @escaping (_ isComplete: Bool, _ products: [Address]? )-> Void) {
        if let response_json = json {
            
            var address_arr = [Address]()
            
            for i in 0 ..< response_json.count {
                let jsonValue = response_json.arrayValue[i]
                let aData = Address(json: jsonValue)
                address_arr.append(aData)
            }
            
            completion(true, address_arr)
        }
        completion(false, nil)
    }

    //    MARK:- Address
    func processOrderList(json: JSON?, completion: @escaping (_ isComplete: Bool, _ products: [Order]? )-> Void) {
        if let response_json = json {
            
            var address_arr = [Order]()
            
            for i in 0 ..< response_json.count {
                let jsonValue = response_json.arrayValue[i]
                let aData = Order(json: jsonValue)
                address_arr.append(aData)
            }
            
            completion(true, address_arr)
        }
        completion(false, nil)
    }
    
    //    MARK:- Customer
    func processCustomers(json: JSON?, completion: @escaping (_ isComplete: Bool, _ customers: [Customers]? )-> Void) {
        if let response_json = json {
            
            var order_arr = [Customers]()
            
            for i in 0 ..< response_json.count {
                let jsonValue = response_json.arrayValue[i]
                let aData = Customers(json: jsonValue)
                order_arr.append(aData)
            }
            
            completion(true, order_arr)
        }
        completion(false, nil)
    }
    
    //    MARK:- Vendor
    func processVendors(json: JSON?, completion: @escaping (_ isComplete: Bool, _ vendors: [Vendor]? )-> Void) {
        if let response_json = json {
            
            var vendor_arr = [Vendor]()
            
            for i in 0 ..< response_json.count {
                let jsonValue = response_json.arrayValue[i]
                let aData = Vendor(json: jsonValue)
                vendor_arr.append(aData)
            }
            
            completion(true, vendor_arr)
        }
        completion(false, nil)
    }
    
    // MARK:- Quatation
    func processQuatation(json: JSON?, completion: @escaping (_ isComplete: Bool, _ customers: [Quatations]? )-> Void) {
        if let response_json = json {
            
            var order_arr = [Quatations]()
            
            for i in 0 ..< response_json.count {
                let jsonValue = response_json.arrayValue[i]
                let aData = Quatations(json: jsonValue)
                order_arr.append(aData)
            }
            
            completion(true, order_arr)
        }
        completion(false, nil)
    }
    
}
