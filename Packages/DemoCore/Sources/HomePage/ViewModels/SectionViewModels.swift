import DemoUI
import Foundation

protocol SectionViewModel: Hashable {
  var sectionType: String { get }
  var viewModels: [AnyHashable] { get }
}

extension HomePageContent {
  func toViewModel() -> any SectionViewModel {
    switch self {
    case .highlightedProperty(let property), .property(let property):
      return PropertySectionViewModel(property: property)
    case .area(let area):
      return AreaSectionViewModel(area: area)
    }
  }
}

struct PropertySectionViewModel: SectionViewModel {

  var sectionType: String {
    "\(property.id)_\(property.type)"
  }

  var viewModels: [AnyHashable] {
    [
      property.image,
      property.streetAddress,
      property.municipality
    ]
  }

  static func == (lhs: PropertySectionViewModel, rhs: PropertySectionViewModel) -> Bool {
    return lhs.property.id == rhs.property.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(property.id)
  }

  let property: Property
}

struct AreaSectionViewModel: SectionViewModel {

  var sectionType: String {
    "\(area.id)_\(area.type)"
  }

  var viewModels: [AnyHashable] {
    [
      area.ratingFormatted
    ]
  }

  static func == (lhs: AreaSectionViewModel, rhs: AreaSectionViewModel) -> Bool {
    return lhs.area.id == rhs.area.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(area.id)
  }

  let area: Area
}
