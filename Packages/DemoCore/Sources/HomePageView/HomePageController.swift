//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import Combine
import DemoUI
import UIKit

public final class HomePageController: UIViewController {

  private var cancellables: Set<AnyCancellable> = Set()
  private let viewModel: HomePageViewModel

  private lazy var listController: ListViewController = {
    ListViewController(layoutGenerator: ListLayoutGenerator())
  }()

  public init(viewModel: HomePageViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupObservers()
    viewModel.fetchHomePageData()
  }

  private func setupView() {
    addChild(listController)
    view.addSubview(listController.view, insets: .zero)
    listController.didMove(toParent: self)
  }

  private func setupObservers() {
    viewModel.$viewState
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        self?.refreshView(state: state)
      }.store(in: &cancellables)
  }

  private func refreshView(state: ViewState) {
    switch state {
    case .empty: break // present something to indicate empty state
    case .error:
      let alert = UIAlertController(
        title: "Something went wrong",
        message: "Message",
        preferredStyle: .alert)
      let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
      alert.addAction(cancelAction)
      present(alert, animated: true)
    case .loading: break // present loading indicator
    case .loaded:
      let snapshot = viewModel.prepareSnapshot()
      listController.dataSource?.apply(snapshot, animatingDifferences: true)
    }
  }

}

struct ListLayoutGenerator: LayoutGenerator {

  func registerCells(for collectionView: UICollectionView) {
    collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: ImageViewModel.id)
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")
  }

  func cellId(for item: AnyHashable) -> String {
    switch item {
    case is ImageViewModel:
      return ImageViewModel.id
    default: return "id"
    }
  }
}
