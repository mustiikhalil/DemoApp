//
//  DemoTests.swift
//  DemoTests
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import XCTest
import DemoCore
import DemoUI
import SnapshotTesting
@testable import HomePageView

final class HomePageControllerTests: XCTestCase {

  private var repository: MockRepository!
  private var router: MockRouter!
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
    router = MockRouter()
  }

  func testHomeViewControllerPresented() {
    repository.result = .success(
      MockHomePage(content: [
        MockHomePageContent(property: MockProperty(id: "1", contentType: .highlightedProperty)),
        MockHomePageContent(property: MockProperty(id: "2", contentType: .property)),
        MockHomePageContent(area: MockArea()),
        MockHomePageContent(property: MockProperty(id: "4", contentType: .property)),
      ]))
    let controller = HomePageController(
      viewModel: HomePageViewModel(
        repository: repository,
        router: router,
        metricsConverter: metricConverter,
        currencyConverter: currencyConverter))
    _ = controller.view
    let _expectation = expectation(description: "testHomeViewControllerPresented")
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
      assertSnapshot(matching: controller, as: .image)
      _expectation.fulfill()
    }
    wait(for: [_expectation], timeout: 2.0)
  }
}
