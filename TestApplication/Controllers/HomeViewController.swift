//
//  HomeViewController.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 9/26/20.
//  Copyright © 2020 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import SnapKit
import MKProgress
import SwiftyJSON
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    var jobs: BehaviorRelay<[Job]> =  BehaviorRelay(value: [])
    var dates: BehaviorRelay<[String]> =  BehaviorRelay(value: [])
    
    var collectionIndex:Int = 0
    var currenCollectionIndex:Int = 0
    
    var tableView:UITableView!
    var collectionView:UICollectionView!
    var btnLogin:UIButton!
    var btnSignUp:UIButton!
    var btnFilter:UIButton!
    var btnCart:UIButton!
    
    var contentView: HomeView {
        return view as! HomeView
    }
    
    override func loadView() {
        view = HomeView()
        configureTableView()
        configureCollectionView()
        configureButtonActions()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipeGestures()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }
}

// MARK: UI Configure Methods
extension HomeViewController {
    
    func configureTableView()  {
        tableView = contentView.tableView
        tableView.allowsSelection = false
        tableView.rowHeight = 300.0
        tableView.register(CardCell.self, forCellReuseIdentifier: "CardCell")
        tableView.separatorStyle = .none
    }
    
    func configureCollectionView()  {
        collectionView = contentView.collectionView
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: "DateCell")
        collectionView.backgroundColor = UIColor.white
    }
    
    func configureButtonActions() {
        self.btnLogin = contentView.btnLogin
        self.btnSignUp = contentView.btnSignUp
        self.btnFilter = contentView.btnFilter
        self.btnCart = contentView.btnCart
        btnLogin.addTarget(self, action:#selector(self.didTapLogin), for: .touchUpInside)
        btnSignUp.addTarget(self, action:#selector(self.didTapSignUp), for: .touchUpInside)
        btnFilter.addTarget(self, action:#selector(self.didTapFilter), for: .touchUpInside)
        btnCart.addTarget(self, action:#selector(self.didTapCart), for: .touchUpInside)
    }
    
    func addSwipeGestures() {
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            handleSwipeNavigation(swipeDirection: Utilities.SwipeDirection.rightSwipe)
        }
        else if gesture.direction == .left {
            handleSwipeNavigation(swipeDirection: Utilities.SwipeDirection.leftSwipe)
        }
    }
}

// MARK: Rx Data Binding Methods
extension HomeViewController {
    
    private func setupBindings() {
        
        viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .dataError(let message):
                    Utilities .AlertWithOkAction(view: self, title: "Error", message: message)
                case .otherError(let message):
                    Utilities .AlertWithOkAction(view: self, title: "Error", message: message)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel
            .dates
            .observeOn(MainScheduler.instance)
            .bind(to: dates)
            .disposed(by: disposeBag)
        
        viewModel
            .jobs
            .observeOn(MainScheduler.instance)
            .bind(to: jobs)
            .disposed(by: disposeBag)
        
        jobs.bind(to: tableView.rx.items(cellIdentifier: "CardCell", cellType: CardCell.self)) { row, job, cell in
            cell.configureCell(job: job)
            cell.addUIEffects()
        }.disposed(by: disposeBag)
        
        dates.bind(to: collectionView.rx.items(cellIdentifier: "DateCell", cellType: DateCell.self)) { row, date, cell in
            cell.cellIndex = self.collectionIndex
            cell.configureCell(date: date, index: row)
        }.disposed(by: disposeBag)
        
        collectionView.rx.itemSelected.subscribe(onNext:{ [weak self] indexPath in
            self?.currenCollectionIndex = indexPath.row
            self?.shiftDate(index: indexPath.row)
            self?.collectionIndex = indexPath.row
            self?.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }
}

// MARK: Handle Swipe Actions
extension HomeViewController {
    
    func shiftDate(index:Int){
        let newDate = viewModel.dates.value[index]
        let newData = viewModel.dataMap[newDate]
        viewModel.jobs.accept((newData)!)
    }
    
    func handleSwipeNavigation(swipeDirection:Utilities.SwipeDirection) {
        var newIndex = currenCollectionIndex
        if swipeDirection == Utilities.SwipeDirection.leftSwipe {
            if currenCollectionIndex + 1 < viewModel.dates.value.count {
                newIndex = currenCollectionIndex + 1
            }
        } else if swipeDirection == Utilities.SwipeDirection.rightSwipe {
            if currenCollectionIndex - 1 >= 0 {
                newIndex = currenCollectionIndex - 1
            }
        }
        currenCollectionIndex = newIndex
        shiftDate(index: newIndex)
        collectionIndex = newIndex
        collectionView.reloadData()
        collectionView.scrollToItem(at:IndexPath(item: newIndex, section: 0), at: .centeredHorizontally, animated: false)
    }
}

// MARK: Handle Button Actions
extension HomeViewController {
    
    @objc func didTapLogin()  {
        let modal = ModalViewController()
        modal.modalPresentationStyle = .fullScreen
        self.present(modal, animated: true, completion: nil)
    }
    
    @objc func didTapSignUp() {
        let modal = ModalViewController()
        modal.modalPresentationStyle = .fullScreen
        self.present(modal, animated: true, completion: nil)
    }
    
    @objc func didTapFilter() {
        
    }
    
    @objc func didTapCart() {
        
    }
}

