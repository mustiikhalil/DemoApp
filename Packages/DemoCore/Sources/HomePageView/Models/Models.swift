//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import Foundation

public protocol Area: Decodable {
  var id: String { get }
  var contentType: HomePageContentType { get }
  var area: String { get }
  var ratingFormatted: String { get }
  var averagePrice: Int { get }
  var image: URL? { get }
}

public protocol Property {
  var id: String { get }
  var contentType: HomePageContentType { get }
  var askingPrice: Int { get }
  var monthlyFee: Int? { get }
  var municipality: String { get }
  var area: String { get }
  var daysSincePublish: Int { get }
  var livingArea: Int { get }
  var numberOfRooms: Int { get }
  var streetAddress: String { get }
  var image: URL? { get }
}
