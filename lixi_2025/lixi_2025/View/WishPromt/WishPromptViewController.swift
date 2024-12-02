//
//  WishPromptViewController.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 30/11/24.
//

import UIKit
import RxSwift

class WishPromptViewController: UIViewController, BindableType {
    typealias ViewModelType = WishPromtVMProtocol
    
    //MARK: - Subviews
    private lazy var navigationLeftView: WishPromtNavigationLeftView = {
        let view = WishPromtNavigationLeftView()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.bounces = false
        tableView.estimatedRowHeight = 84
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        if #available(iOS 15.0, *) {
            tableView.sectionFooterHeight = 0
        }
        return tableView
    }()
    
    private lazy var displayIdeaVC: DisplayIdeaViewController = {
        let vc = DisplayIdeaViewController()
        let displayIdeaVM = DisplayIdeaViewModel()
        vc.bindViewModel(to: displayIdeaVM)
        return vc
    }()
    
    //MARK: - Properties
    var viewModel: WishPromtVMProtocol!
    private let disposeBag = DisposeBag()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        layout()
    }
    
    //MARK: - Helpers
    func bindViewModel() {
        navigationLeftView.buttonTapped.subscribe(onNext: { [weak self] _ in
            self?.viewModel.onDismiss()
        }).disposed(by: disposeBag)
        
        viewModel.sampleWishes.bind(to: displayIdeaVC.viewModel.samplesToDisplay).disposed(by: disposeBag)
        
        viewModel.isGeneratingWishes.subscribe(onNext: { [weak self] isGenerating in
            if isGenerating{
                // change title of creating -> editing
                // remove sample
                
            }else{
                
            }
            
        }).disposed(by: disposeBag)
        
        viewModel.getSampleWishes()
    }
    
}

//MARK: - WishPromptViewController
private extension WishPromptViewController {
    
    func configNavBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.shadowImage = UIImage()
        appearance.shadowColor = UIColor.clear
        appearance.backgroundImage = UIImage()
        appearance.backgroundColor = UIColor.white
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        let leftNaviButton = UIBarButtonItem(customView: navigationLeftView)
        self.navigationItem.leftBarButtonItem = leftNaviButton
    }
    
    func configTableView(){
        tableView.register(WishMessageIdeaDisplayTableViewCell.self, forCellReuseIdentifier: WishMessageIdeaDisplayTableViewCell.identifier)
        tableView.register(WishMessageComponentsTableViewCell.self, forCellReuseIdentifier: WishMessageComponentsTableViewCell.identifier)
        tableView.register(WishMessageLiteraryTypeTableViewCell.self, forCellReuseIdentifier: WishMessageLiteraryTypeTableViewCell.identifier)
        tableView.register(WishMessageCreationTableViewCell.self, forCellReuseIdentifier: WishMessageCreationTableViewCell.identifier)
        
    }
    
    func setupUI(){
        configNavBar()
        configTableView()
    }
    
    func layout(){
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
}

extension WishPromptViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let ideaCellHeight = self.view.frame.height - (WishMessageComponentsTableViewCell.cellHeight * 3 + WishMessageComponentsTableViewCell.topPaddingAtRecipientCell + WishMessageLiteraryTypeTableViewCell.cellHeight + WishMessageCreationTableViewCell.cellHeight)
        // need plus top padding of WishMessageComponentsTableViewCell type recipient
        let promptRowType = WishPromtViewModel.WishPromtType.allCases[indexPath.row]
        switch promptRowType{
        case .ideaDisplay:
            return ideaCellHeight
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}

extension WishPromptViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = viewModel.numberOfRowsInSection(section)
        return numberOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let promptRowType = WishPromtViewModel.WishPromtType.allCases[indexPath.row]
        switch promptRowType{
        case .ideaDisplay:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WishMessageIdeaDisplayTableViewCell.identifier, for: indexPath) as? WishMessageIdeaDisplayTableViewCell else{
                return UITableViewCell()
            }
            
            addChild(displayIdeaVC)
            displayIdeaVC.willMove(toParent: self)
            displayIdeaVC.view.frame = cell.mainView.bounds
            cell.mainView.addSubview(displayIdeaVC.view)
            displayIdeaVC.didMove(toParent: self)
            
            return cell
        case .recipient, .wishMessage, .aiSuggestion:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WishMessageComponentsTableViewCell.identifier, for: indexPath) as? WishMessageComponentsTableViewCell else{
                return UITableViewCell()
            }
            cell.updateUI(withComponents: promptRowType)
            return cell
        case .literaryTypes(_):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WishMessageLiteraryTypeTableViewCell.identifier, for: indexPath) as? WishMessageLiteraryTypeTableViewCell else{
                return UITableViewCell()
            }
            return cell
        case .actions(_):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WishMessageCreationTableViewCell.identifier, for: indexPath) as? WishMessageCreationTableViewCell else{
                return UITableViewCell()
            }
            cell.creationButtonTapped.bind(to: self.viewModel.creationButtonTapped).disposed(by: disposeBag)
            return cell
        }
    }
    
}
