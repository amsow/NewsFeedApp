//
//  AppComponent.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs


final class AppComponent: Component<EmptyDependency>, RootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
}
