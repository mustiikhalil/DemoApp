import DemoCore
import DemoUI
import Foundation

final class AreaSectionViewModel: SectionViewModel {

  let area: Area
  private let currencyConverter: CurrencyConverter
  private let metricsConverter: MetricsConverter

  var sectionType: String {
    "\(area.id)_\(area.contentType)"
  }

  var viewModels: [AnyHashable] {
    var viewModels: [AnyHashable] = [
      TitleViewModel(
        text: area.area,
        font: .headerBoldLarge),
      ImageViewModel(
        imageSource: area.imageSource),
      TitleViewModel(
        text: area.area,
        font: .titleBold,
        insets: .smallInsets),
      TitleViewModel(
        text: "\(Constants.rating): \(area.ratingFormatted)",
        font: .labelFont,
        insets: .onlySides),
    ]
    if let price = currencyConverter.convert(currency: area.averagePrice) {
      viewModels.append(
        TitleViewModel(
          text: "\(Constants.averagePrice): \(price)",
          font: .labelFont,
          insets: .onlySides))
    }
    viewModels.append(SpacerViewModel())
    return viewModels
  }

  private enum Constants {
    static let rating = "Rating"
    static let averagePrice = "Average Price"
  }

  init(area: Area, currencyConverter: CurrencyConverter, metricsConverter: MetricsConverter) {
    self.area = area
    self.currencyConverter = currencyConverter
    self.metricsConverter = metricsConverter
  }

  static func == (lhs: AreaSectionViewModel, rhs: AreaSectionViewModel) -> Bool {
    return lhs.area.id == rhs.area.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(area.id)
  }

}
