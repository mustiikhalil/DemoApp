import Foundation

public protocol HomePageRepository {
  func fetchHomePageList() async -> Result<HomePage, Error>
}

public struct HomePage: Decodable {
  var items: [HomePageContent]
}

enum ContentType: String, Decodable, CaseIterable {
  case highlightedProperty = "HighlightedProperty",
       property = "Property",
       area = "Area"
}

public struct Area: Decodable {
  let id: String
  let type: ContentType
  let area: String
  let ratingFormatted: String
  let averagePrice: Int
  let image: URL
}

public struct Property: Decodable {
  let id: String
  let type: ContentType
  let askingPrice: Int
  let monthlyFee: Int?
  let municipality: String
  let area: String
  let daysSincePublish: Int
  let livingArea: Int
  let numberOfRooms: Int
  let streetAddress: String
  let image: URL
}

public enum HomePageContent: Decodable {
  case highlightedProperty(property: Property),
       property(property: Property),
       area(area: Area)

  enum CodingKeys: CodingKey {
    case type
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let key = try container.decode(ContentType.self, forKey: .type)
    switch key {
    case .highlightedProperty:
      let property = try Property(from: decoder)
      self = .highlightedProperty(property: property)
    case .property:
      let property = try Property(from: decoder)
      self = .property(property: property)
    case .area:
      let area = try Area(from: decoder)
      self = .area(area: area)
    }
  }
}
