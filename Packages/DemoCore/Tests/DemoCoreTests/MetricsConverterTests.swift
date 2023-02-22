import XCTest
@testable import DemoCore

final class MetricsConverterTests: XCTestCase {

  func testSweden10K() {
    let localWrapper = LocalWrapper(local: Locale(identifier: "SE"), currencySymbol: "SEK")
    let unitFormatter = MetricsConverter(local: localWrapper)
    XCTAssertEqual(unitFormatter.convert(measurement: .init(value: 10000, unit: UnitLength.meters)), "10 km")
  }

  func testSweden100() {
    let localWrapper = LocalWrapper(local: Locale(identifier: "SE"), currencySymbol: "SEK")
    let unitFormatter = MetricsConverter(local: localWrapper)
    XCTAssertEqual(unitFormatter.convert(measurement: .init(value: 100, unit: UnitLength.meters)), "0,1 km")
  }

  func testUSA10K() {
    let localWrapper = LocalWrapper(local: Locale(identifier: "en_US_POSIX"))
    let unitFormatter = MetricsConverter(local: localWrapper)
    XCTAssertEqual(unitFormatter.convert(measurement: .init(value: 10_000, unit: UnitLength.meters)), "6.213712 mi")
  }

}
