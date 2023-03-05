import SnowPack

final class RandomViewController: ViewController {
    
    lazy var centerLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerHeight = 0.0
        addSubview(centerLabel)
        centerLabel.centerInSuperview()
        centerLabel.text = "random ViewController: " + .randomString(length: 4)
    }
    
}

extension String {
    static func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
