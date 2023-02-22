//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import Combine
import DemoCore
import DemoUI
import UIKit

public final class HomePageViewModel {

  @Published var viewState: ViewState = .loading

  private weak var router: HomePageRouter?
  private let repository: HomePageRepository
  private let metricsConverter: MetricsConverter
  private let currencyConverter: CurrencyConverter
  private(set) var viewModels: [any SectionViewModel] = []

  public init(
    repository: HomePageRepository,
    router: HomePageRouter,
    metricsConverter: MetricsConverter,
    currencyConverter: CurrencyConverter)
  {
    self.repository = repository
    self.router = router
    self.metricsConverter = metricsConverter
    self.currencyConverter = currencyConverter
  }

  func userTapped(property: Property) {
    router?.didSelectItem(property: property)
  }

  func fetchHomePageData() {
    Task { @MainActor in
      let data = await repository.fetchHomePageList()
      switch data {
      case .success(let data):
        guard !data.content.isEmpty else {
          viewState = .empty
          return
        }
        self.viewModels = data.content.compactMap {
          if let area = $0.area {
            return AreaSectionViewModel(
              area: area,
              currencyConverter: currencyConverter,
              metricsConverter: metricsConverter)
          }
          if let property = $0.property {
            let viewModel = PropertySectionViewModel(
              property: property,
              currencyConverter: currencyConverter,
              metricsConverter: metricsConverter)
            viewModel.cellTapped = { [weak self] in
              self?.userTapped(property: property)
            }
            return viewModel
          }
          return nil
        }
        viewState = .loaded
      case .failure:
        viewState = .error
      }
    }
  }

  func prepareSnapshot() -> NSDiffableDataSourceSnapshot<AnyHashable, AnyHashable> {
    var snapshot = NSDiffableDataSourceSnapshot<AnyHashable, AnyHashable>()
    viewModels.forEach { sectionViewModel in
      snapshot.appendSections([sectionViewModel.sectionType])
      snapshot.appendItems(
        sectionViewModel.viewModels,
        toSection: sectionViewModel.sectionType)
    }

    return snapshot
  }
}
