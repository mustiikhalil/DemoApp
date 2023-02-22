//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-22.
//

import DemoCore
import UIKit
import DemoUI
@testable import HomePageDetails

enum MockError: Error {
  case error
}

final class MockRepository: HomePageDetailsRepository {
  var result: Result<DetailsPage, Error>!

  func fetchHomeDetails() async -> Result<DetailsPage, Error> {
    result
  }
}

struct MockContent: DetailsPage {
  let id: String
  let contentType: HomePageContentType
  let description: String
  var askingPrice: Double = 5_000_000.0
  var patio: String = "YES"
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
