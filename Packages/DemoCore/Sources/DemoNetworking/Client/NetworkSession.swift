//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import Foundation

public protocol NetworkSession {
  func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {}
