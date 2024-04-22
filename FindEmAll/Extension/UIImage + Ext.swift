//
//  UIImage + Ext.swift
//  FindEmAll
//
//  Created by Porori on 4/21/24.
//

import UIKit

extension UIImage {
    
    //MARK: - previous bitmap workaround deprecated - Update to iOS 10
    func createSilhouette(color: UIColor = .white) -> UIImage {
        
        // create an instance of UIGrpahicImageRender
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let image = renderer.image { context in
            // sets new position for image position.
            let rect = CGRect(origin: .zero, size: size)
            
            if let cgImage = cgImage {
                // fills the image with given color
                color.setFill()
                // Core Graphics origin shift to match UIKit coordinate origin [top left]
                context.cgContext.translateBy(x: 0, y: size.height)
                context.cgContext.scaleBy(x: 1, y: -1)
                // clip the image's mask to rectangle & fill in the color
                context.cgContext.clip(to: rect, mask: cgImage)
                context.fill(rect)
            }
        }
        return image
    }
}
