import MLYSDK
import UIKit

class ViewController: UIViewController {
    lazy var info: UITextView = {
        let text = UITextView()
        text.textColor = .white
        text.font = .systemFont(ofSize: 18)
        text.textContainer.lineBreakMode = .byClipping
        return text
    }()
    
    var initState:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupDriver()
    }
 
    func setupDriver() {
        let muxSampleRate = 1.0
        let debug = true
        do {
            try MLYDriver.initialize { options in
                options.client.id = DemoConfig.defaultConfig.id
                options.server.host.fqdn = DemoConfig.defaultConfig.server
                options.debug = debug 
            }
            self.initState.append("initialize：success \n\n")
        } catch {
            print(error)
            self.initState.append("initialize：\(error.localizedDescription) \n\n")
        }
        self.initState.append("id: \(DemoConfig.defaultConfig.id) \n\n")
        self.initState.append("fqdn: \(DemoConfig.defaultConfig.server) \n\n")
        self.initState.append("debug: \(debug) \n\n")
        self.initState.append("muxSampleRate: \(muxSampleRate) \n\n")
        self.info.text = self.initState
    }
}

extension ViewController {
    func setupUI() {
        self.view.backgroundColor = .white
        self.info = .init(frame: CGRect.init(
            x: 8,
            y: UIDevice.statusBarHeight() + 8,
            width: UIView.getScreenWidth(),
            height: 200)
        )
        self.view.addSubview(self.info)
  
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {[weak self] _ in
            guard let weakSelf = self else {return}
            var text = weakSelf.initState
            text.append("Peer: \(MLYData.instance.peerID ?? "") \n\n")
            
            weakSelf.info.text = text
        }
    }
}
