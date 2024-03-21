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
    
    func set(img: String) {
        image = UIImage(systemName: img)
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = layer.frame.width/2
    }
}
