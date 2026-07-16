//
//  Copyright © 2017-present Aromajoin. All rights reserved.
//
//  A code-based sample UI for the Aroma Shooter SDK. No storyboard.
//  Connect devices via the SDK's connection screen, then shoot scents
//  from any of the 6 chambers with adjustable concentration / boosters.
//

import UIKit
import AromaShooterSwiftSDK

final class ViewController: UIViewController {

  private let controller = AromaShooterController.sharedInstance

  private let chamberCount = 6
  private var concentrations = Array(repeating: 100, count: 6)   // per-chamber, 0...100
  private var durationMillis = 3000
  private var internalBooster = 100                              // 0...100
  private var externalBooster = 0                                // 0...100 (AS3 only)

  // MARK: UI

  private let statusLabel = UILabel()
  private let connectButton = UIButton(type: .system)
  private lazy var contentStack = UIStackView()

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Aroma Shooter"
    view.backgroundColor = .appBackground
    controller.delegate = self
    buildUI()
    refreshStatus()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // The connection screen may have (dis)connected devices while pushed.
    refreshStatus()
  }

  // MARK: Layout

  private func buildUI() {
    let scroll = UIScrollView()
    scroll.translatesAutoresizingMaskIntoConstraints = false
    scroll.alwaysBounceVertical = true
    scroll.keyboardDismissMode = .interactive
    view.addSubview(scroll)

    contentStack.axis = .vertical
    contentStack.spacing = 16
    contentStack.translatesAutoresizingMaskIntoConstraints = false
    contentStack.isLayoutMarginsRelativeArrangement = true
    contentStack.directionalLayoutMargins = .init(top: 16, leading: 16, bottom: 32, trailing: 16)
    scroll.addSubview(contentStack)

    NSLayoutConstraint.activate([
      scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      contentStack.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
      contentStack.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
      contentStack.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
      contentStack.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
      contentStack.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor),
    ])

    contentStack.addArrangedSubview(makeConnectionCard())
    contentStack.addArrangedSubview(makeSettingsCard())
    contentStack.addArrangedSubview(makeChambersCard())
    contentStack.addArrangedSubview(makeStopButton())
  }

  // MARK: Cards

  private func makeConnectionCard() -> UIView {
    statusLabel.font = .preferredFont(forTextStyle: .headline)
    statusLabel.numberOfLines = 0
    statusLabel.textColor = .appLabel

    connectButton.setTitle("Connect / Scan Devices", for: .normal)
    connectButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
    connectButton.addTarget(self, action: #selector(openConnectionScreen), for: .touchUpInside)
    styleFilled(connectButton, color: .systemBlue)

    let stack = UIStackView(arrangedSubviews: [statusLabel, connectButton])
    stack.axis = .vertical
    stack.spacing = 12
    return card(titled: "Connection", content: stack)
  }

  private func makeSettingsCard() -> UIView {
    let duration = labeledField(title: "Duration (ms)", value: "\(durationMillis)",
                                action: #selector(durationChanged(_:)))
    let internalRow = sliderRow(title: "Internal booster", value: internalBooster,
                                tag: 100, action: #selector(internalBoosterChanged(_:)))
    let externalRow = sliderRow(title: "External booster (AS3)", value: externalBooster,
                                tag: 101, action: #selector(externalBoosterChanged(_:)))

    let note = UILabel()
    note.text = "The internal booster must be > 0 for any scent to emit."
    note.font = .preferredFont(forTextStyle: .footnote)
    note.textColor = .appSecondaryLabel
    note.numberOfLines = 0

    let stack = UIStackView(arrangedSubviews: [duration, internalRow, externalRow, note])
    stack.axis = .vertical
    stack.spacing = 14
    return card(titled: "Settings", content: stack)
  }

  private func makeChambersCard() -> UIView {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 14
    for n in 1...chamberCount {
      stack.addArrangedSubview(makeChamberRow(number: n))
    }
    return card(titled: "Chambers", content: stack)
  }

  private func makeChamberRow(number: Int) -> UIView {
    let title = UILabel()
    title.text = "Chamber \(number)"
    title.font = .preferredFont(forTextStyle: .subheadline)
    title.textColor = .appLabel

    let value = UILabel()
    value.font = .monospacedDigitSystemFont(ofSize: 15, weight: .regular)
    value.textColor = .appSecondaryLabel
    value.textAlignment = .right
    value.tag = 200 + number                       // value label lookup
    value.text = "\(concentrations[number - 1])%"
    value.setContentHuggingPriority(.required, for: .horizontal)

    let slider = UISlider()
    slider.minimumValue = 0
    slider.maximumValue = 100
    slider.value = Float(concentrations[number - 1])
    slider.tag = number
    slider.addTarget(self, action: #selector(concentrationChanged(_:)), for: .valueChanged)

    let shoot = UIButton(type: .system)
    shoot.setTitle("Shoot", for: .normal)
    shoot.titleLabel?.font = .preferredFont(forTextStyle: .headline)
    shoot.tag = number
    shoot.addTarget(self, action: #selector(shootChamber(_:)), for: .touchUpInside)
    styleFilled(shoot, color: .systemGreen)
    shoot.widthAnchor.constraint(equalToConstant: 92).isActive = true

    let header = UIStackView(arrangedSubviews: [title, value])
    header.axis = .horizontal

    let left = UIStackView(arrangedSubviews: [header, slider])
    left.axis = .vertical
    left.spacing = 4

    let row = UIStackView(arrangedSubviews: [left, shoot])
    row.axis = .horizontal
    row.spacing = 12
    row.alignment = .center
    return row
  }

  private func makeStopButton() -> UIView {
    let stop = UIButton(type: .system)
    stop.setTitle("Stop All", for: .normal)
    stop.titleLabel?.font = .preferredFont(forTextStyle: .headline)
    stop.addTarget(self, action: #selector(stopAll), for: .touchUpInside)
    styleFilled(stop, color: .systemRed)
    stop.heightAnchor.constraint(equalToConstant: 52).isActive = true
    return stop
  }

  // MARK: Actions

  @objc private func openConnectionScreen() {
    guard let connectionVC = controller.getConnectionViewController() else {
      showAlert("Unavailable", "Could not load the connection screen from the SDK.")
      return
    }
    navigationController?.pushViewController(connectionVC, animated: true)
  }

  @objc private func durationChanged(_ field: UITextField) {
    if let v = Int(field.text ?? ""), v > 0 { durationMillis = v }
    else { field.text = "\(durationMillis)" }
  }

  @objc private func internalBoosterChanged(_ slider: UISlider) {
    internalBooster = Int(slider.value)
    (view.viewWithTag(300) as? UILabel)?.text = "\(internalBooster)%"
  }

  @objc private func externalBoosterChanged(_ slider: UISlider) {
    externalBooster = Int(slider.value)
    (view.viewWithTag(301) as? UILabel)?.text = "\(externalBooster)%"
  }

  @objc private func concentrationChanged(_ slider: UISlider) {
    let n = slider.tag
    concentrations[n - 1] = Int(slider.value)
    (view.viewWithTag(200 + n) as? UILabel)?.text = "\(concentrations[n - 1])%"
  }

  @objc private func shootChamber(_ sender: UIButton) {
    guard !controller.connectedDevices.isEmpty else {
      showAlert("No device", "Connect an Aroma Shooter first (Connect / Scan Devices).")
      return
    }
    let n = sender.tag
    let chamber = AromaChamber(number: n, concentration: concentrations[n - 1])
    controller.shootAllWithIntensity(durationInMilli: durationMillis,
                                     internalBoosterIntensity: internalBooster,
                                     externalBoosterIntensity: externalBooster,
                                     chambers: [chamber])
  }

  @objc private func stopAll() {
    controller.stopAllSimple()
  }

  // MARK: Status

  private func refreshStatus() {
    let count = controller.connectedDevices.count
    if count == 0 {
      statusLabel.text = "No device connected"
      statusLabel.textColor = .appSecondaryLabel
    } else {
      let names = controller.connectedDevices.compactMap { $0.name }.joined(separator: ", ")
      statusLabel.text = "\(count) device\(count > 1 ? "s" : "") connected"
        + (names.isEmpty ? "" : "\n\(names)")
      statusLabel.textColor = .systemGreen
    }
  }

  // MARK: Helpers

  private func card(titled title: String, content: UIView) -> UIView {
    let heading = UILabel()
    heading.text = title
    heading.font = .preferredFont(forTextStyle: .title3)
    heading.adjustsFontForContentSizeCategory = true
    heading.textColor = .appLabel

    let stack = UIStackView(arrangedSubviews: [heading, content])
    stack.axis = .vertical
    stack.spacing = 12
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.isLayoutMarginsRelativeArrangement = true
    stack.directionalLayoutMargins = .init(top: 16, leading: 16, bottom: 16, trailing: 16)

    let container = UIView()
    container.backgroundColor = .appSecondaryBackground
    container.layer.cornerRadius = 14
    container.addSubview(stack)
    NSLayoutConstraint.activate([
      stack.topAnchor.constraint(equalTo: container.topAnchor),
      stack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      stack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      stack.bottomAnchor.constraint(equalTo: container.bottomAnchor),
    ])
    return container
  }

  private func labeledField(title: String, value: String, action: Selector) -> UIView {
    let label = UILabel()
    label.text = title
    label.font = .preferredFont(forTextStyle: .subheadline)
    label.textColor = .appLabel

    let field = UITextField()
    field.text = value
    field.borderStyle = .roundedRect
    field.keyboardType = .numberPad
    field.textAlignment = .right
    field.addTarget(self, action: action, for: .editingChanged)
    field.widthAnchor.constraint(equalToConstant: 110).isActive = true
    addDoneToolbar(field)

    let row = UIStackView(arrangedSubviews: [label, field])
    row.axis = .horizontal
    row.alignment = .center
    return row
  }

  private func sliderRow(title: String, value: Int, tag: Int, action: Selector) -> UIView {
    let label = UILabel()
    label.text = title
    label.font = .preferredFont(forTextStyle: .subheadline)
    label.textColor = .appLabel

    let valueLabel = UILabel()
    // Value-label tags: 300 = internal booster, 301 = external booster.
    valueLabel.tag = (tag == 100) ? 300 : 301
    valueLabel.font = .monospacedDigitSystemFont(ofSize: 15, weight: .regular)
    valueLabel.textColor = .appSecondaryLabel
    valueLabel.textAlignment = .right
    valueLabel.text = "\(value)%"
    valueLabel.setContentHuggingPriority(.required, for: .horizontal)

    let slider = UISlider()
    slider.minimumValue = 0
    slider.maximumValue = 100
    slider.value = Float(value)
    slider.addTarget(self, action: action, for: .valueChanged)

    let header = UIStackView(arrangedSubviews: [label, valueLabel])
    header.axis = .horizontal

    let stack = UIStackView(arrangedSubviews: [header, slider])
    stack.axis = .vertical
    stack.spacing = 4
    return stack
  }

  private func styleFilled(_ button: UIButton, color: UIColor) {
    button.backgroundColor = color
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 10
    button.contentEdgeInsets = .init(top: 12, left: 16, bottom: 12, right: 16)
  }

  private func addDoneToolbar(_ field: UITextField) {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    toolbar.items = [
      UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
      UIBarButtonItem(barButtonSystemItem: .done, target: field, action: #selector(UIResponder.resignFirstResponder)),
    ]
    field.inputAccessoryView = toolbar
  }

  private func showAlert(_ title: String, _ message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    present(alert, animated: true)
  }
}

// MARK: - AromaShooterDelegate

extension ViewController: AromaShooterDelegate {
  func aromaShooter(didDiscoverDevice device: AromaShooter) {}

  func aromaShooter(didConnectDevice device: AromaShooter) {
    DispatchQueue.main.async { [weak self] in self?.refreshStatus() }
  }

  func aromaShooter(didDisconnectDevice device: AromaShooter) {
    DispatchQueue.main.async { [weak self] in self?.refreshStatus() }
  }
}

// MARK: - iOS 12 compatible adaptive colors

private extension UIColor {
  static var appBackground: UIColor {
    if #available(iOS 13.0, *) { return .systemBackground }
    return .white
  }
  static var appSecondaryBackground: UIColor {
    if #available(iOS 13.0, *) { return .secondarySystemBackground }
    return UIColor(white: 0.95, alpha: 1)
  }
  static var appLabel: UIColor {
    if #available(iOS 13.0, *) { return .label }
    return .black
  }
  static var appSecondaryLabel: UIColor {
    if #available(iOS 13.0, *) { return .secondaryLabel }
    return .darkGray
  }
}
