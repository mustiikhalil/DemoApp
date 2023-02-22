//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-22.
//

import UIKit

public struct ImageViewModel: Hashable {

  public func hash(into hasher: inout Hasher) {
    hasher.combine(imageSource)
  }

  public static var id: String {
    String(describing: self)
  }

  let imageSource: ImageSource
  let isHighlighted: Bool
  let isExpanded: Bool

  public init(
    imageSource: ImageSource,
    isHighlighted: Bool = false,
    isExpanded: Bool = false)
  {
    self.imageSource = imageSource
    self.isHighlighted = isHighlighted
    self.isExpanded = isExpanded
  }

}

extension ImageViewModel: BindableViewModel {
  public func size(for contentSize: CGSize) -> CGSize {
    if isHighlighted || isExpanded {
      return CGSize(width: contentSize.width, height: 250)
    } else {
      return CGSize(width: contentSize.width, height: 200)
    }
  }
}

public final class ImageViewCell: UICollectionViewCell {

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(
      imageView,
      insets: .init(
        top: Theme.Size.Padding.small,
        left: Theme.Size.Padding.base,
        bottom: Theme.Size.Padding.small,
        right: Theme.Size.Padding.base))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 6
    imageView.layer.borderColor = UIColor.gold.cgColor
    return imageView
  }()

}

extension ImageViewCell: ListBindableCell {
  public func bind(viewModel: AnyHashable) {
    guard let viewModel = viewModel as? ImageViewModel else { return }
    imageView.set(viewModel.imageSource)
    imageView.layer.borderWidth = viewModel.isHighlighted ? 1.5 : 0
  }
}
