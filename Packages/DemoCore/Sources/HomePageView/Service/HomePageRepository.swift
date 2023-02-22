import DemoUI
import Foundation

public protocol HomePageRepository {
  func fetchHomePageList() async -> Result<HomePage, Error>
}

public protocol HomePage {
  var content: [HomePageContent] { get }
}

public protocol HomePageContent {
  var area: Area? { get }
  var property: Property? { get }
}

extension HomePageContent {
  func toViewModel() -> (any SectionViewModel)? {
    if let area {
      return AreaSectionViewModel(area: area)
    }
    if let property {
      return PropertySectionViewModel(property: property)
    }
    return nil
  }
}

public enum HomePageContentType: CaseIterable {
  case highlightedProperty,
       property,
       area
}
