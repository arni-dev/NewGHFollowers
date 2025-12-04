//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 20/1/2024.
//

import UIKit
import Combine

/// FavoritesListVC 类：收藏列表视图控制器
/// 显示用户收藏的 GitHub 用户列表，支持删除和点击查看详情
/// 继承自 GFDataLoadingVC 以获得加载指示器和空状态视图功能
class FavoritesListVC: GFDataLoadingVC {
    /// Combine 订阅集合
    private var cancellables = Set<AnyCancellable>()

    /// 表格视图：懒加载配置
    lazy private(set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        // 移除多余的空单元格分割线
        tableView.removeExcessCells()
        // 注册自定义单元格
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        return tableView
    }()

    /// 协调器的弱引用
    weak var coordinator: FavoriteListCoordinator?
    /// 视图模型
    private var viewModel: FavoriteListViewModel

    /// 初始化方法
    /// - Parameter viewModel: 收藏列表视图模型
    init(viewModel: FavoriteListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    /// 从 Storyboard/XIB 初始化时调用
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 视图加载完成后调用
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        
        // 添加表格视图
        view.addSubview(tableView)
        // 设置数据绑定
        setupBindings()
    }

    /// 视图即将显示时调用
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 每次显示时刷新数据
        getFavorites()
    }

    /// 配置视图控制器
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "favorites.title".localized
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    /// 更新内容不可用配置（iOS 17+）
    /// 处理空状态显示
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if viewModel.favorites.isEmpty {
            // 没有收藏时显示空状态
            var config =  UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "star")
            config.text = "favorites.noFavorites".localized
            config.secondaryText = "favorites.noFavoritesMessage".localized
            contentUnavailableConfiguration = config
        } else {
            // 有内容时清空配置
            contentUnavailableConfiguration = nil
        }
    }

    /// 设置 Combine 数据绑定
    private func setupBindings() {
        cancellables =  [
            // 监听收藏列表变化
            viewModel.$favorites
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self]  in
                    // 更新 UI
                    self?.updateUI(with: $0)
                })
        ]
    }

    /// 获取收藏列表数据
    func getFavorites() {
        Task {
            do {
                try await viewModel.retrieveFavorites()
            } catch {
                if let gfError = error as? GFError {
                    DispatchQueue.main.async {
                    self.presentGFAlert(title: "alert.somethingWentWrong".localized, message: gfError.rawValue, buttonTitle: "alert.ok".localized)
                    }
                }
            }
        }
    }

    /// 更新 UI
    /// - Parameter favorites: 收藏列表数据
    func updateUI(with favorites: [Follower]) {
        // 触发空状态检查
        setNeedsUpdateContentUnavailableConfiguration()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            // 确保表格视图在最上层（避免被空状态视图遮挡）
            self.view.bringSubviewToFront(self.tableView)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    /// 返回行数
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.favorites.count
    }

    /// 配置单元格
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoriteCell.reuseID
        ) as? FavoriteCell {
            let favorite = viewModel.favorites[indexPath.row]
            cell.set(favorite: favorite)
            return cell
        }
        return UITableViewCell()
    }

    /// 处理行点击事件
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let favorite = viewModel.favorites[indexPath.row]
        // 导航到该用户的关注者列表
        coordinator?.routeToFollowerListVC(username: favorite.login)
    }

    /// 处理滑动删除
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        
        let favorite = viewModel.favorites[indexPath.row]
        
        Task {
            do {
                // 从持久化存储中移除
                try await viewModel.remove(favorite: favorite)
                // 从数据源中移除
                self.viewModel.favorites.remove(at: indexPath.row)
                // 从表格视图中移除行
                self.tableView.deleteRows(at: [indexPath], with: .left)
                // 更新空状态
                setNeedsUpdateContentUnavailableConfiguration()

            } catch {
                if let gfError = error as? GFError {
                    DispatchQueue.main.async {
                        self.presentGFAlert(
                            title: "favorites.unableToRemove".localized,
                            message: gfError.rawValue,
                            buttonTitle: "alert.ok".localized
                        )
                    }
                }
            }
        }
    }
}
