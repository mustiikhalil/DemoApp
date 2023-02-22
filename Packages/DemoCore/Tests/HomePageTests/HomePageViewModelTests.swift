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
@testable import HomePageView

final class HomePageViewModelTests: XCTestCase {

  private var repository: MockRepository!
  private var router: MockRouter!
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
    router = MockRouter()
  }

  func testProperlyFetched() {
    repository.result = .success(
      MockHomePage(content: [
        MockHomePageContent(property: MockProperty(id: "1", contentType: .highlightedProperty)),
        MockHomePageContent(property: MockProperty(id: "2", contentType: .property)),
        MockHomePageContent(area: MockArea()),
        MockHomePageContent(property: MockProperty(id: "4", contentType: .property)),
      ]))
    let viewModel = HomePageViewModel(
        repository: repository,
        router: router,
        metricsConverter: metricConverter,
        currencyConverter: currencyConverter)
    viewModel.$viewState.dropFirst(1).sink { state in
      XCTAssertEqual(state, .loaded)
      let childViewModel = viewModel.viewModels.first?.viewModels as? BindableViewModel
      childViewModel?.cellTapped?()
      XCTAssertNotNil(self.router.property)
    }.store(in: &cancellable)
    let _expectation = expectation(description: "testHomeViewControllerPresented")
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
      _expectation.fulfill()
    }
    wait(for: [_expectation], timeout: 2.0)

  }

  func testFailedToFetched() {
    repository.result = .failure(MockError.error)
    let viewModel = HomePageViewModel(
        repository: repository,
        router: router,
        metricsConverter: metricConverter,
        currencyConverter: currencyConverter)
    viewModel.$viewState.dropFirst(1).sink { state in
      XCTAssertEqual(state, .error)
    }.store(in: &cancellable)
    let _expectation = expectation(description: "testFailedToFetched")
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
      _expectation.fulfill()
    }
    wait(for: [_expectation], timeout: 2.0)
  }
}
