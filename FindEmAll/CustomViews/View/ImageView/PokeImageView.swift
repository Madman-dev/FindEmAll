//
//  PokeImageView.swift
//  FindEmAll
//
//  Created by Porori on 3/14/24.
//

import UIKit

protocol PokeImageDelegate: AnyObject {
    func isTimeOver(_ complete: Bool)
}

// 메모리 효율성에도 도움이 된다?
class PokeImageView: UIImageView {
    
    private let timeShapeLayer = CAShapeLayer()
    private let timeLeftShapeLayer = CAShapeLayer()
    private let countStroke = CABasicAnimation(keyPath: "strokeEnd")
    private var timeLeft: TimeInterval = 30
    private var timer = Timer()
    private var isTimeOver: Bool = false
    var delegate: PokeImageDelegate?
    
    override var bounds: CGRect {
        didSet {
            layer.cornerRadius = bounds.width/2
            print("bound size",bounds.size)
        }
    }
    
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
        timer = Timer.scheduledTimer(timeInterval: timeLeft,
                                     target: self,
                                     selector: #selector(timeIsOver),
                                     userInfo: nil,
                                     repeats: false)
        
        addTimer(subLayer: timeShapeLayer, color: .green)
        addTimer(subLayer: timeLeftShapeLayer, color: .white)
        runTimer()
    }
    
    @objc func timeIsOver() {
        isTimeOver = true
        delegate?.isTimeOver(isTimeOver)
    }
    
    private func addTimer(subLayer: CAShapeLayer, color: UIColor) {
        layer.addSublayer(subLayer)
        subLayer.strokeColor = color.cgColor
        subLayer.fillColor = UIColor.clear.cgColor
        subLayer.lineWidth = 8
    }
    
    private func runTimer() {
        countStroke.fromValue = 0
        countStroke.toValue = 1
        countStroke.duration = timeLeft
        timeLeftShapeLayer.add(countStroke, forKey: nil)
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
    
    private func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // create circular imageView
    override func layoutSubviews() {
        super.layoutSubviews()
        
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
