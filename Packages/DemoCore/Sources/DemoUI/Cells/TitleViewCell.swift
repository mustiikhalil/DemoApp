import UIKit

public final class TitleViewModel: Hashable {

  public var cellTapped: (() -> Void)?
  let attributedText: NSAttributedString
  let insets: NSDirectionalEdgeInsets
  let numberOfLines: Int

  public static var id: String {
    String(describing: self)
  }

  public init(
    attributedText: NSAttributedString,
    numberOfLines: Int = 1,
    insets: NSDirectionalEdgeInsets = .defaultInsets)
  {
    self.attributedText = attributedText
    self.insets = insets
    self.numberOfLines = numberOfLines
  }

  public init(
    text: String,
    font: UIFont = .headerBold,
    numberOfLines: Int = 1,
    textColor: UIColor = .black,
    insets: NSDirectionalEdgeInsets = .defaultInsets)
  {
    attributedText = {
      NSAttributedString(
        string: text,
        attributes: [.font: font, .foregroundColor: textColor])
    }()
    self.numberOfLines = numberOfLines
    self.insets = insets
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(attributedText.string)
  }

  public static func == (lhs: TitleViewModel, rhs: TitleViewModel) -> Bool {
    lhs.attributedText.string == rhs.attributedText.string
  }
}

extension TitleViewModel: BindableViewModel {
  public func size(for contentSize: CGSize) -> CGSize {
    let height = contentSize.height - insets.top - insets.bottom
    let width = contentSize.width - insets.leading - insets.trailing

    let textRect = attributedText.boundingRect(
      with: CGSize(width: width, height: height),
      options: [.usesLineFragmentOrigin],
      context: nil)
    let calculatedHeight = textRect.height + insets.top + insets.bottom
    return CGSize(width: contentSize.width, height: calculatedHeight)
  }
}

public final class TitleViewCell: UICollectionViewCell {

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

extension TitleViewCell: ListBindableCell {
  public func bind(viewModel: AnyHashable) {
    guard let viewModel = viewModel as? TitleViewModel else { return }
    titleLabel.numberOfLines = viewModel.numberOfLines
    titleLabel.attributedText = viewModel.attributedText
    contentView.directionalLayoutMargins = viewModel.insets
    contentView.setNeedsLayout()
  }
}
