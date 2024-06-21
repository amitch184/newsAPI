//
//  GlobalManager.swift
//  newsApi
//
//  Created by Amit Choudhary on 20/06/24.
//

import Foundation
import UIKit

/// Class for Global Methods with single instance
class GlobalManager {
    static let shareInstance = GlobalManager()
    
    private init() {}
    
    /// Set Deeplink Enable
    /// - Parameter flag: type Bool
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
           DispatchQueue.global().async {
               if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                   DispatchQueue.main.async {
                       completion(image)
                   }
               } else {
                   DispatchQueue.main.async {
                       completion(nil)
                   }
               }
           }
       }
    
    
}
