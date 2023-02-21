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

  private let layoutGenerator: ListLayoutGenerator
  private let viewModel: HomePageViewModel

  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: layoutGenerator.generateLayout(frame: view.frame))
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    layoutGenerator.registerCells(for: collectionView)
    return collectionView
  }()

  private var dataSource: UICollectionViewDiffableDataSource<AnyHashable, AnyHashable>?

  public convenience init(viewModel: HomePageViewModel) {
    self.init(viewModel: viewModel, layoutGenerator: ListLayoutGenerator())
  }

  init(viewModel: HomePageViewModel, layoutGenerator: ListLayoutGenerator) {
    self.viewModel = viewModel
    self.layoutGenerator = layoutGenerator
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
    view.backgroundColor = .blue
    view.addSubview(collectionView, insets: .zero)

    dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as? ListBindableCell & UICollectionViewCell else {
        fatalError("UICollectionViewCell to confirm to ListBindableCell")
      }
      cell.bind(viewModel: itemIdentifier)
      return cell
    })
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

      dataSource?.apply(snapshot, animatingDifferences: true)
    }
  }

}

struct ListLayoutGenerator {

  func registerCells(for collectionView: UICollectionView) {
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")
  }

  func cellId() -> String {
    "id"
  }

  func generateLayout(frame: CGRect) -> UICollectionViewCompositionalLayout {
    UICollectionViewCompositionalLayout(
      sectionProvider: { section, env in
        print(section)
        let layoutSize = NSCollectionLayoutSize(
          widthDimension: .absolute(frame.width - 20),
          heightDimension: .estimated(300))

        let subItemSize = NSCollectionLayoutSize(
          widthDimension: .absolute(frame.width - 20),
          heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: subItemSize)

        let text = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
          widthDimension: .absolute(frame.width - 20),
          heightDimension: .estimated(40)))

        let group = NSCollectionLayoutGroup.vertical(
          layoutSize: layoutSize,
          subitems: [item, text])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: -10)
        return section
      })
  }
}
