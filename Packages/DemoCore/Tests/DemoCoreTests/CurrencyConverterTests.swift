import XCTest
@testable import DemoCore

final class UnitFormatterTests: XCTestCase {

  func testSweden10K() {
    let localWrapper = LocalWrapper(local: Locale(identifier: "SE"), currencySymbol: "SEK")
    let unitFormatter = CurrencyConverter(local: localWrapper)
    XCTAssertEqual(unitFormatter.convert(currency: 10000), "10 000,00 SEK")
  }

  func testSweden10_50K() {
    let localWrapper = LocalWrapper(local: Locale(identifier: "SE"), currencySymbol: "SEK")
    let unitFormatter = CurrencyConverter(local: localWrapper)
    XCTAssertEqual(unitFormatter.convert(currency: 10000.50), "10 000,50 SEK")
  }

  func testUSA10K() {
    let localWrapper = LocalWrapper(local: Locale(identifier: "en_US_POSIX"))
    let unitFormatter = CurrencyConverter(local: localWrapper)
    XCTAssertEqual(unitFormatter.convert(currency: 10000), "$ 10000.00")
  }

}
