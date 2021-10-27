//
//  SplashScreenViewController.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 26/10/21.
//

import UIKit

final class SplashScreenViewController: UIViewController {

    // MARK: - Attributes

    private let viewModel: SplashScreenViewModelProtocol

    // MARK: - Elements

    private let logoImageView = UIImageView(image: R.image.logo())

    // MARK: - Life cycle

    init(viewModel: SplashScreenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        animateLogo(counRun: 0)
    }

    // MARK: - Custom methods

    private func setupUI() {
        view.backgroundColor = .white
        configureNavigationBar(isHidden: true)
        createElements()
    }

    @objc private func animateLogo(counRun: Int) {
        guard counRun < 2 else {
            UIView.animate(withDuration: 0.2) {
                self.logoImageView.alpha = 0.0
            } completion: { _ in
                self.viewModel.openProductList()
            }
            return
        }

        UIView.animate(withDuration: 2.0) {
            self.logoImageView.transform = CGAffineTransform(rotationAngle: .pi)
            self.logoImageView.transform = CGAffineTransform(rotationAngle: .pi * 2)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.animateLogo(counRun: counRun + 1)
        }
    }
}

// MARK: - Create elements

private extension SplashScreenViewController {

    func createElements() {
        view.addView(logoImageView)

        setupImageConstraints()
    }

    // MARK: - Create constraints

    private func setupImageConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 40).isActive = true
        logoImageView.trailingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: -40).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: view.frame.width * 0.5).isActive = true
    }
}
