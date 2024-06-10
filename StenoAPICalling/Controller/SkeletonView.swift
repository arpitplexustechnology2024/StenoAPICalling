//
//  SkeletonView.swift
//  CustomeDataAPICalling
//
//  Created by Arpit iOS Dev. on 07/06/24.
//

import Foundation
import UIKit

class SkeletonTableViewCell: UITableViewCell {
    
    private let skeletonIdView = UIView()
    private let skeletonNameView = UIView()
    private let skeletonextPathView = UIView()
    private let skeletonextPath1View = UIView()
    
    private let skeletonIdViewGradient = CAGradientLayer()
    private let skeletonNameViewGradient = CAGradientLayer()
    private let skeletonextPathViewGradient = CAGradientLayer()
    private let skeletonextPath1ViewGradient = CAGradientLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSkeleton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSkeleton()
    }
    
    private func setupSkeleton() {
        //MARK: - Setup the skeletonId view -
        skeletonIdView.backgroundColor = .systemGray4
        skeletonIdView.clipsToBounds = true
        contentView.addSubview(skeletonIdView)
        
        skeletonIdView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skeletonIdView.widthAnchor.constraint(equalToConstant: 50),
            skeletonIdView.heightAnchor.constraint(equalToConstant: 51),
            skeletonIdView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            skeletonIdView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
        ])
        
        // Setup the gradient layer for shimmer effect
        skeletonIdViewGradient.colors = [UIColor.lightGray.cgColor, UIColor.white.cgColor, UIColor.lightGray.cgColor]
        skeletonIdViewGradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        skeletonIdViewGradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        skeletonIdViewGradient.locations = [0.0, 0.5, 1.0]
        skeletonIdViewGradient.frame = skeletonIdView.bounds
        skeletonIdViewGradient.add(createShimmerAnimation(), forKey: "shimmer")
        skeletonIdView.layer.addSublayer(skeletonIdViewGradient)
        
        //MARK: - Setup the skeletonName view -
        skeletonNameView.backgroundColor = .systemGray4
        skeletonNameView.clipsToBounds = true
        contentView.addSubview(skeletonNameView)
        
        skeletonNameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skeletonNameView.widthAnchor.constraint(equalToConstant: 205),
            skeletonNameView.heightAnchor.constraint(equalToConstant: 51),
            skeletonNameView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            skeletonNameView.leftAnchor.constraint(equalTo: skeletonIdView.rightAnchor, constant: 9),
        ])
        
        // Setup the gradient layer for shimmer effect
        skeletonNameViewGradient.colors = [UIColor.lightGray.cgColor, UIColor.white.cgColor, UIColor.lightGray.cgColor]
        skeletonNameViewGradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        skeletonNameViewGradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        skeletonNameViewGradient.locations = [0.0, 0.5, 1.0]
        skeletonNameViewGradient.frame = skeletonNameView.bounds
        skeletonNameViewGradient.add(createShimmerAnimation(), forKey: "shimmer")
        skeletonNameView.layer.addSublayer(skeletonNameViewGradient)
        
        //MARK: - Setup the skeletonExtPath view -
        skeletonextPathView.backgroundColor = .systemGray4
        skeletonextPathView.clipsToBounds = true
        contentView.addSubview(skeletonextPathView)
        
        skeletonextPathView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skeletonextPathView.widthAnchor.constraint(equalToConstant: 50),
            skeletonextPathView.heightAnchor.constraint(equalToConstant: 51),
            skeletonextPathView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            skeletonextPathView.leftAnchor.constraint(equalTo: skeletonNameView.rightAnchor, constant: 9),
        ])
        
        // Setup the gradient layer for shimmer effect
        skeletonextPathViewGradient.colors = [UIColor.lightGray.cgColor, UIColor.white.cgColor, UIColor.lightGray.cgColor]
        skeletonextPathViewGradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        skeletonextPathViewGradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        skeletonextPathViewGradient.locations = [0.0, 0.5, 1.0]
        skeletonextPathViewGradient.frame = skeletonextPathView.bounds
        skeletonextPathViewGradient.add(createShimmerAnimation(), forKey: "shimmer")
        skeletonextPathView.layer.addSublayer(skeletonextPathViewGradient)
        
        //MARK: - Setup the skeletonExtPath1 view -
        skeletonextPath1View.backgroundColor = .systemGray4
        skeletonextPath1View.clipsToBounds = true
        contentView.addSubview(skeletonextPath1View)
        
        skeletonextPath1View.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skeletonextPath1View.widthAnchor.constraint(equalToConstant: 50),
            skeletonextPath1View.heightAnchor.constraint(equalToConstant: 51),
            skeletonextPath1View.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            skeletonextPath1View.leftAnchor.constraint(equalTo: skeletonextPathView.rightAnchor, constant: 9),
        ])
        
        // Setup the gradient layer for shimmer effect
        skeletonextPath1ViewGradient.colors = [UIColor.lightGray.cgColor, UIColor.white.cgColor, UIColor.lightGray.cgColor]
        skeletonextPath1ViewGradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        skeletonextPath1ViewGradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        skeletonextPath1ViewGradient.locations = [0.0, 0.5, 1.0]
        skeletonextPath1ViewGradient.frame = skeletonextPath1View.bounds
        skeletonextPath1ViewGradient.add(createShimmerAnimation(), forKey: "shimmer")
        skeletonextPath1View.layer.addSublayer(skeletonextPath1ViewGradient)
    }
    
    private func createShimmerAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.0, 0.25]
        animation.toValue = [0.75, 1.0, 1.0]
        animation.duration = 1.5
        animation.repeatCount = .infinity
        return animation
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        skeletonIdViewGradient.frame = skeletonIdView.bounds
        skeletonNameViewGradient.frame = skeletonNameView.bounds
        skeletonextPathViewGradient.frame = skeletonextPathView.bounds
        skeletonextPath1ViewGradient.frame = skeletonextPath1View.bounds
    }
}
