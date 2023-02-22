//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-22.
//

import UIKit
import DemoCore
import DemoUI
@testable import HomePageView

enum MockError: Error {
  case error
}

final class MockRepository: HomePageRepository {
  var result: Result<HomePageView.HomePage, Error>!

  func fetchHomePageList() async -> Result<HomePageView.HomePage, Error> {
    result
  }
}

final class MockRouter: HomePageRouter {
  var property: Property?

  func didSelectItem(property: Property) {
    self.property = property
  }
}

struct MockHomePage: HomePage {
  var content: [HomePageContent]
}

struct MockHomePageContent: HomePageContent {
  var area: Area?
  var property: Property?
}

struct MockProperty: Property {
  var id: String
  var contentType: HomePageContentType
  var askingPrice: Double = 5_000_000.0

  var monthlyFee: Double? = 500.0

  var municipality = "Stockholm"

  var area = "Stockholm"

  var daysSincePublish = 3

  var livingArea = 400.0

  var numberOfRooms = 4

  var streetAddress = "Mid Stockholm"

  var imageSource: DemoUI.ImageSource {
    .local(image: UIColor.blue.image())
  }
}

struct MockArea: Area {
  var imageSource: DemoUI.ImageSource {
    .local(image: UIColor.red.image())
  }

  var id: String = UUID().uuidString
  var contentType: HomePageContentType {
    .area
  }
  var area = "Stockholm"
  var ratingFormatted = "4/5"
  var averagePrice = 5_000_000.0
}
