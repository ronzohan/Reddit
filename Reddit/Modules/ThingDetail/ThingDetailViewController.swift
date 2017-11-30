//
//  ThingDetailViewController.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs
import RxSwift
import SnapKit
import UIKit

protocol ThingDetailPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func getThingDetail()
}

final class ThingDetailViewController: UIViewController, ThingDetailPresentable, ThingDetailViewControllable {
    /// The UIKit view representation of this view.
    public final var uiviewController: UIViewController { return self }

    weak var listener: ThingDetailPresentableListener?
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        
        return imageView
    }()
    
    lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        
        let fillerBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, 
                                              target: nil, 
                                              action: nil)
        let closeBarButton = UIBarButtonItem(title: "X", style: .plain, 
                                             target: self, 
                                             action: #selector(self.dismissHandler))
        toolbar.items = [fillerBarButton, closeBarButton]

        return toolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        setupSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        listener?.getThingDetail()
    }
    
    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    @objc func dismissHandler() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupSubviews() {
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(toolbar.snp.bottom)
            make.height.greaterThanOrEqualTo(100)
            make.leading.trailing.equalToSuperview()
        }
        
        let button = UIButton()
        button.setTitle("Clickadklsajldkjasdjaljksd", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(100)
            make.left.right.equalToSuperview()
        }
    }

    func setThingDetail(title: String) {
    }
}
