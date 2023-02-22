//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-22.
//

import Kingfisher
import UIKit

extension UIImageView {
  public func set(_ imageSource: ImageSource) {
    switch imageSource {
    case .local(let image):
      self.image = image
    case .remote(let url, _):
      kf.indicatorType = .activity
      kf.setImage(with: url)
    }
  }
}

extension UIColor {
    public func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
