import UIKit
import Alamofire
import SwiftyJSON

class ServiceManager {

    func processService(urlRequest: ComunicateService.Router, completion: @escaping (_ success: Bool, _ errorMessages: String?, _ responseData: JSON?)-> Void) {
        
        Util.showProgress()
        
        do {
            try Alamofire.request(urlRequest.asURLRequest()).responseJSON(options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableContainers])
            {
                (response) -> Void in
                
                switch response.result
                {
                case .success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        
                        print(json)
                        if (json.dictionaryObject![Constant.c_res_status] as? Int)! == 200 {
                            Util.dissmissProgress()
                            
//                            UserDefault.saveUser(user: User(json: json))
                            completion(true, nil, json[Constant.c_res_data])
                            
                        } else {
                            Util.dissmissProgress()
                            completion(false, (json.dictionaryObject![Constant.c_res_message])! as? String, nil)
                        }
                    }
                case .failure(let error):
//                    print(error)
                    Util.dissmissProgress()
                    completion(false, error.localizedDescription, nil)
                }
            }
        } catch let error{
//            print(error)
            Util.dissmissProgress()
            completion(false, error.localizedDescription, nil)
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
    
//    //    MARK:- UserUpdate
//    func processUserUpdate(json: JSON?, completion: @escaping (_ isComplete: Bool)-> Void) {
//        if let response_json = json {
//            UserDefault.saveUser(user: User(json: response_json))
//            completion(true)
//        }
//        completion(false)
//    }
//
//    //    MARK:- Categories
//    func processCategories(json: JSON?, completion: @escaping (_ isComplete: Bool, _ categories: [Category]? )-> Void) {
//        if let response_json = json {
//
//            var category_arr = [Category]()
//
//            for i in 0 ..< response_json.count {
//                let jsonValue = response_json.arrayValue[i]
//                let cData = Category(json: jsonValue)
//                category_arr.append(cData)
//            }
//
//            completion(true, category_arr)
//        }
//        completion(false, nil)
//    }

}
