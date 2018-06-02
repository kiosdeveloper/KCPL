import Foundation
import Alamofire

struct ComunicateService {
  
    enum Router: URLRequestConvertible {
        
        static let baseURLString = C_ServerName + "/api/v1/"
//        static var OAuthToken: String?
        case Login(Parameters)
        case SignUp(Parameters)
        case GetCategories()
        case GetProductList(categoryId: Int)
        
        var method: Alamofire.HTTPMethod {
            switch self {
            case .Login( _),
                 .SignUp(_):
                return .post

            case .GetCategories(),
                 .GetProductList(_):
                return .get
            }
        }
        
        var path: String {
            switch self {
                case .Login( _):
                    return "customers/sign_in"
                case .SignUp(_):
                    return "customers"
                case .GetCategories():
                    return "categories"
            case .GetProductList(let categoryId):
                    return "categories/\(categoryId)/products"
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
            
            urlRequest.addValue("q1pros2iytAbQ62s1pkJGAbqR", forHTTPHeaderField: "APP-ID")
//            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            if isAuthToken, let user = UserDefault.getUser(), let token = user.auth_token, let id = user.id {
                 urlRequest.setValue("\(token)", forHTTPHeaderField: "TOKEN")
                urlRequest.setValue("\(id)", forHTTPHeaderField: "USER-ID")

            }
            
//            print("UrlRequest \(urlRequest)")
            
            switch self {
            case .Login(let params):
//                JSONEncoding
                return try Alamofire.URLEncoding.default.encode(urlRequest, with: params)///JSONEncoding if request Parameter in JSON Format
            
            case .SignUp(let params):
                return try Alamofire.URLEncoding.default.encode(urlRequest, with: params)
                
            case .GetCategories():
                return try Alamofire.URLEncoding.default.encode(urlRequest, with: nil)
                
            case .GetProductList(_):
                return try Alamofire.URLEncoding.default.encode(urlRequest, with: nil)
            default:
                return urlRequest
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
