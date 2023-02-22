import Combine
import DemoCore
import DemoUI
import UIKit

public final class HomePageDetailsViewModel {

  @Published var viewState: ViewState = .loading

  private let repository: HomePageDetailsRepository
  private let metricsConverter: MetricsConverter
  private let currencyConverter: CurrencyConverter
  private(set) var viewModels: [any SectionViewModel] = []

  public init(
    repository: HomePageDetailsRepository,
    metricsConverter: MetricsConverter,
    currencyConverter: CurrencyConverter)
  {
    self.repository = repository
    self.metricsConverter = metricsConverter
    self.currencyConverter = currencyConverter
  }

  func fetchDetails() {
    Task { @MainActor in
      let data = await repository.fetchHomeDetails()
      switch data {
      case .success(let data):
        self.viewModels = [
          DetailsSectionViewModel(
            details: data,
            currencyConverter: currencyConverter,
            metricsConverter: metricsConverter)
        ]
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

