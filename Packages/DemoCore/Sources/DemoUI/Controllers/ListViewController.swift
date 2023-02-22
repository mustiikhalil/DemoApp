//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-22.
//

import UIKit

public protocol LayoutGenerator {
  func registerCells(for collectionView: UICollectionView)
  func cellId(for: AnyHashable) -> String
}

public final class ListViewController: UIViewController {

  private let layoutGenerator: LayoutGenerator
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.delegate = self
    layoutGenerator.registerCells(for: collectionView)
    return collectionView
  }()

  public init(layoutGenerator: LayoutGenerator) {
    self.layoutGenerator = layoutGenerator
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }

  public private(set) var dataSource: UICollectionViewDiffableDataSource<AnyHashable, AnyHashable>?

  private func setupView() {
    view.addSubview(collectionView, insets: .zero)
    dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.layoutGenerator.cellId(for: itemIdentifier), for: indexPath) as? ListBindableCell & UICollectionViewCell else {
        fatalError("UICollectionViewCell to confirm to ListBindableCell")
      }
      cell.bind(viewModel: itemIdentifier)
      return cell
    })
  }

}

extension ListViewController: UICollectionViewDelegateFlowLayout {
  public func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath)
  -> CGSize
  {
    guard let viewModel = dataSource?.itemIdentifier(for: indexPath) as? BindableViewModel else { fatalError("ViewModel should confirm to `BindableViewModel`") }
    return viewModel.size(for: collectionView.frame.size)
  }
}


