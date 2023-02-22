//
//  Router.swift
//  Demo
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import DemoCore
import HomePageView
import HomePageDetails
import DemoNetworking
import UIKit

final class Router {

  private let navigationController: UINavigationController
  private let client: DemoClient
  private let converters: Converters

  init(client: DemoClient, converters: Converters = Converters()) {
    self.client = client
    self.converters = converters
    navigationController = UINavigationController()
  }

  func start() -> UIViewController {
    let viewModel = HomePageViewModel(
      repository: client,
      router: self,
      metricsConverter: converters.metricsConverter,
      currencyConverter: converters.currencyConverter)

    let rootController = HomePageController(viewModel: viewModel)
    navigationController.setViewControllers(
      [rootController],
      animated: true)
    return navigationController
  }

}

extension Router: HomePageRouter {
  func didSelectItem(property: HomePageView.Property) {
    let viewModel = HomePageDetailsViewModel(
      repository: client,
      metricsConverter: converters.metricsConverter,
      currencyConverter: converters.currencyConverter)
    let controller = HomePageDetailsController(viewModel: viewModel)
    navigationController.pushViewController(controller, animated: true)
  }
}

final class Converters {

  let metricsConverter: MetricsConverter
  let currencyConverter: CurrencyConverter

  convenience init() {
    self.init(local: LocalWrapper(local: Locale(identifier: "SE"), currencySymbol: "SEK"))
  }

  init(local: LocalWrapper) {
    metricsConverter = MetricsConverter(local: local)
    currencyConverter = CurrencyConverter(local: local)
  }

}
