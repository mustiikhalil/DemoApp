//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import DemoCore
import DemoUI
import Foundation

public protocol Area {
  var id: String { get }
  var contentType: HomePageContentType { get }
  var area: String { get }
  var ratingFormatted: String { get }
  var averagePrice: Double { get }
  var imageSource: ImageSource { get }
}

public protocol Property {
  var id: String { get }
  var contentType: HomePageContentType { get }
  var askingPrice: Double { get }
  var monthlyFee: Double? { get }
  var municipality: String { get }
  var area: String { get }
  var daysSincePublish: Int { get }
  var livingArea: Double { get }
  var numberOfRooms: Int { get }
  var streetAddress: String { get }
  var imageSource: ImageSource { get }
}

extension Property {
  var location: String {
    "\(area), \(municipality)"
  }
}
