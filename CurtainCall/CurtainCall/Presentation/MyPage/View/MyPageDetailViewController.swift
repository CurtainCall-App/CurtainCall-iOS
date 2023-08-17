//
//  MyPageDetailViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/15.
//

import UIKit

enum MyPageDetailType {
    case recruitment
    case participate
}

final class MyPageDetailViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 26
        return imageView
    }()
    
    private let profileLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .title
        return label
    }()
    
    private let writeDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body5
        label.textColor = .hexBEC2CA
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .body1
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex5A6271
        label.numberOfLines = 0
        return label
    }()
    
    private let detailView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .pointColor1
        label.text = "상세 정보"
        return label
    }()
    
    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let detailTitleView = UIView()
    private let detailTitleSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailTitleSymbol)
        return imageView
    }()
    private let detailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "작품명"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailProductLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let detailStateView = UIView()
    private let detailStateSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailCountStateSymbol)
        return imageView
    }()
    private let detailStateLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "참여 상태"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailCountLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let grayBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        return view
    }()
    
    private let detailDateView = UIView()
    private let detailDateSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailDateSymbol)
        return imageView
    }()
    private let detailDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "공연 일자"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailProductDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let detailTimeView = UIView()
    private let detailTimeSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailTimeSymbol)
        return imageView
    }()
    private let detailTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "공연 시간"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailProductTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let detailLocationView = UIView()
    private let detailLocationSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailLocationSymbol)
        return imageView
    }()
    private let detailLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "공연 장소"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailProductLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let partyInButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("TALK 만들기", for: .normal)
        return button
    }()
    
    private let dotLineViews = [
        DotLineView(), DotLineView(), DotLineView(), DotLineView()
    ]
    
    // MARK: - Properties
    
    private let partyType: PartyType
    private let partyInfo: ProductPartyInfo
    private let editType: MyPageDetailType
    
    // MARK: - Lifecycles
    
    init(partyType: PartyType, partyInfo: ProductPartyInfo, editType: MyPageDetailType) {
        self.partyType = partyType
        self.partyInfo = partyInfo
        self.editType = editType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        draw()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubviews(scrollView, partyInButton)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(headerView, grayBorderView, detailView)
        headerView.addSubviews(profileImageView, profileLabelStackView, titleLabel, contentLabel)
        profileLabelStackView.addArrangedSubviews(nickNameLabel, writeDateLabel)
        detailView.addSubviews(detailLabel, detailStackView)
        detailStackView.addArrangedSubviews(
            detailTitleView,
            detailStateView,
            detailDateView,
            detailTimeView,
            detailLocationView
        )
        detailTitleView.addSubviews(
            detailTitleSymbolImageView, detailTitleLabel, detailProductLabel
        )
        detailStateView.addSubviews(
            detailStateSymbolImageView, detailStateLabel, detailCountLabel
        )
        detailDateView.addSubviews(
            detailDateSymbolImageView, detailDateLabel, detailProductDateLabel
        )
        detailTimeView.addSubviews(
            detailTimeSymbolImageView, detailTimeLabel, detailProductTimeLabel
        )
        detailLocationView.addSubviews(
            detailLocationSymbolImageView, detailLocationLabel, detailProductLocationLabel
        )
        partyInButton.setNextButton(isSelected: true)
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(partyInButton.snp.top).inset(30)
        }
        partyInButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(55)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        headerView.snp.makeConstraints { $0.top.leading.trailing.equalToSuperview() }
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalToSuperview().offset(31)
            $0.size.equalTo(52)
        }
        profileLabelStackView.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
        }
        contentLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.bottom.equalToSuperview().inset(38)
        }
        grayBorderView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        detailView.snp.makeConstraints {
            $0.top.equalTo(grayBorderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        detailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        detailStackView.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-20)

        }
        detailTitleView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailTitleSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        detailTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(detailTitleSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailProductLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
        }
        detailStateView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailStateSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        detailStateLabel.snp.makeConstraints {
            $0.leading.equalTo(detailStateSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailCountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
        }
        detailDateView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailDateSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        detailDateLabel.snp.makeConstraints {
            $0.leading.equalTo(detailDateSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailProductDateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
        }
        detailTimeView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailTimeSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        detailTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(detailTimeSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailProductTimeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
        }
        detailLocationView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailLocationSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            
        }
        detailLocationLabel.snp.makeConstraints {
            $0.leading.equalTo(detailLocationSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailProductLocationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
        }
//        dotLineViews.forEach {
//            $0.snp.makeConstraints { make in
//                make.horizontalEdges.equalToSuperview()
//                make.height.equalTo(1)
//            }
//        }
       
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = partyType.title
        let moreBarButton = UIBarButtonItem(
            title: nil,
            image: UIImage(named: ImageNamespace.navigationMoreButton),
            target: self,
            action: #selector(moreButtonTouchUpInside)
        )
        
        let reportButton = UIBarButtonItem(
            title: nil,
            image: UIImage(named: ImageNamespace.navigationReportButton),
            target: self,
            action: #selector(reportButtonTouchUpInside)
        )
        
        navigationItem.rightBarButtonItem = editType == .recruitment ? moreBarButton : reportButton
        navigationItem.rightBarButtonItem?.tintColor = .hex828996
    }
    
    private func draw() {
        profileImageView.image = partyInfo.profileImage
        nickNameLabel.text = partyInfo.nickname
        titleLabel.text = partyInfo.title
        writeDateLabel.text = partyInfo.writeDate.convertToYearMonthDayHourMinString()
        contentLabel.text = partyInfo.content
        detailProductLabel.text = partyInfo.productName
        detailCountLabel.text = "\(partyInfo.minCount)/\(partyInfo.maxCount)"
        detailProductDateLabel.text = partyInfo.productDate.convertToYearMonthDayWeekString()
        detailProductTimeLabel.text = partyInfo.productDate.convertToHourMinString()
        detailProductLocationLabel.text = partyInfo.location
    }
    
    @objc
    private func moreButtonTouchUpInside() {
        let sheet = MyPageEditBottomSheet()
        sheet.modalPresentationStyle = .pageSheet
        let fraction = UISheetPresentationController.Detent.custom { _ in
            return 228
        }
        if let sheet = sheet.sheetPresentationController {
            sheet.detents = [fraction]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 50
        }
        sheet.delegate = self
        
        present(sheet, animated: true)
    }
    
    @objc
    private func reportButtonTouchUpInside() {
        let reportViewController = ReportViewController(viewModel: ReportViewModel())
        navigationController?.pushViewController(reportViewController, animated: true)
    }
}

extension MyPageDetailViewController: EditBottomSheetDelegate {
    func moveToEdit() {
        let viewModel = MyRecruitmentEditViewModel()
        let editViewController = MyRecruitmentEditViewController(viewModel: viewModel, partyInfo: partyInfo)
        
        navigationController?.pushViewController(editViewController, animated: true)
    }
    
    func moveToDelete() {
        let popupViewController = MyPageDeletePopup()
        popupViewController.delegate = self
        popupViewController.modalPresentationStyle = .overFullScreen
        present(popupViewController, animated: false)
    }
}

extension MyPageDetailViewController: DeletePopDelegate {
    func deleteButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
