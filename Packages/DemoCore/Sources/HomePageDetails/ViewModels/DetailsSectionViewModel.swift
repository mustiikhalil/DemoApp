import DemoCore
import DemoUI
import UIKit

final class DetailsSectionViewModel: SectionViewModel {

  let details: DetailsPage
  private let currencyConverter: CurrencyConverter
  private let metricsConverter: MetricsConverter

  var cellTapped: (() -> Void)?

  var sectionType: String {
    "\(details.id)_\(details.contentType)"
  }

  var viewModels: [AnyHashable] {
    let imageViewModel = ImageViewModel(
      imageSource: details.imageSource,
      isHighlighted: details.contentType == .highlightedProperty)
    imageViewModel.cellTapped = cellTapped

    let streetAddressViewModel = TitleViewModel(
      text: details.streetAddress,
      insets: .smallInsets)

    let locationViewModel = TitleViewModel(
      text: details.location,
      font: .labelFont,
      textColor: .gray,
      insets: .onlySides)
    var viewModels: [AnyHashable] = [
      imageViewModel,
      streetAddressViewModel,
      locationViewModel,
    ]

    if let pricing = currencyConverter.convert(currency: details.askingPrice) {
      viewModels.append(
        TitleViewModel(
          text: pricing,
          insets: .smallInsets))
    }

    viewModels.append(
      TitleViewModel(
        attributedText: details.attributedDescription,
        numberOfLines: 0,
        insets: .init(
          top: Theme.Size.Padding.xxlarge,
          leading: Theme.Size.Padding.base,
          bottom: Theme.Size.Padding.xxlarge,
          trailing: Theme.Size.Padding.base)))

    if let spaceViewModel {
      viewModels.append(spaceViewModel)
    }
    viewModels.append(numberOfRooms)
    viewModels.append(hasPatio)
    viewModels.append(publishedSince)
    return viewModels
  }

  var publishedSince: TitleViewModel {
    generateTitleViewModel(
      from: Constants.localizedPublishedSince,
      subString: "\(details.daysSincePublish)")
  }

  var hasPatio: TitleViewModel {
    generateTitleViewModel(
      from: Constants.localizePatio,
      subString: "\(details.patio)")
  }

  var numberOfRooms: TitleViewModel {
    generateTitleViewModel(
      from: Constants.localizeNumberOfRooms,
      subString: "\(details.numberOfRooms)")
  }

  var spaceViewModel: TitleViewModel? {
    guard let space = metricsConverter.convert(measurement: .init(value: details.livingArea, unit: UnitArea.squareMeters)) else { return nil }
    return generateTitleViewModel(
      from: Constants.localizedLivingArea,
      subString: space)
  }

  private enum Constants {
    static let localizedLivingArea = "Living Area"
    static let localizePatio = "Patio"
    static let localizeNumberOfRooms = "Number of rooms"
    static let localizedPublishedSince = "Days since published"

    static var boldAttributes: [NSAttributedString.Key: Any] {
      [
        .foregroundColor: UIColor.black,
        .font: UIFont.boldSystemFont(ofSize: 12)
      ]
    }

    static var normalAttributes: [NSAttributedString.Key: Any] {
      [
        .foregroundColor: UIColor.black,
        .font: UIFont.systemFont(ofSize: 12)
      ]
    }
  }

  init(details: DetailsPage, currencyConverter: CurrencyConverter, metricsConverter: MetricsConverter) {
    self.details = details
    self.currencyConverter = currencyConverter
    self.metricsConverter = metricsConverter
  }

  static func == (lhs: DetailsSectionViewModel, rhs: DetailsSectionViewModel) -> Bool {
    return lhs.details.id == rhs.details.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(details.id)
  }

  private func generateTitleViewModel(from text: String, subString: String) -> TitleViewModel {
    let mutableString = NSMutableAttributedString(
      string: "\(text): ",
      attributes: Constants.boldAttributes)
    mutableString.append(
      NSAttributedString(
        string: subString,
        attributes: Constants.normalAttributes))
    return TitleViewModel(
      attributedText: mutableString,
      insets: .smallInsets)
  }
}
