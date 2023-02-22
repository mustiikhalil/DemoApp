import Foundation

public protocol BindableViewModel {
  func size(for contentSize: CGSize) -> CGSize
}

public protocol ListBindableCell {
  func bind(viewModel: AnyHashable)
}
