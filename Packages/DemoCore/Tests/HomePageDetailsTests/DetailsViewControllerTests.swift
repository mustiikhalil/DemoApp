//
//  DemoTests.swift
//  DemoTests
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import XCTest
import DemoUI
import DemoCore
import SnapshotTesting
@testable import HomePageDetails

final class DetailsViewControllerTests: XCTestCase {

  private var repository: MockRepository!
  private var metricConverter: MetricsConverter!
  private var currencyConverter: CurrencyConverter!

  override func setUp() {
    let wrapper = LocalWrapper(
      local: Locale(identifier: "SE"),
      currencySymbol: "SEK")
    currencyConverter = CurrencyConverter(
      local: wrapper)

    metricConverter = MetricsConverter(
      local: wrapper)
    repository = MockRepository()
  }

  func testDetailsViewController() {
    repository.result = .success(
      MockContent(
        id: "1",
        contentType: .highlightedProperty,
        description: "this is a description of what the property is about"))
    let viewModel = HomePageDetailsViewModel(
        repository: repository,
        metricsConverter: metricConverter,
        currencyConverter: currencyConverter)
    let controller = HomePageDetailsController(
      viewModel: viewModel)
    _ = controller.view
    let _expectation = expectation(description: "testDetailsViewController")
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
      assertSnapshot(matching: controller, as: .image)
      _expectation.fulfill()
    }
    wait(for: [_expectation], timeout: 2.0)
  }
}
