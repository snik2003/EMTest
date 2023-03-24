//
//  ProfileViewController.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import UIKit
import Photos
import CropViewController

class ProfileViewController: UIViewController {

    var viewModel: ProfileViewModelDelegate!
    var tableViewDelegate: ProfileCellProtocol!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var changePhotoButton: UIButton!
    @IBOutlet weak var uploadItemsButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialState()
        updateBottomConstraints()
    }
    
    func setupInitialState() {
        userIconImageView.layer.cornerRadius = 30
        userIconImageView.layer.borderWidth = 0.8
        userIconImageView.layer.borderColor = UIColor(red: 0.357, green: 0.357, blue: 0.357, alpha: 1).cgColor
        
        userIconImageView.image = nil
        userNameLabel.text = ""
        
        showLoading()
        viewModel.getCurrentUser { [weak self] user in
            guard let self = self else { return }
            
            guard let user  = user else {
                self.userNameLabel.text = self.viewModel.getUserFullName()
                return
            }
            
            self.userNameLabel.text = user.firstName + " " + user.lastName
            self.userIconImageView.image = user.photo
            self.hideLoading()
        }
        
        tableViewDelegate = ProfileCellDelegate(dataSource: ProfileCellModel.allCases, tableView: tableView, viewModel: viewModel)
        tableViewDelegate.reloadData()
    }
    
    func updateBottomConstraints() {
        guard let navigationController = self.navigationController else { return }
        guard let tabbarController = navigationController.tabBarController as? MainTabBarController else { return }
        
        bottomConstraint.constant = 4 + tabbarController.tabbarDifference
    }
    
    @IBAction func changePhotoButtonAction() {
        changePhotoButton.viewTouched {
            self.showImagePickerScreen()
        }
    }
    
    @IBAction func uploadItemsButtonAction() {
        uploadItemsButton.viewTouched {
            
        }
    }
}

extension ProfileViewController {
    
    private func showImagePickerScreen() {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ [weak self] (newStatus) in
                guard let self = self else { return }
                
                guard newStatus == PHAuthorizationStatus.authorized else { return }
                    
                DispatchQueue.main.async {
                    self.openImagePicker(forType: .photoLibrary)
                }
            })
        case .authorized, .limited:
            openImagePicker(forType: .photoLibrary)
        default:
            return
        }
    }
    
    private func openImagePicker(forType type: UIImagePickerController.SourceType) {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.allowsEditing = false
        imagePickerViewController.sourceType = type
        imagePickerViewController.delegate = self
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                let cropViewController = CropViewController(croppingStyle: .circular, image: pickedImage)
                cropViewController.aspectRatioPreset = .presetSquare
                cropViewController.resetAspectRatioEnabled = false
                cropViewController.aspectRatioPickerButtonHidden = true
                cropViewController.delegate = self
                self.present(cropViewController, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension ProfileViewController: CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
        cropViewController.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            
            self.showLoading()
            self.viewModel.updateUserPhoto(image) { [weak self] result in
                guard let self = self else { return }
                
                guard result else {
                    self.hideLoading()
                    self.showAttentionMessage(DataInputError.unknownError.rawValue) {}
                    return
                }
                
                self.userIconImageView.image = image
                self.hideLoading()
            }
        }
        
        
        
        
    }
}
