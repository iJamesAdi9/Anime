//
//  HttpClient.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 3/3/2566 BE.
//

import Foundation
import Alamofire

final class HttpClient {
    func request<T: Decodable>(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, of type: T.Type = T.self, interceptor: RequestInterceptor? = nil, completionHandler: @escaping(DataResponse<T, AFError>) -> ()) {
        
        print("-------------------------------- NETWORK Reqeust LOG---------------------------------------")
        print("request[\(method.rawValue)]: \(url)")
        print("headers: \(String(describing: headers))")
        print("parameters: \(String(describing: parameters ?? [:]))")
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers, interceptor: interceptor)
            .validate()
            .responseDecodable(of: T.self, emptyResponseCodes: [200, 201]) { (response) in
                completionHandler(response)
            }
            .responseString { (response) in
                print("-----------------------------------NETWORK Response LOG------------------------------------")
                print("response.request: \(String(describing: response.request))")  // original URL request
                    //print("response.result.value: \(String(describing: response.result))")   // result of response serialization
                print("response.data: \(response.data?.toPrettyPrinted ?? "")")
            }
    }
}
