//
//  Network.swift
//  RAMUtilDemo
//
//  Created by rambo on 2021/1/26.
//  Copyright © 2021 裘俊云. All rights reserved.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()
    
  private(set) lazy var apollo = ApolloClient(url: URL(string: "http://localhost:4000/graphql")!)
}

