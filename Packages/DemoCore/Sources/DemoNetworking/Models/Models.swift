//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import Foundation

public struct HomePage: Decodable {
  public var items: [HomePageContent]
}

public enum ContentType: String, Decodable {
  case highlightedProperty = "HighlightedProperty",
       property = "Property",
       area = "Area"
}

// These would be presented as Graphql objects
public struct PropertyDTO: Decodable {
  public let id: String
  public let type: ContentType
  public let askingPrice: Int
  public let monthlyFee: Int?
  public let municipality: String
  public let area: String
  public let daysSincePublish: Int
  public let livingArea: Int
  public let numberOfRooms: Int
  public let streetAddress: String
  public let image: URL?
}

public struct AreaDTO: Decodable {
  public let id: String
  public let type: ContentType
  public let area: String
  public let ratingFormatted: String
  public let averagePrice: Int
  public let image: URL?
}

public enum HomePageContent: Decodable {
  case highlightedProperty(property: PropertyDTO),
       property(property: PropertyDTO),
       area(area: AreaDTO)

  enum CodingKeys: CodingKey {
    case type
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let key = try container.decode(ContentType.self, forKey: .type)
    switch key {
    case .highlightedProperty:
      let property = try PropertyDTO(from: decoder)
      self = .highlightedProperty(property: property)
    case .property:
      let property = try PropertyDTO(from: decoder)
      self = .property(property: property)
    case .area:
      let area = try AreaDTO(from: decoder)
      self = .area(area: area)
    }
  }
}
