//  Copyright © 2022 WOW Staff. All rights reserved.

import UIKit
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

extension SwinjectStoryboard {
    @objc class func setup() {
        injectRepositories(into: defaultContainer)
        injectViewModels(into: defaultContainer)
//        Container.loggingFunction = nil
        injectStoryboards(into: defaultContainer)
    }
    
    private class func injectStoryboards(into container: Container) {
        
        container.storyboardInitCompleted(CharacterListViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(CharacterListViewModelProtocol.self)
            controller.viewModel?.setView(delegate: controller)
        }
        
        container.storyboardInitCompleted(CharacterDetailViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(CharacterDetailViewModelProtocol.self)
            controller.viewModel?.setView(delegate: controller)
        }
    }
}
