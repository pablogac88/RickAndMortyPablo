//  Copyright © 2022 WOW Staff. All rights reserved.

import UIKit
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

extension SwinjectStoryboard {
    class func injectRepositories(into container: Container) {
        container.autoregister(CharactersRepositoryProtocol.self,
                               initializer: CharactersRepository.init)
        
        container.autoregister(LocationRepositoryProtocol.self,
                               initializer: LocationRepository.init)
    }
}
