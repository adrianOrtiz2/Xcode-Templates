//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private weak var firstResponder:UIView?
private var keyboardRect:CGRect?

protocol KeyboardProtocol {
    
    func registerKeyBoardNotifications()
    func removeKeyBoardNotifications()

}

extension KeyboardProtocol where Self:UIViewController {
    
    private func animate(kbRect: CGRect?, firstResponder: UIView) {
        
        guard let kbRect = kbRect else {
            return
        }
        
        let kbSize = kbRect.size
        var aRect = self.view.frame
        aRect.size.height -= (kbSize.height)
        
        let translatedRect = firstResponder.convert(kbRect, from: nil)
        
        if translatedRect.intersects(firstResponder.bounds) {
            UIView.animate(withDuration: 0.25) {
                self.view.frame.origin.y -= kbSize.height
            }
        }
    }
    
    func registerKeyBoardNotifications() {
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(forName: Notification.Name.UITextFieldTextDidBeginEditing, object: nil, queue: nil) {[weak self] (notification) in
            guard let _self = self,
                let responder = notification.object as? UIView else {
                return
            }
            firstResponder = responder
            _self.animate(kbRect: keyboardRect, firstResponder: responder)
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: nil) { [weak self](notification) in
            guard let _self = self,
                let responder = firstResponder,
                let userInfo  = notification.userInfo,
                let kbRectValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
                    return
            }
            keyboardRect = kbRectValue.cgRectValue
            
            _self.animate(kbRect: keyboardRect, firstResponder: responder)
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: nil) { [weak self](notification) in
            guard let _self = self else {
                return
            }
            
            UIView.animate(withDuration: 0.25) {
                _self.view.frame.origin.y = 0
            }
        }
        
    }
    
    func removeKeyBoardNotifications() {
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
}
