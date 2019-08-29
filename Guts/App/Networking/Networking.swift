import Foundation
import Moya
import RxSwift
import Alamofire

class OnlineProvider<Target> where Target: Moya.TargetType {

    fileprivate let online: Observable<Bool>
    fileprivate let provider: MoyaProvider<Target>

    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
        requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
        stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
        manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
        plugins: [PluginType] = [],
        trackInflights: Bool = false,
        online: Observable<Bool> = connectedToInternetOrStubbing())
    {

        self.online = online
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }

    func request(_ token: Target) -> Observable<Moya.Response> {
        let actualRequest = provider.rx.request(token)
        return online
            .ignore(value: false)  // Wait until we're online
            .take(1)        // Take 1 to make sure we only invoke the API once.
            .flatMap { _ in // Turn the online state into a network request
                return actualRequest
            }

    }
}

protocol NetworkingType {
    associatedtype T: TargetType
    var provider: OnlineProvider<T> { get }
}

struct Networking: NetworkingType {
    typealias T = GutsAPI
    let provider: OnlineProvider<GutsAPI>
}


private extension Networking {

}

// "Public" interfaces
extension Networking {
    /// Request to fetch a given target. Ensures that valid XApp tokens exist before making request
    func request(_ token: GutsAPI, defaults: UserDefaults = UserDefaults.standard) -> Observable<Moya.Response> {
        let  w = self.provider.request(token)
        return w
    }
}

// Static methods
extension NetworkingType {

    static func newDefaultNetworking() -> Networking {
        return Networking(provider: newProvider(plugins))
    }

    static func newStubbingNetworking() -> Networking {
        return Networking(provider: OnlineProvider(endpointClosure: endpointsClosure(), requestClosure: Networking.endpointResolver(), stubClosure: MoyaProvider.immediatelyStub, online: .just(true)))
    }

    static func endpointsClosure<T>(_ xAccessToken: String? = nil) -> (T) -> Endpoint where T: TargetType, T: GutsAPIType {
        return { target in
            var endpoint: Endpoint = Endpoint(url: url(target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: nil)

            // If we were given an xAccessToken, add it
            if let xAccessToken = xAccessToken {
                endpoint = endpoint.adding(newHTTPHeaderFields: ["X-Access-Token": xAccessToken])
            }

            // Sign all non-XApp, non-XAuth token requests
            if target.addXAuth {
                return endpoint.adding(newHTTPHeaderFields:["X-Xapp-Token": ""])
            } else {
                return endpoint
            }
        }
    }
    
    static func APIKeysBasedStubBehaviour<T>(_: T) -> Moya.StubBehavior {
        return APIKeys.sharedKeys.stubResponses ? .immediate : .never
    }

    static var plugins: [PluginType] {
        return [
            NetworkLogger(blacklist: { target -> Bool in
                guard let target = target as? GutsAPI else { return false }

                switch target {
                
                default: return false
                }
            })
        ]
    }
    static var authenticatedPlugins: [PluginType] {
        return [NetworkLogger(whitelist: { target -> Bool in
            guard let target = target as? GutsAuthenticatedAPI else { return false }

            switch target {
            case .myBidPosition: return true
            case .findMyBidderRegistration: return true
            default: return false
            }
        })
        ]
    }

    // (Endpoint, NSURLRequest -> Void) -> Void
    static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest()
                request.httpShouldHandleCookies = false
                closure(.success(request))
            } catch let error {
                closure(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }
}

private func newProvider<T>(_ plugins: [PluginType], xAccessToken: String? = nil) -> OnlineProvider<T> where T: GutsAPIType {
    return OnlineProvider(endpointClosure: Networking.endpointsClosure(xAccessToken),
        requestClosure: Networking.endpointResolver(),
        stubClosure: Networking.APIKeysBasedStubBehaviour,
        plugins: plugins)
}
