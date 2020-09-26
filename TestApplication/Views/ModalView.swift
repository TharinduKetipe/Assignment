//
//  ModalView.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 9/26/20.
//  Copyright © 2020 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit

class ModalView: UIView {
    
    public var btnClose = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect.zero
        initializeUI()
        createConstraints()
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeUI() {
        self.backgroundColor = UIColor.white
        addSubview(btnClose)
    }
    
    private func setUI() {
        self.btnClose.setImage(UIImage(named: "close"), for: .normal)
        
    }
    
    private func createConstraints() {
        
        btnClose.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(30)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
    }
}

