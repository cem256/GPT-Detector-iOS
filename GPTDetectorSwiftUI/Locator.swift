//
//  Locator.swift
//  GPTDetectorSwiftUI
//
//  Created by cem on 1.09.2023.
//

import Factory
import Foundation

extension Container {
    // MARK: ViewModels

    var splashViewModel: Factory<SplashViewModel> {
        Factory(self) { SplashViewModel(cacheClient: self.cacheClient()) }
    }

    var onboardingViewModel: Factory<OnboardingViewModel> {
        Factory(self) { OnboardingViewModel(cacheClient: self.cacheClient()) }
    }

    var detectorViewModel: Factory<DetectorViewModel> {
        Factory(self) { DetectorViewModel(detectorService: self.detectorService(), permissionHandlerClient: self.permissionHandlerClient(), textRecognizerClient: self.textRecognizerClient()) }
    }

    // MARK: Services

    private var detectorService: Factory<DetectorServiceProtocol> {
        Factory(self) { DetectorService(networkClient: self.networkClient(), languageIdentifierClient: self.languageIdentifierClient()) }
    }

    // MARK: Clients

    private var cacheClient: Factory<CacheClientProtocol> {
        Factory(self) { CacheClient() }
    }

    private var networkClient: Factory<NetworkClientProtocol> {
        Factory(self) { NetworkClient(baseUrl: Env.baseUrl, bearer: Env.bearer) }
    }

    private var permissionHandlerClient: Factory<PermissionHandlerProtocol> {
        Factory(self) { PermissionHandlerClient() }
    }

    private var textRecognizerClient: Factory<TextRecognizerProtocol> {
        Factory(self) { TextRecognizerClient() }
    }

    private var languageIdentifierClient: Factory<LanguageIdentifierProtocol> {
        Factory(self) { LanguageIdentifierClient() }
    }
}
