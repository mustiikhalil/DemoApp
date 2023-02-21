//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import Combine
import DemoUI
import UIKit

public final class HomePageViewModel {

  @Published var viewState: ViewState = .loading

  private let repository: HomePageRepository
  private(set) var viewModels: [any SectionViewModel] = []

  public init(repository: HomePageRepository) {
    self.repository = repository
  }

  func fetchHomePageData() {
    Task { @MainActor in
      let data = await repository.fetchHomePageList()
      switch data {
      case .success(let success):
        guard !success.items.isEmpty else {
          viewState = .empty
          return
        }
        viewModels = success.items.map { homePageContent in
          homePageContent.toViewModel()
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
