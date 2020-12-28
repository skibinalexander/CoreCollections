//
//  CCTableViewSwipeCell.swift
//  QRDynamic
//
//  Created by Skibin Alexander on 28.04.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

enum CCTablewViewSwipeState {
    case leftOpened
    case rightOpened
    case centered
}

enum CCTablewViewSide {
    case right
    case left
}

protocol CCTableViewSwipeCell: class, UIGestureRecognizerDelegate {
    var viewToApplyPanOn: UIView { get }
    var swipePan: UIPanGestureRecognizer! { get set }
    var swipeState: CCTablewViewSwipeState { get set }
    var workingSide: CCTablewViewSide? { get set }
    var lastDirection: CCTablewViewSide? { get set }
    var maxRightPan: CGFloat { get }
    var maxLeftPan: CGFloat { get }
    var rigthConstraint: NSLayoutConstraint! { get }
    var leftConstraint: NSLayoutConstraint! { get }
    
    func canContinue() -> Bool
    func showAction(_ show: Bool, onSide side: CCTablewViewSide, animated: Bool)
    func hideActions()
    func makePanToSwipe()
    func configurePanToSwipe()
    func handlePan(_ pan: UIPanGestureRecognizer)
}

extension CCTableViewSwipeCell {
    func configurePanToSwipe() {
        swipePan.delegate = self
        viewToApplyPanOn.addGestureRecognizer(swipePan)
    }
    
    func handlePan(_ pan: UIPanGestureRecognizer) {
        guard pan.state != .began else {
            return
        }
        
        let xTranslation = pan.translation(in: viewToApplyPanOn).x
        let isLeftDirection = xTranslation < 0
        let currentDirection: CCTablewViewSide = isLeftDirection ? .left : .right
        var modifiedXTranslation = xTranslation
        var shouldCancel = false
        var proposedStateOnCancel: CCTablewViewSwipeState?
        
        if isLeftDirection {
            if swipeState == .rightOpened {
                shouldCancel = true
                proposedStateOnCancel = .rightOpened
            } else if swipeState == .leftOpened {
                modifiedXTranslation = maxLeftPan + xTranslation
                shouldCancel = modifiedXTranslation <= 0
                proposedStateOnCancel = .centered
                workingSide = .left
            } else {
                modifiedXTranslation = xTranslation
                shouldCancel = -modifiedXTranslation > maxRightPan
                proposedStateOnCancel = .rightOpened
                workingSide = .right
            }
        } else {
            if swipeState == .rightOpened {
                modifiedXTranslation = -(maxRightPan - xTranslation)
                shouldCancel = modifiedXTranslation >= 0
                proposedStateOnCancel = .centered
                workingSide = .right
            } else if swipeState == .leftOpened {
                shouldCancel = true
                proposedStateOnCancel = .leftOpened
            } else {
                modifiedXTranslation = xTranslation
                shouldCancel = modifiedXTranslation > maxLeftPan
                proposedStateOnCancel = .leftOpened
                workingSide = .left
            }
        }
        
        if let direction = lastDirection {
            if direction != currentDirection {
                shouldCancel = true
                proposedStateOnCancel = swipeState
            }
        }
        
        if !canContinue() {
            shouldCancel = true
            proposedStateOnCancel = .centered
        }
        
        lastDirection = currentDirection
        
        switch pan.state {
        case .changed:
            if shouldCancel {
                pan.isEnabled = false
                pan.isEnabled = true
                
                if proposedStateOnCancel == .centered {
                    showAction(false, onSide: swipeState == .leftOpened ? .left : .right, animated: true)
                } else {
                    showAction(true, onSide: proposedStateOnCancel == .leftOpened ? .left : .right, animated: true)
                }
                
                swipeState = proposedStateOnCancel!
                workingSide = nil
                
                return
            }
            
            rigthConstraint.constant = -modifiedXTranslation
            leftConstraint.constant = modifiedXTranslation
            
            break
        case .ended, .cancelled, .failed:
            guard let side = workingSide else {
                return
            }
            
            let forcingToLeft = pan.velocity(in: viewToApplyPanOn).x < -500.0
            let forcingToRight = pan.velocity(in: viewToApplyPanOn).x > 500.0
            let sideRelatedConstraint = side == .left ? leftConstraint : rigthConstraint
            let edgeDistance = side == .left ? maxLeftPan * 0.5 : maxRightPan * 0.5
            let isSideOpenedEnough = sideRelatedConstraint!.constant > edgeDistance
            let swipeStateOnOpening: CCTablewViewSwipeState = side == .left ? .leftOpened : .rightOpened
            let shouldShowOnForce = side == .left ? !forcingToLeft && forcingToRight : forcingToLeft && !forcingToRight
            let isForcing = forcingToLeft || forcingToRight
            let isForcingToOpen = side == .left ? forcingToRight : forcingToLeft
            
            showAction(shouldShowOnForce || isSideOpenedEnough && !isForcing, onSide: side, animated: true)
            swipeState = isForcingToOpen || isSideOpenedEnough && !isForcing ? swipeStateOnOpening : .centered
            
            lastDirection = nil
            break
        default:
            break
        }
    }
    
    func showAction(_ show: Bool, onSide side: CCTablewViewSide, animated: Bool) {
        if side == .left {
            showLeftAction(show, animated: animated)
        } else {
            showRightAction(show, animated: animated)
        }
    }
    
    func showRightAction(_ show: Bool, animated: Bool = false) {
        rigthConstraint.constant = show ? maxRightPan : 0
        leftConstraint.constant = show ? -maxRightPan : 0
        
        if animated {
            animateWithSpring()
        }
        
        swipeState = show ? .rightOpened : .centered
    }
    
    func showLeftAction(_ show: Bool, animated: Bool = false) {
        rigthConstraint.constant = show ? -maxLeftPan : 0
        leftConstraint.constant = show ? maxLeftPan : 0
        
        if animated {
            animateWithSpring()
        }
        
        swipeState = show ? .leftOpened : .centered
    }
    
    func hideActions() {
        if swipeState == .leftOpened {
            showLeftAction(false, animated: true)
        } else if swipeState == .rightOpened {
            showRightAction(false, animated: true)
        }
        
        swipeState = .centered
    }
    
    private func animateWithSpring() {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            self.viewToApplyPanOn.layoutIfNeeded()
        }, completion: nil)
    }
}
