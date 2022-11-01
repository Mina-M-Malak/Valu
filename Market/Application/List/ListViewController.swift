//
//  ListViewController.swift
//  Market
//
//  Created by Mina Malak on 30/10/2022.
//
import UIKit
import MessageUI
import RxSwift
import RxCocoa
import RxDataSources
import RxSwiftExt
import RxOptional

final class ListViewController: UIViewController {
    
    typealias ViewModelType = ListViewModel
    
    private static let cellIdentifier: String = "ListCellIdentifier"
    
    private let viewModel: ViewModelType
    var disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = createTableView()
    private lazy var searchBar: UISearchBar = createSearchBar()
    private lazy var pullToRefresh: UIRefreshControl = createPullToRefresh()
    
    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disposeBag = DisposeBag()
        
        setupUI()
        setupAutoLayout()
        
        rx.viewWillAppearObservable
            .take(1)
            .map({ (_) -> Void in
                return
            })
            .bind(to: viewModel.fetchAction)
            .disposed(by: disposeBag)
        
        pullToRefresh.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.fetchAction)
            .disposed(by: disposeBag)
        
        searchBar.rx.text
            .debounce(.milliseconds(250),
                      scheduler: MainScheduler.instance)
            .filterNil()
            .distinctUntilChanged()
            .bind(to: viewModel.searchTerm)
            .disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [weak self] () in
                self?.searchBar.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] () in
                self?.searchBar.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        viewModel.data
            .subscribe()
            .disposed(by: disposeBag)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<ListSection>(configureCell: { [unowned self] (dataSource, tableView, indexPath, item) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).cellIdentifier,
                                                           for: indexPath) as? ListCell
                else {
                fatalError("Couldn't create custom cell")
            }
            cell.configure(with: item)
            return cell
        })
        
        let data = viewModel.data.share(replay: 1, scope: .forever)
        data
            .map({ (data) -> [ListSection] in
                return [ListSection(items: data)]
            })
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        if let backgroundView = tableView.backgroundView {
            data
                .map({ (data) -> CGFloat in
                    return data.isEmpty ? 1.0 : 0.0
                })
                .distinctUntilChanged()
                .bind(to: backgroundView.rx.alpha)
                .disposed(by: disposeBag)
        }
        data
            .filterEmpty()
            .delay(.seconds(0), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (_) in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.error
            .subscribe(onNext: { [weak self] (error) in
                self?.showAlert(with: "Error", message: error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .bind(to: pullToRefresh.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(ViewModelType.ModelType.self)
            .subscribe(onNext: { [weak self] (item) in
                // go to details
                self?.didSelect(item: item)
            })
            .disposed(by: disposeBag)
        
    }
    
}

//MARK: - List UI
extension ListViewController {
    
    private func createTableView() -> UITableView {
        let tableView = UITableView(frame: .zero,
                                    style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(ListCell.self,
                           forCellReuseIdentifier: type(of: self).cellIdentifier)
        return tableView
    }

    private func createSearchBar() -> UISearchBar {
        let searchBar = UISearchBar(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: tableView.bounds.width,
                                                  height: 50))
        searchBar.tintColor = .white
        searchBar.searchBarStyle = .default
        searchBar.backgroundColor = .appColor
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .darkText
        searchBar.setBackgroundImage(UIColor.appColor.image(), for: .any, barMetrics: .default)
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Start searching..."
        searchBar.keyboardType = .default
        searchBar.autocorrectionType = .no
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    private func createPullToRefresh() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return refreshControl
    }
    
    private func createEmptyBackgroundView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "No data"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leftAnchor.constraint(lessThanOrEqualTo: view.leftAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 10).isActive = true
        
        return view
    }
    
    // MARK: setup UI & autolayout
    private func setupUI() {
        view.backgroundColor = .appColor
        
        view.addSubview(tableView)
        tableView.tableHeaderView = searchBar
        tableView.backgroundView = createEmptyBackgroundView()
        tableView.tableFooterView = UIView()
        tableView.addSubview(pullToRefresh)
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        
    }
    
    private func setupAutoLayout() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

//MARK: - Alerts
extension ListViewController {
    
    private func showAlert(with title: String,
                           message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}

extension ListViewController {
    
    private func didSelect(item: ViewModelType.ModelType) {
        let vc = ProductDetailsViewController(model: item)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
