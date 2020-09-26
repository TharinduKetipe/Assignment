//
//  DateCell.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 9/26/20.
//  Copyright © 2020 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import SnapKit

class DateCell: UICollectionViewCell {
    
    var lblTitle:UILabel!
    var bgView:UIView!
    public var cellIndex:Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildViews()
        addUIEffects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.buildViews()
        addUIEffects()
    }
    
    func buildViews(){
        
        self.bgView = UIView()
        self.lblTitle = UILabel()

        addSubview(bgView)
        bgView.addSubview(lblTitle)

        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(2)
            make.top.equalToSuperview().inset(2)
            make.right.equalToSuperview().inset(2)
            make.bottom.equalToSuperview().inset(2)
        }

        lblTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(2)
            make.top.equalToSuperview().inset(2)
            make.right.equalToSuperview().inset(2)
            make.bottom.equalToSuperview().inset(2)
        }
        lblTitle.textColor = UIColor.darkGray
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
    
    func addUIEffects() {
        addShadow(view: bgView)
    }
    
    func configureCell(date:String, index:Int) {
        let date = date.dateFromIsoString()
        lblTitle.text = date.toString(dateFormat: "d MMM")
        if cellIndex == index {
            bgView.backgroundColor = UIColor(hexString: "#6260ab")
            lblTitle.textColor = UIColor.white
        } else {
            bgView.backgroundColor = UIColor.white
            lblTitle.textColor = UIColor.darkGray
        }
    }
    
    func addShadow(view:UIView) {
        view.backgroundColor = UIColor.purple
        view.layer.cornerRadius = 15
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.25
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
}
