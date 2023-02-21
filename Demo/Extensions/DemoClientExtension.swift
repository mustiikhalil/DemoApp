//
//  DemoClientExtension.swift
//  Demo
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import HomePageView
import DemoNetworking
import Foundation

extension DemoClient: HomePageRepository {
  public func fetchHomePageList() async -> Result<HomePageView.HomePage, Error> {
    let request = HomePageRequest()
    let response = await performRequest(request: request)
    switch response {
    case .success(let success):
      return .success(success)
    case .failure(let failure):
      return .failure(failure)
    }
  }
}

struct HomePageRequest: Request {
  var request: RequestObject<DemoNetworking.HomePage> {
    RequestObject<DemoNetworking.HomePage>(
      backend: .pasteBin,
      path: ["nH5NinBi"])
  }
}

extension DemoNetworking.HomePage: HomePageView.HomePage {

  public var content: [HomePageView.HomePageContent] {
    items
  }
}

extension DemoNetworking.HomePageContent: HomePageView.HomePageContent {
  public var area: Area? {
    guard case let .area(area) = self else { return nil }
    return area
  }

  public var property: Property? {
    if case let .property(property) = self {
      return property
    }
    if case let .highlightedProperty(property) = self {
      return property
    }
    return nil
  }
}

extension AreaDTO: Area {
  public var contentType: HomePageView.HomePageContentType {
    type.contentType
  }
}

extension PropertyDTO: Property {
  public var contentType: HomePageView.HomePageContentType {
    type.contentType
  }
}

extension DemoNetworking.ContentType {
  var contentType: HomePageView.HomePageContentType {
    switch self {
    case .property: return .property
    case .highlightedProperty: return .highlightedProperty
    case .area: return .area
    }
  }
}
