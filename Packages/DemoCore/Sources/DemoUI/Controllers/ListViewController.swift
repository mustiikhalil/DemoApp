//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-22.
//

import UIKit

public protocol LayoutGenerator {
  func setup(layout: UICollectionViewLayout)
  func registerCells(for collectionView: UICollectionView)
  func cellId(for: AnyHashable) -> String
  func cellId(for indexPath: IndexPath) -> String
}

extension LayoutGenerator {
  public func setup(layout: UICollectionViewLayout) {}
  public func cellId(for indexPath: IndexPath) -> String {
    fatalError("Should be implemented")
  }
}

public final class ListViewController: UIViewController {

  var layoutGenerator: LayoutGenerator? {
    didSet {
      layoutGenerator?.setup(layout: collectionView.collectionViewLayout)
      collectionView.collectionViewLayout.invalidateLayout()
      collectionView.reloadData()
    }
  }

  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layoutGenerator?.setup(layout: layout)
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.delegate = self
    layoutGenerator?.registerCells(for: collectionView)
    return collectionView
  }()

  public init(layoutGenerator: LayoutGenerator? = nil) {
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
      guard let cellId = self.layoutGenerator?.cellId(for: itemIdentifier) else { return nil }
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ListBindableCell & UICollectionViewCell else {
        fatalError("UICollectionViewCell to confirm to ListBindableCell")
      }
      cell.bind(viewModel: itemIdentifier)
      return cell
    })
  }

}

extension ListViewController: UICollectionViewDelegateFlowLayout {

  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let item = dataSource?.itemIdentifier(for: indexPath) as? BindableViewModel else { return }
    item.cellTapped?()
  }

  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

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


