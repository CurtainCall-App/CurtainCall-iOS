//
//  PartyMemberOtherViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import UIKit
import Combine

final class PartyMemberOtherViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "모든 게시물은 최신순으로 제공됩니다."
        label.font = .body3
        label.textColor = .hex5A6271
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        return collectionView
    }()
    
    private let writeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.partymemberWriteButton), for: .normal)
        return button
    }()
    
    // MARK: - Properties
    
    private enum Section { case main }
    typealias Item = PartyListContent
    
    private let viewModel: PartyMemberOtherViewModel
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    private var snapshot: NSDiffableDataSourceSnapshot<Section, Item>?
    
    // MARK: - Lifecycles
    
    init(viewModel: PartyMemberOtherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        registerCell()
        addTarget()
        bind()
        viewModel.requestPartyProductInfo(page: 0, size: 20)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigation()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
        configureDatasource()
        configureSnapshot()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .hexF5F6F8
        view.addSubviews(guideLabel, collectionView, writeButton)
    }
    
    private func configureConstraints() {
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.leading.equalToSuperview().offset(24)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        writeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-60)
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    
    private func configureNavigation() {
        title = "기타"
        let leftBarbuttonItem = UIBarButtonItem(
            image: UIImage(named: ImageNamespace.navigationBackButton),
            style: .plain,
            target: self,
            action: #selector(backBarbuttonTapped)
        )
        let searchBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: nil
        )
        leftBarbuttonItem.tintColor = .black
        searchBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarbuttonItem
        navigationItem.rightBarButtonItem = searchBarButtonItem
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(250)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(250)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.edgeSpacing = .init(leading: nil, top: nil, trailing: nil, bottom: .fixed(16))
        let section = NSCollectionLayoutSection(group: group)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        return UICollectionViewCompositionalLayout(section: section, configuration: config)
    }
    
    private func registerCell() {
        collectionView.register(
            PartyOtherCell.self,
            forCellWithReuseIdentifier: PartyOtherCell.identifier
        )
    }
    
    private func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                guard let cell = collectionView.dequeueCell(
                    type: PartyOtherCell.self,
                    indexPath: indexPath
                ) else { return UICollectionViewCell() }
                cell.setUI(item)
                return cell
            }
        )
    }
    
    private func configureSnapshot() {
        snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot?.appendSections([.main])
    }
    
    private func bind() {
        viewModel.otherInfoData
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] item in
                guard var snapshot = self?.snapshot else { return }
                snapshot.appendItems(item, toSection: .main)
                self?.dataSource?.apply(snapshot)
            }.store(in: &cancellables)

    }
    
    private func addTarget() {
        writeButton.addTarget(
            self,
            action: #selector(writeButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    // MARK: - Actions
    
    @objc
    private func backBarbuttonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func writeButtonTouchUpInside() {
        moveToWriteView()
    }
    
    private func moveToWriteView() {
        configureBackbarButton()
        let writeViewController = PartyMemberOtherRecruitingDateViewController(
            viewModel: PartyMemberOtherRecruitingDateViewModel()
        )
        navigationController?.pushViewController(writeViewController, animated: true)
    }
}

extension PartyMemberOtherViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataSource, let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        let detailViewController = PartyMemberRecruitingOtherDetailViewController(id: item.id)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
