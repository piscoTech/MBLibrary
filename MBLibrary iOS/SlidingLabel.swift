//
//  SlidingLabel.swift
//  MBLibrary
//
//  Created by Marco Boschi on 26/07/15.
//  Copyright © 2015 Marco Boschi. All rights reserved.
//

import UIKit
import QuartzCore

public class SlidingLabel: UIView, Animatable {
	
	private var animationInitialized = false
	
	private var innerView: UILabel!
	private var hCenter: NSLayoutConstraint!
	private var fadePositions: [CGFloat] = []
	private var fadeMarginMask: CAGradientLayer!
	
	private let fadingSpace: CGFloat = 10
	private let slidingSpeed: TimeInterval = 20
	
	public convenience init() {
		self.init(frame: CGRect.zero)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		commonInit()
	}
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		
		commonInit()
	}
	
	private func commonInit() {
		self.clipsToBounds = true
		
		//Setting inner label
		innerView = UILabel()
		innerView.textAlignment = .center
		innerView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(innerView)
		
		let top = NSLayoutConstraint(item: innerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
		let bottom = NSLayoutConstraint(item: innerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
		hCenter = NSLayoutConstraint(item: innerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
		top.isActive = true
		bottom.isActive = true
		hCenter.isActive = true
		
		//Fading margin
		fadeMarginMask = CAGradientLayer()
		let transp = UIColor(white: 1, alpha: 0).cgColor
		let opaque = UIColor(white: 1, alpha: 1).cgColor
		fadeMarginMask.colors = [transp, opaque, opaque, transp]
		fadeMarginMask.startPoint = CGPoint(x: 0, y: 0)
		fadeMarginMask.endPoint = CGPoint(x: 1, y: 0)
		setFadeMaskFrame()
	}
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		
		if skipLayoutCheck {
			skipLayoutCheck = false
			viewAnimated = false
			return
		}
		
		manageSubviews()
		
		viewAnimated = false
	}
	
	private func setFadeMaskFrame() {
		fadeMarginMask.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
		let w = self.frame.width
		let pos = fadingSpace / w
		fadePositions = [0, pos, 1 - pos, 1]
		fadeMarginMask.locations = fadePositions
	}
	
	private func manageSubviews() {
		if !animationInitialized {
			animationInitialized = true
			
			//Starting animation
			self.layer.mask = fadeMarginMask
			if innerView.frame.width > self.frame.width {
				hCenter.constant = initialPos
				layoutIfNeeded()
			} else {
				hideMask()
			}
		} else {
			if !viewAnimated || !animating {
				setFadeMaskFrame()
				innerView.layer.removeAllAnimations()
				
				restartAnimation()
			}
		}
	}
	
	// MARK: - Animation
	
	private var dontAnimate = false
	private var viewAnimated = false
	private var animating = false
	
	private var maskActive = true
	private var skipLayoutCheck = false
	
	private var initialPos: CGFloat {
		get {
			if innerView.frame.width <= self.frame.width {
				return 0
			} else {
				return (innerView.frame.width - self.frame.width) / 2 + fadingSpace
			}
		}
	}
	
	private var finalPos: CGFloat {
		get {
			return -initialPos
		}
	}
	
	private func goRight() {
		if !animating {
			return
		}
		
		let end = finalPos
		UIView.animate(withDuration: animationTime(hCenter.constant, end: end), animations: { () -> Void in
			self.skipLayoutCheck = true
			self.hCenter.constant = end
			self.layoutIfNeeded()
			}) { (completed) in
				self.viewAnimated = completed
				self.animating = completed
				if completed {
					self.goLeft()
				} else {
					self.manageSubviews()
				}
		}
	}
	
	private func goLeft() {
		if !animating {
			return
		}
		
		let end = initialPos
		UIView.animate(withDuration: animationTime(hCenter.constant, end: end), animations: { () -> Void in
			self.skipLayoutCheck = true
			self.hCenter.constant = end
			self.layoutIfNeeded()
			}) { (completed) in
				self.viewAnimated = completed
				self.animating = completed
				if completed {
					self.goRight()
				} else {
					self.manageSubviews()
				}
		}
	}
	
	private func animationTime(_ start: CGFloat, end: CGFloat) -> TimeInterval {
		return Double(abs(start - end)) / slidingSpeed
	}
	
	private func hideMask(_ animated: TimeInterval? = 0.25) {
		maskActive = false
		let hideBlock = {
			self.fadeMarginMask.locations = [0,0, 1,1]
		}
		
		if let time = animated {
			UIView.animate(withDuration: time, animations: hideBlock)
		} else {
			hideBlock()
		}
	}
	
	private func showMask(_ animated: TimeInterval? = 0.25) {
		maskActive = true
		let hideBlock = {
			self.fadeMarginMask.locations = self.fadePositions
		}
		
		if let time = animated {
			UIView.animate(withDuration: time, animations: hideBlock)
		} else {
			hideBlock()
		}
	}
	
	private func restartAnimation() {
		if animating || dontAnimate {
			return
		}
		
		let shouldRunAnimation = innerView.frame.width > self.frame.width
		animating = shouldRunAnimation
		let movingTime = animationTime(hCenter.constant, end: initialPos) / 20
		
		let maskTime: TimeInterval? = movingTime > 0 ? movingTime : nil
		if shouldRunAnimation {
			showMask(maskTime)
		} else {
			hideMask(maskTime)
		}
		
		if movingTime > 0 {
			UIView.animate(withDuration: movingTime, animations: { () -> Void in
				self.skipLayoutCheck = true
				self.hCenter.constant = self.initialPos
				self.layoutIfNeeded()
			}, completion: { (completed) -> Void in
				self.viewAnimated = completed
				if completed {
					self.goRight()
				}
			})
		} else if animating {
			goRight()
		}
	}
	
	public func startAnimation() {
		dontAnimate = false
		if animating {
			return
		}
		
		restartAnimation()
	}
	
	public func stopAnimation() {
		dontAnimate = true
		if !animating {
			return
		}
		
		innerView.layer.removeAllAnimations()
	}
	
	public func isAnimating() -> Bool {
		return animating
	}
	
	// MARK: - Label properties
	
	public var textColor: UIColor! {
		get {
			return innerView.textColor
		}
		set {
			innerView.textColor = newValue
		}
	}
	
	public var text: String? {
		get {
			return innerView.text
		}
		set {
			innerView.text = newValue
		}
	}
	
	public var font: UIFont! {
		get {
			return innerView.font
		}
		set {
			innerView.font = newValue
		}
	}
	
}
