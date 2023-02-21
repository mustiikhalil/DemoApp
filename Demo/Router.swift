//
//  Router.swift
//  Demo
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import HomePageView
import DemoNetworking
import UIKit

final class Router {

  private let client: DemoClient

  init(client: DemoClient) {
    self.client = client
  }

  func start() -> UIViewController {
    UINavigationController(
      rootViewController: HomePageController(
        viewModel: HomePageViewModel(
          repository: client)))
  }

}
