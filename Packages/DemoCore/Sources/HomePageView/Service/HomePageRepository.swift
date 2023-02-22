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
