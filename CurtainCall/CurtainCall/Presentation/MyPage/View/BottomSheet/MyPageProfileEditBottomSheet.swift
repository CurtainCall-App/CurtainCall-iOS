//
//  MyPageProfileEditBottomSheet.swift
//  CurtainCall
//
//  Created by 김민석 on 11/25/23.
//

import UIKit

protocol ProfileEditBottomSheetDelegate: AnyObject {
    func moveToLibrary()
    func convertToBasicImage()
}

final class MyPageProfileEditBottomSheet: UIViewController {
    
    // MARK: UI Property
    
    private let moveToLibraryView = UIView()
    private let moveToLibraryLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .body1
        label.text = "앨범에서 사진 선택"
        return label
    }()
    private let moveToLibraryButton = UIButton()
    
    private let convertToBasicImageView = UIView()
    private let convertToBasicImageLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .body1
        label.text = "기본 프로필로 변경"
        return label
    }()
    private let convertToBasicImageButton = UIButton()
    
    // MARK: Property
    
    weak var delegate: ProfileEditBottomSheetDelegate?
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        moveToLibraryButton.addTarget(self, action: #selector(moveToLibraryButtonTouchUpInside), for: .touchUpInside)
        convertToBasicImageButton.addTarget(self, action: #selector(convertToBasicImageButtonTouchUpInside), for: .touchUpInside)
    }
    
    // MARK: Configure
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.addSubviews(moveToLibraryView, convertToBasicImageView)
        moveToLibraryView.addSubviews(moveToLibraryLabel, moveToLibraryButton)
        convertToBasicImageView.addSubviews(convertToBasicImageLabel, convertToBasicImageButton)
    }
    
    private func configureConstraints() {
        moveToLibraryView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(35)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(51)
        }
        
        moveToLibraryLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        moveToLibraryButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        convertToBasicImageView.snp.makeConstraints {
            $0.top.equalTo(moveToLibraryView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(51)
        }
        
        convertToBasicImageLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        convertToBasicImageButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc
    private func moveToLibraryButtonTouchUpInside() {
        delegate?.moveToLibrary()
    }
    
    @objc
    private func convertToBasicImageButtonTouchUpInside() {
        delegate?.convertToBasicImage()
    }
    
}

