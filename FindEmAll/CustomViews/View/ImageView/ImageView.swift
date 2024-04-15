//
//  PokeImageView.swift
//  FindEmAll
//
//  Created by Porori on 3/14/24.
//

import UIKit

class ImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(withImage: String) {
        self.init(frame: .zero)
        image = UIImage(systemName: withImage)?.withTintColor(.black, renderingMode: .alwaysOriginal)
    }
    
    func setBorder() {
        layer.borderColor = Color.PitchBlack.cgColor
        layer.borderWidth = 8
    }
    
    func downloadImageUrl(from url: String) {
        NetworkManager.shared.downloadImage(from: url) { image in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    func set(img: String) {
        image = UIImage(systemName: img)
        contentMode = .scaleAspectFit
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // create circular imageView
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = layer.frame.width/2
    }
}
