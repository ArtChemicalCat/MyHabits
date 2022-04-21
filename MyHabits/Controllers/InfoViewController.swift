//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Николай Казанин on 28.03.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
//MARK: - Views
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Привычка за 21 день"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStackView()
        layout()
    }
    
//MARK: - Layout
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(stackView)
        navigationItem.title = "Информация"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.readableContentGuide.widthAnchor)
        ])
    }
    
    private func setUpStackView() {
        stackView.addArrangedSubview(makeLabel(withText: Constant.stepsDescription))
        
        Constant.habitSteps.forEach { stackView.addArrangedSubview(makeLabel(withText: $0)) }
    }
    
    private func makeLabel(withText text: String) -> UILabel {
        let label: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = text
            label.numberOfLines = 0
            label.font = UIFont(name: "SFProText-Regular", size: 17)
            return label
        }()
        return label
    }
}
