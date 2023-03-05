import SnowPack

final class SimpleCollectionViewDemoViewModel: ViewModel {
    
    private let images = [
        "https://i.imgur.com/mH53JWH.jpg",
        "https://i.imgur.com/4CE5Kyu.jpg",
        "https://i.imgur.com/Knof7zi.jpg",
        "https://i.imgur.com/Cf8fj73.jpg",
        "https://i.imgur.com/zzzazKX.jpg",
        "https://i.imgur.com/mH53JWH.jpg",
        "https://i.imgur.com/4CE5Kyu.jpg",
        "https://i.imgur.com/Knof7zi.jpg",
        "https://i.imgur.com/Cf8fj73.jpg",
        "https://i.imgur.com/zzzazKX.jpg",
    ]
    
    private let names = [
        "beluga",
        "yor forger",
        "noot",
        "hecker",
        "scemer",
        "beluga",
        "yor forger",
        "noot",
        "hecker",
        "scemer",
    ]
    
    private var imageURLs: [URL] {
        images.map({ URL(string: $0)! })
    }
    
    lazy var data: [CollectionViewImageCellModel] = {
        var data: [CollectionViewImageCellModel] = []
        for i in 0..<images.count {
            data.append(.init(imageURL: imageURLs[i], title: names[i], shouldBlur: names[i] == "yor forger"))
        }
        return data
    }()
    
    override init() {
        super.init()
        initialLoadEvent.send()
    }
    
}
