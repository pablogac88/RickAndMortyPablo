//  Copyright © 2022 WOW Staff. All rights reserved.

import UIKit
import Kingfisher

protocol CharacterCellDelegate: AnyObject {
    func checkFavouriteCharacter(idCharacter: String, setFavourite: Bool)
}

class CharacterCell: UITableViewCell {

    weak var delegate: CharacterCellDelegate?
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lastLocationLabel: UILabel!
    @IBOutlet weak var originLocationLabel: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    private var model: CharactersModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with model: CharactersModel) {
        self.model = model
        titleLabel.text = model.name
        lastLocationLabel.text = model.lastLocation
        originLocationLabel.text = model.originLocation
        update(imageURL: model.image)
        
        if model.isFavourite {
            favouriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        }
    }
    
    private func update(imageURL: String?) {
        guard let imageURL = imageURL,
              let image = URL(string: imageURL) else {
            return
        }
        characterImageView.kf.setImage(with: image)
    }
    
    @IBAction func clickFavourite(_ sender: Any) {
        guard let model = model else {
            return
        }
        if !model.isFavourite {
            favouriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        }
        delegate?.checkFavouriteCharacter(idCharacter: "\(model.idCharacter)", setFavourite: !model.isFavourite)
    }
}
