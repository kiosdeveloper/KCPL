import Foundation
import Alamofire

struct ComunicateService {
  
    enum Router: URLRequestConvertible {
        
//        static let baseURLString = !Util.isSalesApp() ? C_ServerName + "/api/v1/" : C_ServerName + "/api/sale/v1/"
        
        #if SALES
            static let baseURLString = C_ServerName + "/api/sale/v1/"
        #elseif ADMIN
            static let baseURLString = C_ServerName + "/api/admin/v1/"
        #else
            static let baseURLString = C_ServerName + "/api/v1/"
        #endif
        
        
        static let APP_ID = "q1pros2iytAbQ62s1pkJGAbqR"
//        static var OAuthToken: String?
        case Login(Parameters)
        case SignUp(Parameters)
        case UpdateUser(Parameters)
        case GetCategories()
        case GetProductList(categoryId: Int)
        case GetInventorySales()
        case CreateOrder(Parameters)
        case GetAddressList(userId: Int)
        case AddAddress(Parameters, userId: Int)
        case UpdateAddress(Parameters, addressId: Int)
        case GetOrderHistory()
        case CreatePurchaseOrder(Parameters)
        case GetPurchaseHistory()
        case GetCustomerList()
        case GetVendorList()
        case AddCustomer(Parameters)
        case AddVendor(Parameters)
        case GetProductList_Admin()
        case GetQuatationList()
        case AcceptQuatation(Parameters)
        case RejectQuatation(Parameters)
        
        
        var method: Alamofire.HTTPMethod {
            switch self {
            case .Login( _),
                 .SignUp(_),
                 .CreateOrder(_),
                 .CreatePurchaseOrder(_),
                 .AddAddress(_, _),
                 .AddCustomer(_),
                 .AddVendor(_),
                 .AcceptQuatation(_),
                 .RejectQuatation(_):
                return .post

            case .GetCategories(),
                 .GetProductList(_),
                 .GetInventorySales(),
                 .GetAddressList,
                 .GetOrderHistory(),
                 .GetPurchaseHistory(),
                 .GetCustomerList(),
                 .GetVendorList(),
                 .GetProductList_Admin(),
                 .GetQuatationList():
                return .get
                
            case .UpdateAddress(_, _),
                 .UpdateUser(_):
                return .put
            }
        }
        
        var path: String {
            switch self {
            case .Login( _):
                if Util.isSalesApp() || Util.isAdminApp() {
                    return "users/sign_in"
                } else {
                    return "customers/sign_in"
                }
            case .SignUp(_):
                return "customers"
            case .UpdateUser(_):
                if Util.isSalesApp(), let user = UserDefault.getUser(), let id = user.id {
                    return "users/\(id)"
                }
                else {
                    if let user = UserDefault.getUser(), let id = user.id {
                        return "customers/\(id)"
                    }
                    return "customers/\(10)"
                }
            case .GetCategories():
                return "categories"
            case .GetProductList(let categoryId):
                return "categories/\(categoryId)/products"
            case .GetInventorySales():
                return "products/inventory"
            case .CreateOrder(_),
                 .GetOrderHistory():
                return "orders"
            case .CreatePurchaseOrder(_),
                 .GetPurchaseHistory():
                return "purchases"
            case .GetAddressList(let userId):
                if Util.isSalesApp() || Util.isAdminApp() {
                    return "user_addresses/\(userId)"
                }
                return "user_addresses"
            case .AddAddress(_, let userId):
                if Util.isSalesApp() || Util.isAdminApp() {
//                    if let user = UserDefault.getUser(), let id = user.id {
                        return "user_addresses/\(userId)"
//                    }
                }
                return "user_addresses"
            case .UpdateAddress(_, let addressId):
                return "user_addresses/\(addressId)"
            case .GetCustomerList(),
                 .AddCustomer(_):
                return "customers"
            case .GetVendorList(),
                 .AddVendor(_):
                return "vendors"
            case .GetProductList_Admin():
                return "products"
            case .GetQuatationList():
                return "quotations"
            case .AcceptQuatation(_):
                return "quotations/accept"
            case .RejectQuatation(_):
                return "quotations/reject"
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
                 .CreatePurchaseOrder(let params),
                 .AddAddress(let params, _),
                 .UpdateAddress(let params, _),
                 .UpdateUser(let params),
                 .AddCustomer(let params),
                 .AddVendor(let params),
                 .AcceptQuatation(let params),
                 .RejectQuatation(let params):
                return try Alamofire.URLEncoding.default.encode(urlRequest, with: params)///JSONEncoding if request Parameter in JSON Format
                
            case .GetCategories(),
                 .GetProductList(_),
                 .GetInventorySales(),
                 .GetAddressList,
                 .GetOrderHistory(),
                 .GetPurchaseHistory(),
                 .GetCustomerList(),
                 .GetVendorList(),
                 .GetProductList_Admin(),
                 .GetQuatationList():
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
