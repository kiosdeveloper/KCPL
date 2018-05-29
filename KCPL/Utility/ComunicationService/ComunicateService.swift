import Foundation
import Alamofire

struct ComunicateService {
  
    enum Router: URLRequestConvertible {
        
        static let baseURLString = C_ServerName + "/api/v1/"
//        static var OAuthToken: String?
        case Login(Parameters)
        case SignUp(Parameters)
        
        var method: Alamofire.HTTPMethod {
            switch self {
                case .Login( _):
                    return .post
                case .SignUp(_):
                    return .post
            }
        }
        
        var path: String {
            switch self {
                case .Login( _):
                    return "customers/sign_in"
                case .SignUp(_):
                    return "customers"
            }
        }

        func asURLRequest() throws -> URLRequest {
            let url = URL(string: Router.baseURLString)!
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            
            urlRequest.addValue("q1pros2iytAbQ62s1pkJGAbqR", forHTTPHeaderField: "APP-ID")
//            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
//            if let token = Router.OAuthToken {
//                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//            }
            
            switch self {
            case .Login(let params):
//                JSONEncoding
                return try Alamofire.URLEncoding.default.encode(urlRequest, with: params)///JSONEncoding if request Parameter in JSON Format
            
            case .SignUp(let params):
                return try Alamofire.URLEncoding.default.encode(urlRequest, with: params)
                
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
