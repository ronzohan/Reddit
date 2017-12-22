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

final class ThingDetailViewController<T: UIView>: UIViewController, ThingDetailPresentable, ThingDetailViewControllable {
    /// The UIKit view representation of this view.
    public final var uiviewController: UIViewController { return self }

    weak var listener: ThingDetailPresentableListener?
    
    private lazy var linkView: LinkView<T> = {
        let view = LinkView<T>()
        
        return view
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
    
    func setupSubviews() {
        view.addSubview(linkView)
        linkView.metaLabel.text = "Fuck you"
        linkView.titleLabel.text = "Fuck you too"
        linkView.backgroundColor = UIColor.red
        linkView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeArea.top)
            make.left.equalTo(view.safeArea.left)
            make.right.equalTo(view.safeArea.right)
        }
    }

    func setThingDetail(title: String) {
    }
}
