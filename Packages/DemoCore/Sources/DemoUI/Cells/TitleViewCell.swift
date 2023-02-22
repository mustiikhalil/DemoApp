import UIKit

public enum Axis {
  case vertical, horizontal
}

public final class TextViewModel: Hashable {

  public var cellTapped: (() -> Void)?
  let attributedText: NSAttributedString
  let insets: NSDirectionalEdgeInsets
  let numberOfLines: Int
  let axis: Axis

  public static var id: String {
    String(describing: self)
  }

  public init(
    attributedText: NSAttributedString,
    numberOfLines: Int = 1,
    axis: Axis = .vertical,
    insets: NSDirectionalEdgeInsets = .defaultInsets)
  {
    self.attributedText = attributedText
    self.insets = insets
    self.axis = axis
    self.numberOfLines = numberOfLines
  }

  public convenience init(
    text: String,
    font: UIFont = .headerBold,
    numberOfLines: Int = 1,
    axis: Axis = .vertical,
    textColor: UIColor = .black,
    insets: NSDirectionalEdgeInsets = .defaultInsets)
  {
    let attributedText = {
      NSAttributedString(
        string: text,
        attributes: [.font: font, .foregroundColor: textColor])
    }()
    self.init(attributedText: attributedText, numberOfLines: numberOfLines, axis: axis, insets: insets)
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
    let height = contentSize.height - insets.top - insets.bottom
    let width = contentSize.width - insets.leading - insets.trailing

    let textRect = attributedText.boundingRect(
      with: CGSize(width: width, height: height),
      options: [.usesLineFragmentOrigin],
      context: nil)
    let calculatedHeight = textRect.height + insets.top + insets.bottom
    let calculatedWidth = textRect.width + insets.leading + insets.trailing
    if axis == .vertical {
      return CGSize(width: contentSize.width, height: calculatedHeight)
    } else {
      return CGSize(width: calculatedWidth + Theme.Size.Padding.small, height: calculatedHeight)
    }
  }
}

public final class TextViewCell: UICollectionViewCell {

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(titleLabel)
    contentView.insetsLayoutMarginsFromSafeArea = false

    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(
        equalTo: contentView.layoutMarginsGuide.topAnchor),
      titleLabel.bottomAnchor.constraint(
        equalTo: contentView.layoutMarginsGuide.bottomAnchor),
      titleLabel.leadingAnchor.constraint(
        equalTo: contentView.layoutMarginsGuide.leadingAnchor),
      titleLabel.trailingAnchor.constraint(
        equalTo: contentView.layoutMarginsGuide.trailingAnchor)])
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
    titleLabel.numberOfLines = viewModel.numberOfLines
    titleLabel.attributedText = viewModel.attributedText
    contentView.directionalLayoutMargins = viewModel.insets
    contentView.setNeedsLayout()
  }
}
