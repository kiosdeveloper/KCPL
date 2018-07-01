import Foundation
import Alamofire

struct ComunicateService {
  
    enum Router: URLRequestConvertible {
        
        static let baseURLString = C_ServerName + "/api/v1/"
        static let APP_ID = "q1pros2iytAbQ62s1pkJGAbqR"
//        static var OAuthToken: String?
        case Login(Parameters)
        case SignUp(Parameters)
        case UpdateUser(Parameters)
        case GetCategories()
        case GetProductList(categoryId: Int)
        case CreateOrder(Parameters)
        case GetAddressList()
        case AddAddress(Parameters)
        case UpdateAddress(Parameters, addressId: Int)
        case GetOrderHistory()
        
        var method: Alamofire.HTTPMethod {
            switch self {
            case .Login( _),
                 .SignUp(_),
                 .CreateOrder(_),
                 .AddAddress(_):
                return .post

            case .GetCategories(),
                 .GetProductList(_),
                 .GetAddressList(),
                 .GetOrderHistory():
                return .get
                
            case .UpdateAddress(_, _),
                 .UpdateUser(_):
                return .put
            }
        }
        
        var path: String {
            switch self {
            case .Login( _):
                if Util.isSalesApp() {
                    return "sales/sign_in"
                }
                return "customers/sign_in"
            case .SignUp(_):
                return "customers"
            case .UpdateUser(_):
                return "customers/10"
            case .GetCategories():
                return "categories"
            case .GetProductList(let categoryId):
                return "categories/\(categoryId)/products"
            case .CreateOrder(_),
                 .GetOrderHistory():
                return "orders"
            case .GetAddressList():
                return "user_addresses"
            case .AddAddress(_):
                return "user_addresses"
            case .UpdateAddress(_, let addressId):
                return "user_addresses/\(addressId)"
            }
        }
        
        var isAuthToken: Bool {
            switch self {
            case .Login, .SignUp:
                return false
            default:
                return true
            }
        }

        func asURLRequest() throws -> URLRequest {
            let url = URL(string: Router.baseURLString)!
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            
            urlRequest.addValue(Router.APP_ID, forHTTPHeaderField: "APP-ID")
//            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            if isAuthToken, let user = UserDefault.getUser(), let token = user.auth_token, let id = user.id {
                 urlRequest.setValue("\(token)", forHTTPHeaderField: "TOKEN")
                urlRequest.setValue("\(id)", forHTTPHeaderField: "USER-ID")

            }
            
//            print("UrlRequest \(urlRequest)")
            
            switch self {
            case .Login(let params),
                 .SignUp(let params),
                 .CreateOrder(let params),
                 .AddAddress(let params),
                 .UpdateAddress(let params, _),
                 .UpdateUser(let params):
                return try Alamofire.URLEncoding.default.encode(urlRequest, with: params)///JSONEncoding if request Parameter in JSON Format
                
            case .GetCategories(),
                 .GetProductList(_),
                 .GetAddressList(),
                 .GetOrderHistory():
                return try Alamofire.URLEncoding.default.encode(urlRequest, with: nil)
            }
        }
    }
}


extension Request {
    public func debugLog() -> Self {
        do {
            /*let string = try JSONSerialization.jsonObject(with: (request?.httpBody)!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(string)*/
            debugPrint(self)
        } catch {
            print("error")
        }
        return self
    }
}
