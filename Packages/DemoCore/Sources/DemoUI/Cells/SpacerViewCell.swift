//
//  File.swift
//
//
//  Created by Mustafa Khalil on 2023-02-22.
//

import UIKit

public final class SpacerViewModel: Hashable {

  public var cellTapped: (() -> Void)?
  public static var id: String {
    String(describing: self)
  }

  private let id = UUID()
  private let height: CGFloat
  let backgroundColor: UIColor

  public init(
    backgroundColor: UIColor = .white,
    height: CGFloat = Theme.Size.Padding.large)
  {
    self.backgroundColor = backgroundColor
    self.height = height
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(height)
  }

  public static func == (lhs: SpacerViewModel, rhs: SpacerViewModel) -> Bool {
    lhs.id == rhs.id
  }

}

extension SpacerViewModel: BindableViewModel {
  public func size(for contentSize: CGSize) -> CGSize {
    return CGSize(width: contentSize.width, height: height)
  }
}

public final class SpacerViewCell: UICollectionViewCell {

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SpacerViewCell: ListBindableCell {
  public func bind(viewModel: AnyHashable) {
    guard let viewModel = viewModel as? SpacerViewModel else { return }
    backgroundColor = viewModel.backgroundColor
  }
}
