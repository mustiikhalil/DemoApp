//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-22.
//

import UIKit

public enum ImageSource: Hashable {
  case remote(url: URL?, identifier: UUID = UUID())
  case local(image: UIImage)
}
