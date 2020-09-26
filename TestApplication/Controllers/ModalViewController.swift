//
//  ModalViewController.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 9/27/20.
//  Copyright © 2020 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
     var btnClose:UIButton!
    
    var contentView: ModalView {
          return view as! ModalView
      }
      
      override func loadView() {
          view = ModalView()
        configUi()
      }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configUi() {
        self.btnClose = contentView.btnClose
        self.btnClose.addTarget(self, action:#selector(self.didTapClose), for: .touchUpInside)
    }
    
}

// MARK: Handle Button Actions
extension ModalViewController {
    
    @objc func didTapClose()  {
        self.dismiss(animated: true, completion: nil)
    }
    
}
