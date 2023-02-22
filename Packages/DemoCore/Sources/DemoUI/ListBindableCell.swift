import Foundation

public protocol BindableViewModel {
  var cellTapped: (() -> Void)? { get set }
  func size(for contentSize: CGSize) -> CGSize
}

public protocol ListBindableCell {
  func bind(viewModel: AnyHashable)
}
