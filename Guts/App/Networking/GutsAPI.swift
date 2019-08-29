import Foundation
import RxSwift
import Moya
import Alamofire
import CoreTelephony



protocol GutsAPIType {
    var addXAuth: Bool { get }
}

enum GutsAPI {
    //
    case sendSMS(area_code: String, phone: String, user_agent: String)
}

enum GutsAuthenticatedAPI {
    case myCreditCards
    case createPINForBidder(bidderID: String)
    case registerToBid(auctionID: String)
    case myBiddersForAuction(auctionID: String)
    case myBidPositionsForAuctionArtwork(auctionID: String, artworkID: String)
    case myBidPosition(id: String)
    case findMyBidderRegistration(auctionID: String)
    case placeABid(auctionID: String, artworkID: String, maxBidCents: String)

    case updateMe(email: String, phone: String, postCode: String, name: String)
    case registerCard(stripeToken: String, swiped: Bool)
    case me
}

extension GutsAPI : TargetType, GutsAPIType {
    var headers: [String : String]? {
        var defaultUserAgent = ""
        let telephony = CTTelephonyNetworkInfo()
        if let provider = telephony.serviceSubscriberCellularProviders?.values.first {
            let mcc = provider.mobileCountryCode ?? ""
            let mnc = provider.mobileNetworkCode ?? ""
            let model = ""
            var version = ""
            if let infoDic = Bundle.main.infoDictionary {
                version = infoDic["CFBundleShortVersionString"] as! String
            }
            let screenWidth = UIScreen.main.bounds.size.width * UIScreen.main.scale
            let screenHeight = UIScreen.main.bounds.size.height * UIScreen.main.scale
            
            let device = UIDevice.current
            defaultUserAgent = NSString.localizedStringWithFormat("iOS/%@ CiOS/141002 Encoding/UTF-8 Locale/%@ Lang/%@ Morange/3.2 Caps/127 PI/%@ Domain/loops DeviceBrand/Apple DeviceModel/%@ DeviceVersion/%@ ClientType/CiOS ClientBuild/%@ ScreenWidth/%@ ScreenHeight/%@ Mcc/%@ Mnc/%@", device.systemVersion, Locale.current.identifier, Locale.preferredLanguages.first ?? "", "", model, device.systemVersion, version, screenWidth,screenHeight, mcc, mnc) as String
        }
        
        let defaultHeaders = ["Accept": "*/*","Content-Type":"application/json"]
        return defaultHeaders
    }

    var task: Task {
        let encoding: ParameterEncoding
        switch self.method {
        case .post:
            encoding = JSONEncoding.default
        default:
            encoding = URLEncoding.default
        }
        if let requestParameters = parameters {
            return .requestParameters(parameters: requestParameters, encoding: encoding)
        }
        return .requestPlain
    }

    var path: String {
        switch self {
            
        case .sendSMS:
            return "/login/mock-login"
        }
    }

    var base: String { return "http://10.40.16.20:8000" }
    var baseURL: URL { return URL(string: base)! }

    var parameters: [String: Any]? {
        switch self {
        case .sendSMS(let area, let phone, let agent):
            return ["area_code": "dsfsd","phone": "sdfsdf", "code": "sdfdsf"]
        }
    }

    var method: Moya.Method {
        switch self {
        case .sendSMS:
            return .post
        }
    }

    var sampleData: Data {
        switch self {
        case .sendSMS:
            return stubbedResponse("Ping")
        
        default:
            return Data.init()
        }
    }

    var addXAuth: Bool {
        switch self {
        default: return true
        }
    }
}

// MARK: - Provider support

func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
