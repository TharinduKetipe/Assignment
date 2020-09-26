//
//  HomeView.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 9/26/20.
//  Copyright © 2020 Tharindu Ketipearachchi. All rights reserved.
//
import UIKit
import SnapKit

class HomeView: UIView {
    
    public var tableView = UITableView()
    public var collectionView:UICollectionView!
    public var footerView = UIView()
    public var floatingView = UIView()
    public var btnLogin = UIButton()
    public var btnSignUp = UIButton()
    public var btnFilter = UIButton()
    public var btnCart = UIButton()
    public var line = UIView()
    private var width = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect.zero
        initializeUI()
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeUI() {
        self.backgroundColor = UIColor.white
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.scrollDirection = .horizontal
        addFooterViewStyles()
        configureFooterView()
        configureFloatingView()
        addFloatingViewStyles()
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        self.collectionView.backgroundColor = UIColor.gray
        self.collectionView.showsHorizontalScrollIndicator = false
        self.tableView.backgroundColor = UIColor.white
        self.tableView.showsVerticalScrollIndicator = false
        footerView.addSubview(btnLogin)
        footerView.addSubview(btnSignUp)
        floatingView.addSubview(btnFilter)
        floatingView.addSubview(btnCart)
        floatingView.addSubview(line)
        addSubview(collectionView)
        addSubview(tableView)
        addSubview(footerView)
        addSubview(floatingView)
        self.width = Double(UIScreen.main.bounds.size.width)
    }
    
    private func addFooterViewStyles() {
        self.footerView.backgroundColor = UIColor.white
    }
    
    private func configureFooterView() {
        btnSignUp.setTitle("Sign up", for: .normal)
        btnLogin.setTitle("Log in", for: .normal)
        btnSignUp.backgroundColor = UIColor(hexString: "#15ff86")
        btnSignUp.layer.cornerRadius = 5
        btnSignUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        btnLogin.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        btnSignUp.setTitleColor(.black, for: .normal)
        btnLogin.setTitleColor(.black, for: .normal)
        btnLogin.backgroundColor = .white
        btnLogin.layer.cornerRadius = 5
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.borderColor = UIColor.black.cgColor
        
    }
    
    private func addFloatingViewStyles() {
        self.line.backgroundColor = .gray
        btnFilter.setTitle("Filter", for: .normal)
        btnCart.setTitle("Kaart", for: .normal)
        btnFilter.backgroundColor = .clear
        btnFilter.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        btnFilter.setTitleColor(.black, for: .normal)
        btnCart.backgroundColor = .clear
        btnCart.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        btnCart.setTitleColor(.black, for: .normal)
    }
    
    private func configureFloatingView() {
        self.floatingView.layer.cornerRadius = 20
        self.floatingView.backgroundColor = .white
        self.floatingView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.floatingView.layer.shadowRadius = 3
        self.floatingView.layer.shadowOpacity = 0.25
        self.floatingView.layer.shadowColor = UIColor.gray.cgColor
        self.floatingView.layer.shouldRasterize = true
        self.floatingView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    private func createConstraints() {
        
        footerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(5)
            make.height.equalTo(60)
            make.leftMargin.equalToSuperview().inset(0)
            make.rightMargin.equalToSuperview().inset(0)
        }
        
        btnSignUp.snp.makeConstraints { (make) in
            make.topMargin.equalToSuperview().inset(15)
            make.width.equalTo((self.width - 40)/2)
            make.leftMargin.equalToSuperview().inset(5)
            make.bottomMargin.equalToSuperview().inset(5)
        }
        
        btnLogin.snp.makeConstraints { (make) in
            make.topMargin.equalToSuperview().inset(15)
            make.width.equalTo(self.btnSignUp)
            make.rightMargin.equalToSuperview().inset(5)
            make.bottomMargin.equalToSuperview().inset(5)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(25)
            make.height.equalTo(60)
            make.leftMargin.equalToSuperview().inset(0)
            make.rightMargin.equalToSuperview().inset(0)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.collectionView.snp.bottom).offset(5)
            make.bottomMargin.equalTo(self.footerView.snp.top).offset(5)
            make.leftMargin.equalToSuperview().inset(10)
            make.rightMargin.equalToSuperview().inset(10)
        }
        
        floatingView.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(100)
            make.leftMargin.equalToSuperview().inset(100)
            make.rightMargin.equalToSuperview().inset(100)
        }
        
        line.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.bottomMargin.equalToSuperview().inset(5)
            make.top.equalToSuperview().inset(5)
            make.centerX.equalToSuperview().inset(0)
        }
        
        btnFilter.snp.makeConstraints { (make) in
            make.bottomMargin.equalToSuperview().inset(3)
            make.top.equalToSuperview().inset(3)
            make.left.equalToSuperview().inset(10)
            make.right.equalTo(self.line.snp.left).offset(5)
        }
        
        btnCart.snp.makeConstraints { (make) in
            make.bottomMargin.equalToSuperview().inset(3)
            make.top.equalToSuperview().inset(3)
            make.right.equalToSuperview().inset(10)
            make.left.equalTo(self.line.snp.right).offset(5)
        }
    }
}

