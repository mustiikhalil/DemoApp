import UIKit

public final class TextViewModel: Hashable {

  public var cellTapped: (() -> Void)?
  let attributedText: NSAttributedString

  public static var id: String {
    String(describing: self)
  }

  public init(attributedText: NSAttributedString) {
    self.attributedText = attributedText
  }

  public init(
    text: String,
    font: UIFont = .boldSystemFont(ofSize: 12),
    textColor: UIColor = .black)
  {
    attributedText = {
      NSAttributedString(
        string: text,
        attributes: [.font: font, .foregroundColor: textColor])
    }()
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(attributedText.string)
  }

  public static func == (lhs: TextViewModel, rhs: TextViewModel) -> Bool {
    lhs.attributedText.string == rhs.attributedText.string
  }

}

extension TextViewModel: BindableViewModel {
  public func size(for contentSize: CGSize) -> CGSize {
    let textRect = attributedText.boundingRect(with: contentSize, context: nil)
    return CGSize(
      width: textRect.width + Theme.Size.Padding.large,
      height: textRect.height)
  }
}

public final class TextViewCell: UICollectionViewCell {

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(titleLabel, insets: .zero)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

}

extension TextViewCell: ListBindableCell {
  public func bind(viewModel: AnyHashable) {
    guard let viewModel = viewModel as? TextViewModel else { return }
    titleLabel.attributedText = viewModel.attributedText
  }
}
