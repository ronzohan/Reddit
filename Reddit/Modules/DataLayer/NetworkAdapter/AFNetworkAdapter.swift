//
//  AFNetworkAdapter.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 12/7/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import Alamofire

class AFNetworkAdapter: NetworkAdapter {
    func execute(request: Request, completionHandler: @escaping (_ response: Response<Data>) -> Void) {
        guard let url = URL(string: request.fullPath) else {
            debugPrint("Invalid url")
            return
        }
        
        let afRequest = Alamofire.request(url, 
                                          method: alamofireHTTPMethod(for: request.endpoint.method), 
                                          parameters: request.bodyParams, 
                                          encoding: URLEncoding.default, 
                                          headers: nil)
        
        afRequest.responseData { (response) in
            switch response.result {
            case .success(let value):
                completionHandler(Response.success(value: value))
            case .failure(let error):
                completionHandler(Response.error(error))
            }
        }
        
        afRequest.resume()
    }
    
    func alamofireHTTPMethod(for method: Reddit.HTTPMethod) -> Alamofire.HTTPMethod {
        switch method {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
}
