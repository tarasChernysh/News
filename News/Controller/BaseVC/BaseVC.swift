//
//  BaseVC.swift
//  News
//
//  Created by Taras Chernysh on 10/12/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import UIKit
import ReactiveSwift

class BaseVC: UIViewController {
    enum C {
        static let activityAnimationDuration: TimeInterval = 0.25
        static let activityGraceTime: TimeInterval = 0.1
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var activityOffset: CGFloat {
        return centerOffset
    }
    
    var centerOffset: CGFloat {
        return 0
    }
    
    // MARK: - Activity
    
    private lazy var activityView = makeActivityView()
    
    func makeActivityView() -> ActivityView {
        let activityView = ActivityView(frame: view.bounds)
        activityView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activityView.alpha = 0
        view.addSubview(activityView)
        return activityView
    }
    
    func showActivity(animated: Bool = true) {
        let duration: TimeInterval = animated ? C.activityAnimationDuration : 0
        let delay: TimeInterval = animated ? C.activityGraceTime : 0
        activityView.centerY?.constant = activityOffset
        UIView.animate(withDuration: duration, delay: delay, options: .beginFromCurrentState, animations: {
            self.activityView.alpha = 1.0
            self.activityView.isAnimating = true
        }, completion: nil)
    }
    
    func hideActivity(animated: Bool = true) {
        let duration: TimeInterval = animated ? C.activityAnimationDuration : 0
        UIView.animate(withDuration: duration, delay: 0.0, options: .beginFromCurrentState, animations: {
            self.activityView.alpha = 0.0
        }, completion: nil)
    }
    
    // MARK: - Alert
    
    func showErrorAlert(_ error: AppError) {
        guard shouldShowAlert(for: error) else { return }
        
        let controller = UIAlertController(title: "Oops!",
                                           message: error.description,
                                           preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK",
                                           style: .default,
                                           handler: nil))
        present(controller, animated: true, completion: nil)
    }
    
    func shouldShowAlert(for error: Error) -> Bool {
        return true
    }
    
    func showAlert(withTitle title: String, message: String, actions: [UIAlertAction]? = nil) {
        guard presentedViewController == nil else {
            return
        }
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(okAction)
        actions?.forEach { action in
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
}


extension Reactive where Base: BaseVC {
    var activity: BindingTarget<Bool> {
        return makeBindingTarget { base, isExecuting in
            if isExecuting {
                base.showActivity()
            } else {
                base.hideActivity()
            }
        }
    }
    
    var errors: BindingTarget<AppError> {
        return makeBindingTarget { base, error in
            base.showErrorAlert(error)
        }
    }
    
    var endListNews: BindingTarget<AlertViewModel?> {
        return makeBindingTarget { base, value in
            base.showAlert(withTitle: value?.title ?? "", message: value?.message ?? "")
        }
    }
}
