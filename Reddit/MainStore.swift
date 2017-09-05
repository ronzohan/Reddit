//
//  MainStore.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/26/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import ReSwift

var store = Store<AppState>(reducer: AppReducer.appReducer, state: nil)
