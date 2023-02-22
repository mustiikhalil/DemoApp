import UIKit

public final class HorizontalViewModel: Hashable {

  public var cellTapped: (() -> Void)?
  private let id = UUID()
  private let height: CGFloat
  let insets: NSDirectionalEdgeInsets
  let layoutGenerator: LayoutGenerator
  public let viewModels: [AnyHashable]

  public static var id: String {
    String(describing: self)
  }

  public init(
    viewModels: [AnyHashable],
    layoutGenerator: LayoutGenerator,
    height: CGFloat,
    insets: NSDirectionalEdgeInsets = .onlySides)
  {
    self.layoutGenerator = layoutGenerator
    self.height = height
    self.insets = insets
    self.viewModels = viewModels
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(viewModels)
  }

  public static func == (lhs: HorizontalViewModel, rhs: HorizontalViewModel) -> Bool {
    lhs.id == rhs.id && lhs.viewModels.difference(from: rhs.viewModels, by: { viewModel, viewModel2 in
      viewModel == viewModel2
    }).isEmpty
  }

}

extension HorizontalViewModel: SectionViewModel {
  public var sectionType: String {
    "horizontal"
  }

}

extension HorizontalViewModel: BindableViewModel {
  public func size(for contentSize: CGSize) -> CGSize {
    return CGSize(width: contentSize.width, height: height)
  }
}

public final class HorizontalViewCell: UICollectionViewCell {

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    contentView.insetsLayoutMarginsFromSafeArea = false

    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(
        equalTo: contentView.layoutMarginsGuide.topAnchor),
      collectionView.bottomAnchor.constraint(
        equalTo: contentView.layoutMarginsGuide.bottomAnchor),
      collectionView.leadingAnchor.constraint(
        equalTo: contentView.layoutMarginsGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(
        equalTo: contentView.layoutMarginsGuide.trailingAnchor)])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.delegate = self
    collection.dataSource = self
    return collection
  }()

  private var viewModel: HorizontalViewModel?
}

extension HorizontalViewCell: ListBindableCell {
  public func bind(viewModel: AnyHashable) {
    guard let viewModel = viewModel as? HorizontalViewModel else { return }
    self.viewModel = viewModel
    viewModel.layoutGenerator.registerCells(for: collectionView)
    contentView.directionalLayoutMargins = viewModel.insets
    contentView.setNeedsLayout()
  }
}

extension HorizontalViewCell: UICollectionViewDataSource {

  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel?.viewModels.count ?? 0
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cellId = viewModel?.layoutGenerator.cellId(for: indexPath) else {
      fatalError("UICollectionViewCell to confirm to ListBindableCell")
    }
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ListBindableCell & UICollectionViewCell else {
      fatalError("UICollectionViewCell to confirm to ListBindableCell")
    }
    if let viewModel = viewModel?.viewModels[indexPath.item] {
      cell.bind(viewModel: viewModel)
    }
    return cell
  }

}

extension HorizontalViewCell: UICollectionViewDelegate {}

extension HorizontalViewCell: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let viewModel = viewModel?.viewModels[indexPath.item] as? BindableViewModel else { return .zero }
    return viewModel.size(for: bounds.size)
  }
}
