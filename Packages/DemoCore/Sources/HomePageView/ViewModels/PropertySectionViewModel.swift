import DemoCore
import DemoUI
import Foundation

final class PropertySectionViewModel: SectionViewModel {

  let property: Property
  private let currencyConverter: CurrencyConverter
  private let metricsConverter: MetricsConverter

  var cellTapped: (() -> Void)?

  var sectionType: String {
    "\(property.id)_\(property.contentType)"
  }

  var viewModels: [AnyHashable] {
    let imageViewModel = ImageViewModel(
      imageSource: property.imageSource,
      isHighlighted: property.contentType == .highlightedProperty)
    imageViewModel.cellTapped = cellTapped
    let streetAddressViewModel = TextViewModel(
      text: property.streetAddress,
      insets: .smallInsets)
    streetAddressViewModel.cellTapped = cellTapped

    let locationViewModel = TextViewModel(
      text: property.location,
      font: .labelFont,
      textColor: .gray,
      insets: .onlySides)
    locationViewModel.cellTapped = cellTapped

    var viewModels: [AnyHashable] = [
      imageViewModel,
      streetAddressViewModel,
      locationViewModel,
    ]

    var horizontalViewModels: [AnyHashable] = []
    if let currency = currencyConverter.convert(currency: property.askingPrice) {
      horizontalViewModels.append(TextViewModel(
        text: currency,
        font: .boldSystemFont(ofSize: 12),
        axis: .horizontal,
        insets: .zero))
    }
    if let livingArea = metricsConverter.convert(measurement: .init(value: property.livingArea, unit: UnitArea.squareMeters)) {
      horizontalViewModels.append(TextViewModel(
        text: livingArea,
        font: .boldSystemFont(ofSize: 12),
        axis: .horizontal,
        insets: .zero))
    }
    horizontalViewModels.append(
      TextViewModel(
        text: "\(property.numberOfRooms) Rooms",
        font: .boldSystemFont(ofSize: 12),
        axis: .horizontal,
        insets: .zero))
    let horizontalViewModel = HorizontalViewModel(
      viewModels: horizontalViewModels,
      layoutGenerator: HorizontalLayout(),
      height: 30)
    horizontalViewModel.cellTapped = cellTapped
    viewModels.append(horizontalViewModel)
    viewModels.append(SpacerViewModel())
    return viewModels
  }

  init(property: Property, currencyConverter: CurrencyConverter, metricsConverter: MetricsConverter) {
    self.property = property
    self.currencyConverter = currencyConverter
    self.metricsConverter = metricsConverter
  }

  static func == (lhs: PropertySectionViewModel, rhs: PropertySectionViewModel) -> Bool {
    return lhs.property.id == rhs.property.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(property.id)
  }

}
