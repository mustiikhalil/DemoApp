//
//  DemoTests.swift
//  DemoTests
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import Combine
import XCTest
import DemoUI
import DemoCore
@testable import HomePageDetails

final class DetailsViewModelTests: XCTestCase {

  private var repository: MockRepository!
  private var metricConverter: MetricsConverter!
  private var currencyConverter: CurrencyConverter!
  private var cancellable: Set<AnyCancellable> = Set()

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

  func testProperlyFetched() {
    repository.result = .success(
      MockContent(
        id: "1",
        contentType: .highlightedProperty,
        description: "this is a description of what the property is about"))
    let viewModel = HomePageDetailsViewModel(
        repository: repository,
        metricsConverter: metricConverter,
        currencyConverter: currencyConverter)
    viewModel.$viewState.dropFirst(1).sink { state in
      XCTAssertEqual(state, .loaded)
      XCTAssertFalse(viewModel.viewModels.isEmpty)
    }.store(in: &cancellable)
    let _expectation = expectation(description: "testHomeViewControllerPresented")
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
      _expectation.fulfill()
    }
    wait(for: [_expectation], timeout: 2.0)
  }
}
