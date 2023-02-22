import DemoUI
import Foundation

struct PropertySectionViewModel: SectionViewModel {

  var sectionType: String {
    "\(property.id)_\(property.contentType)"
  }

  var viewModels: [AnyHashable] {
    [
      ImageViewModel(
        imageSource: .remote(url: property.image),
        isHighlighted: property.contentType == .highlightedProperty),
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
    "\(area.id)_\(area.contentType)"
  }

  var viewModels: [AnyHashable] {
    [
      ImageViewModel(imageSource: .remote(url: area.image)),
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
