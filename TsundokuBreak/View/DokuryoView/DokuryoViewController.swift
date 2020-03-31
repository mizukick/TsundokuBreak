//
//  DokuryoViewController.swift
//  DokuryoBreak
//
//  Created by Mizuki Kubota on 2020/03/31.
//  Copyright © 2020 MizukiKubota. All rights reserved.
//

import UIKit

class DokuryoViewController: UIViewController, Injectable {

    typealias Dependency = DokuryoViewModelType
    private let viewModel: DokuryoViewModelType

    required init(with dependency: Dependency) {
        viewModel = dependency
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}

extension DokuryoViewController {
    static func makeVC () -> DokuryoViewController {
        let model = DokuryoModel(with: DokuryoModel.Dependency.init())
        let viewModel =  DokuryoViewModel(with: model)
        let viewControler =  DokuryoViewController(with: viewModel)
        return viewControler
    }
}
