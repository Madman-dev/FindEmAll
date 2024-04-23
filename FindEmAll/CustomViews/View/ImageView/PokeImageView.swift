//
//  PokeImageView.swift
//  FindEmAll
//
//  Created by Porori on 3/14/24.
//

import UIKit

// 메모리 효율성에도 도움이 된다?
final class PokeImageView: UIImageView {
    
    private let timeShapeLayer = CAShapeLayer()
    private let timeLeftShapeLayer = CAShapeLayer()
    private let strokeIt = CABasicAnimation(keyPath: "strokeEnd")
    private var timeLeft: TimeInterval = 30
    // var timer = Timer() // > 필요한가...
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(withImage: String) {
        self.init(frame: .zero)
        image = UIImage(systemName: withImage)?.withTintColor(.black, renderingMode: .alwaysOriginal)
    }
    
    func countDownTimer() {
        addTimer(subLayer: timeShapeLayer, color: .green)
        addTimer(subLayer: timeLeftShapeLayer, color: .white)
        runTimer()
    }
    
    private func addTimer(subLayer: CAShapeLayer, color: UIColor) {
        layer.addSublayer(subLayer)
        subLayer.strokeColor = color.cgColor
        subLayer.fillColor = UIColor.clear.cgColor
        subLayer.lineWidth = 8
    }
    
    private func runTimer() {
        strokeIt.fromValue = 0
        strokeIt.toValue = 1
        strokeIt.duration = timeLeft
        timeLeftShapeLayer.add(strokeIt, forKey: nil)
    }
    
    // duplicate exists in codebase
//    func makeBorder() {
//        layer.borderColor = Color.PokeBlack.cgColor
//        layer.borderWidth = 8
//    }
    
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
    
    private func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // create circular imageView
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = layer.frame.width/2
        
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                    radius: bounds.width/2,
                    startAngle: -90.degreesToRadians,
                    endAngle: 270.degreesToRadians,
                    clockwise: true)
        
        timeLeftShapeLayer.path = path.cgPath
        timeShapeLayer.path = path.cgPath
    }
}
