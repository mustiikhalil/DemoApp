import UIKit

// MARK: - Helpers

public protocol DemoLocal {
  var local: Locale { get }
  var currencySymbol: String? { get }
}

public struct LocalWrapper: DemoLocal {

  public init(local: Locale = .current, currencySymbol: String? = nil) {
    self.local = local
    self.currencySymbol = currencySymbol
  }

  public let local: Locale
  public var currencySymbol: String?
}

// MARK: - CurrencyConverter

public final class CurrencyConverter {

  private let local: DemoLocal

  private lazy var currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.locale = local.local
    if let currencySymbol = local.currencySymbol {
      formatter.currencySymbol = currencySymbol
    }
    formatter.numberStyle = .currency
    return formatter
  }()

  public init(local: DemoLocal = LocalWrapper()) {
    self.local = local
  }

  public func convert(currency: Double) -> String? {
    currencyFormatter.string(from: NSNumber(value: currency))
  }
}
