import UIKit

class ViewController: UIViewController {
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var defaultIconButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Default"
        configuration.baseBackgroundColor = .systemBlue
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(defaultIconTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var alternateIcon1Button: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Dark"
        configuration.baseBackgroundColor = .systemGreen
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(alternateIcon1Tapped), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        stackView.addArrangedSubview(defaultIconButton)
        stackView.addArrangedSubview(alternateIcon1Button)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func defaultIconTapped() {
        setApplicationIconName(nil)
    }

    @objc private func alternateIcon1Tapped() {
        setApplicationIconName("AppIcon1")
    }
    
    // ref: https://stackoverflow.com/a/63877197
    func setApplicationIconName(_ iconName: String?) {
        if UIApplication.shared.responds(to: #selector(getter: UIApplication.supportsAlternateIcons)) && UIApplication.shared.supportsAlternateIcons {
            typealias setAlternateIconName = @convention(c) (NSObject, Selector, NSString?, @escaping (NSError) -> ()) -> ()
            let selectorString = "_setAlternateIconName:completionHandler:"
            let selector = NSSelectorFromString(selectorString)
            let imp = UIApplication.shared.method(for: selector)
            let method = unsafeBitCast(imp, to: setAlternateIconName.self)
            method(UIApplication.shared, selector, iconName as NSString?, { _ in })
        }
    }
}
