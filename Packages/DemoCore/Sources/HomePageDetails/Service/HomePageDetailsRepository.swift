import DemoCore
import DemoUI
import UIKit

public protocol HomePageDetailsRepository {
  func fetchHomeDetails() async -> Result<DetailsPage, Error>
}

public protocol DetailsPage {
  var id: String { get }
  var description: String { get }
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
  var patio: String { get }
}

extension DetailsPage {
  var location: String {
    "\(area), \(municipality)"
  }

  var attributedDescription: NSAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineBreakMode = .byWordWrapping
    paragraphStyle.lineSpacing = 6
    return NSAttributedString(
      string: description,
      attributes: [
        .foregroundColor: UIColor.black,
        .font: UIFont.systemFont(ofSize: 12),
        .paragraphStyle: paragraphStyle
      ])
  }
}
