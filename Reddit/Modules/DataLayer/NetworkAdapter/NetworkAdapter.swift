//
//  NetworkAdapter.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 12/4/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import Alamofire

enum Response<T> {
    case success(value: T)
    case error(Error)
}

protocol NetworkAdapter {
    func execute(request: Request, completionHandler: @escaping (Response<Data>) -> Void)
}
