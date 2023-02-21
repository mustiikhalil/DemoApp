//
//  DemoClientExtension.swift
//  Demo
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import HomePage
import DemoNetworking
import Foundation

extension DemoClient: HomePageRepository {
  public func fetchHomePageList() async -> Result<HomePage, Error> {
    let request = HomePageRequest()
    return await performRequest(request: request)
  }
}

struct HomePageRequest: Request {
  var request: RequestObject<HomePage> {
    RequestObject<HomePage>(
      backend: .pasteBin,
      path: ["nH5NinBi"])
  }
}
