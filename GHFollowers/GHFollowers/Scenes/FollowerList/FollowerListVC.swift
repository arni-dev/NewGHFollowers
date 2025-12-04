//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 21/1/2024.
//

import UIKit
import Combine

/// FollowerListVC 类：关注者列表视图控制器
/// 负责显示用户的关注者列表，支持搜索、分页加载和收藏功能
/// 继承自 GFDataLoadingVC 以获得加载指示器和空状态视图功能
class FollowerListVC: GFDataLoadingVC {
    /// Combine 订阅集合，用于管理数据绑定的生命周期
    private var cancellables = Set<AnyCancellable>()

    /// 集合视图的数据源部分枚举
    enum Section {
        case main
    }

    /// 集合视图：用于网格显示关注者
    var collectionView: UICollectionView!
    /// 集合视图数据源：使用 Diffable Data Source 管理数据
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    /// 协调器的弱引用，用于导航
    weak var coordinator: FollowerListCoordinator?
    /// 视图模型，处理业务逻辑
    private var viewModel: FollowerListViewModel

    /// 初始化方法
    /// - Parameter viewModel: 关注者列表视图模型
    init(viewModel: FollowerListViewModel) {
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

        // 设置数据绑定
        setupBindings()

        // 配置 UI 和数据源
        configureViewController()
        configureCollectionView()
        configureSearchController()
        configureDataSource()

        // 获取关注者数据
        getFollowers()
    }

    /// 视图即将显示时调用
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 显示导航栏
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    /// 更新内容不可用配置（iOS 17+ 新特性）
    /// 用于处理空状态和搜索无结果的情况
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if viewModel.followers.isEmpty && !viewModel.isLoadingMoreFollowers {
            // 没有关注者时
            navigationItem.searchController = nil
            var config =  UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "person.slash")
            config.text = "followerList.noFollowers".localized
            config.secondaryText = "followerList.noFollowersMessage".localized
            contentUnavailableConfiguration = config
        } else if viewModel.isSearching && viewModel.filterFollowers.isEmpty {
            // 搜索无结果时
            contentUnavailableConfiguration = UIContentUnavailableConfiguration.search()
        } else {
            // 有内容时
            contentUnavailableConfiguration = nil
        }
    }

    /// 设置 Combine 数据绑定
    private func setupBindings() {
        cancellables = [
            // 监听关注者列表和过滤列表的变化
            viewModel.$followers
                .combineLatest(viewModel.$filterFollowers)
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] followers, filterFollowers in
                    guard let self = self else { return }
                    // 根据是否正在搜索更新 UI
                    if self.viewModel.isSearching {
                        updateData(on: filterFollowers)
                    } else {
                        updateUI(with: followers)
                    }
                })
        ]
    }

    /// 配置视图控制器的基本属性
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        // 启用大标题
        navigationController?.navigationBar.prefersLargeTitles = true

        // 添加收藏按钮
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdddButton))
        navigationItem.rightBarButtonItem = addButton
    }

    /// 点击收藏按钮时调用
    @objc private func didTapAdddButton() {
        showLoadingView()

        Task {
            do {
                // 添加用户到收藏列表
                try await viewModel.addUserFavorites()
                dismissLoadingView()
                // 显示成功提示
                presentGFAlert(
                    title: "followerList.success".localized,
                    message: "followerList.favoriteSuccessMessage".localized,
                    buttonTitle: "followerList.hooray".localized
                )
            } catch {
                // 处理错误
                if let gfError = error as? GFError {
                    presentGFAlert(title: "alert.somethingWentWrong".localized, message: gfError.rawValue, buttonTitle: "alert.ok".localized)
                } else {
                    presentDefaultError()
                }
                dismissLoadingView()
            }
        }
    }

    /// 配置集合视图
    private func configureCollectionView() {
        // 使用三列流式布局
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        // 注册自定义单元格
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.delegate = self
    }

    /// 配置搜索控制器
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "followerList.searchPlaceholder".localized
        navigationItem.searchController = searchController
    }

    /// 获取关注者数据
    private func getFollowers() {
        showLoadingView()
        viewModel.isLoadingMoreFollowers = true

        Task {
            do {
                // 异步获取关注者
                try await viewModel.getFollowers()
                dismissLoadingView()
            } catch {
                // 错误处理
                if let gfError = error as? GFError {
                    self.presentGFAlert(title: "alert.badStuffHappened".localized,
                                        message: gfError.rawValue,
                                        buttonTitle: "alert.ok".localized)
                } else {
                    presentDefaultError()
                    dismissLoadingView()
                }
            }
            viewModel.isLoadingMoreFollowers = false
        }
    }

    /// 更新 UI
    private func updateUI(with followers: [Follower]) {
        if viewModel.followers.isEmpty {
            // 触发内容不可用配置更新
            setNeedsUpdateContentUnavailableConfiguration()
        }

        self.updateData(on: followers)
    }

    /// 配置 Diffable Data Source
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                        cellProvider: { collectionView, indexPath, follower in
            if let cell = collectionView
                        .dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID,
                                                             for: indexPath) as? FollowerCell {
                cell.set(follower: follower)
                return cell
            } else {
                return UICollectionViewCell()
            }
        })
        
    }

    /// 更新数据源快照
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)

        // 在主线程应用快照
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension FollowerListVC: UICollectionViewDelegate {
    /// 处理滚动事件，实现分页加载
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        // 当滚动到底部时加载更多
        if offsetY > contentHeight - height {
            guard viewModel.hasMoreFollower, !viewModel.isLoadingMoreFollowers else { return }
            viewModel.page += 1
            getFollowers()
        }
    }

    /// 处理单元格点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = viewModel.activeArray
        let follower = activeArray[indexPath.item]
        // 导航到用户信息页面
        coordinator?.routeToUserInfoVC(username: follower.login)
    }
}

// MARK: - UISearchResultsUpdating
extension FollowerListVC: UISearchResultsUpdating {
    /// 搜索框内容变化时调用
    func updateSearchResults(for searchController: UISearchController) {
        let filterText = searchController.searchBar.text ?? ""
        viewModel.isSearching = !filterText.isEmpty
        // 执行搜索过滤
        viewModel.searchFollowers(with: filterText)
        // 更新空状态配置
        setNeedsUpdateContentUnavailableConfiguration()
    }
}

// MARK: - UserInfoVCDelegate
extension FollowerListVC: UserInfoVCDelegate {
    /// 请求查看关注者的关注者列表
    func didRequestFollowers(for username: String) {
        // 重置状态
        viewModel.reset()
        viewModel.username = username
        title = username
        // 关闭搜索状态
        navigationItem.searchController?.isActive = false
        // 滚动到顶部
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        // 获取新用户的关注者
        getFollowers()
    }
}
