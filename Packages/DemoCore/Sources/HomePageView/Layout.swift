import DemoUI
import UIKit

struct ListLayoutGenerator: LayoutGenerator {

  func registerCells(for collectionView: UICollectionView) {
    collectionView.register(
      ImageViewCell.self,
      forCellWithReuseIdentifier: ImageViewModel.id)

    collectionView.register(
      TitleViewCell.self,
      forCellWithReuseIdentifier: TitleViewModel.id)

    collectionView.register(
      HorizontalViewCell.self,
      forCellWithReuseIdentifier: HorizontalViewModel.id)

    collectionView.register(
      SpacerViewCell.self,
      forCellWithReuseIdentifier: SpacerViewModel.id)
  }

  func cellId(for item: AnyHashable) -> String {
    switch item {
    case is ImageViewModel:
      return ImageViewModel.id
    case is TitleViewModel:
      return TitleViewModel.id
    case is SpacerViewModel:
      return SpacerViewModel.id
    case is HorizontalViewModel:
      return HorizontalViewModel.id
    default: return "id"
    }
  }
}

struct HorizontalLayout: LayoutGenerator {
  func setup(layout: UICollectionViewLayout) {
    (layout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
  }

  func registerCells(for collectionView: UICollectionView) {
    collectionView.register(TextViewCell.self, forCellWithReuseIdentifier: TextViewModel.id)
  }

  func cellId(for indexPath: IndexPath) -> String {
    TextViewModel.id
  }

  func cellId(for: AnyHashable) -> String {
    TextViewModel.id
  }

}
