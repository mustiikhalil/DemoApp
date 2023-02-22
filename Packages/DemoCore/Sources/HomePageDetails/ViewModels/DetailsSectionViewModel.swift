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

    let streetAddressViewModel = TextViewModel(
      text: details.streetAddress,
      insets: .smallInsets)

    let locationViewModel = TextViewModel(
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
        TextViewModel(
          text: pricing,
          insets: .smallInsets))
    }

    viewModels.append(
      TextViewModel(
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

  var publishedSince: TextViewModel {
    generateTextViewModel(
      from: Constants.localizedPublishedSince,
      subString: "\(details.daysSincePublish)")
  }

  var hasPatio: TextViewModel {
    generateTextViewModel(
      from: Constants.localizePatio,
      subString: "\(details.patio)")
  }

  var numberOfRooms: TextViewModel {
    generateTextViewModel(
      from: Constants.localizeNumberOfRooms,
      subString: "\(details.numberOfRooms)")
  }

  var spaceViewModel: TextViewModel? {
    guard let space = metricsConverter.convert(measurement: .init(value: details.livingArea, unit: UnitArea.squareMeters)) else { return nil }
    return generateTextViewModel(
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

  private func generateTextViewModel(from text: String, subString: String) -> TextViewModel {
    let mutableString = NSMutableAttributedString(
      string: "\(text): ",
      attributes: Constants.boldAttributes)
    mutableString.append(
      NSAttributedString(
        string: subString,
        attributes: Constants.normalAttributes))
    return TextViewModel(
      attributedText: mutableString,
      insets: .smallInsets)
  }
}
