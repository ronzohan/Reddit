//
//  Service.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 12/7/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import RxSwift

protocol Service {
    var adapter: NetworkAdapter { get }
    
    func responseModel<T: Decodable>(forRequest request: Request) -> Observable<T>
}

extension Service {
    func responseModel<T: Decodable>(forRequest request: Request) -> Observable<T> {
        return Observable.create({ (observer) -> Disposable in
            self.adapter.execute(request: request) { (response) in
                
                switch response {
                case .success(let value):
                    do {
                        let responseData = try JSONDecoder().decode(T.self, from: value)
                        observer.onNext(responseData)
                    } catch let error {
                        debugPrint(error)
                        observer.onError(error)
                    }
                case .error(let error):
                    observer.onError(error)
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        })
    }
}
