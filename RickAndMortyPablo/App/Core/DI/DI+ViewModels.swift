//  Copyright © 2022 WOW Staff. All rights reserved.

import UIKit
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

extension SwinjectStoryboard {
    class func injectViewModels(into container: Container) {
        container.autoregister(CharacterListViewModelProtocol.self,
                               initializer: CharacterListViewModel.init)
        container.autoregister(CharacterDetailViewModelProtocol.self,
                               initializer: CharacterDetailViewModel.init)
        
    }
}
