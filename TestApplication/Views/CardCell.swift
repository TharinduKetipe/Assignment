//
//  CardCell.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 9/26/20.
//  Copyright © 2020 Tharindu Ketipearachchi. All rights reserved.
//
import UIKit
import SnapKit

class CardCell: UITableViewCell {
    
    var imgView:UIImageView!
    var lblTitle:UILabel!
    var lblPayment:UILabel!
    var lblTime:UILabel!
    var bgView:UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.buildViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
         imgView.image = UIImage(named: "lodaing-thumb")
    }
    
    func buildViews(){
        self.imgView = UIImageView()
        self.lblTitle = UILabel()
        self.lblPayment = UILabel()
        self.lblTime = UILabel()
        self.bgView = UIView()
        
        addSubview(bgView)
        bgView.addSubview(imgView)
        bgView.addSubview(lblTitle)
        bgView.addSubview(lblPayment)
        bgView.addSubview(lblTime)
        
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(3)
            make.top.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(3)
            make.bottom.equalToSuperview().inset(3)
        }
        
        imgView.snp.makeConstraints { make in
            make.right.equalTo(0)
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(200)
        }
         imgView.contentMode = .scaleToFill
        
        lblTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.top.equalTo(imgView.snp.bottom).offset(20)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(30)
        }
        lblTitle.textColor = UIColor.darkGray
        lblTitle.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        lblPayment.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.top.equalTo(lblTitle.snp.bottom).offset(2)
            make.right.equalTo(lblTime.snp.left).offset(15)
            make.bottom.equalToSuperview().inset(8)
        }
        lblPayment.textColor = UIColor.gray
        lblPayment.font = UIFont.systemFont(ofSize: 13.0)
        lblPayment.numberOfLines = 1;
        lblPayment.minimumScaleFactor = 0.5
        lblPayment.adjustsFontSizeToFitWidth = true;
        
        lblTime.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(20)
            make.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(15)
        }
        lblTime.numberOfLines = 1;
        lblTime.minimumScaleFactor = 0.5
        lblTime.adjustsFontSizeToFitWidth = true;
        lblTime.font = UIFont.systemFont(ofSize: 13)
        lblTime.textColor = UIColor.lightGray
        lblTime.textAlignment = .right
    }
    
    func addUIEffects() {
        addShadow(view: bgView)
    }
    
    func configureCell(job:Job) {
        imgView.image = UIImage(named: "lodaing-thumb")
        if let image = job.image {
            if !(image.isEmpty) {
               ImageDownloader.shared.loadImage(url: image, imageView: imgView)
            }
        }
        lblTitle.text = job.title
        lblPayment.text = "Maximum earining €\(String(describing: job.maxEarnings!)) For an hour "
        lblTime.text = "\(String(describing: job.positions!)) Opens"
    }
    
    func addShadow(view:UIView) {
        view.backgroundColor = UIColor.white
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.25
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
}

extension UILabel {
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
        }
    }
}
