//
//  DetectorView.swift
//  GPTDetectorSwiftUI
//
//  Created by cem on 27.08.2023.
//

import SwiftUI

struct DetectorView: View {
    @StateObject private var detectorViewModel = DetectorViewModel(detectorService: DetectorService())

    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            VStack(spacing: .spacing.high) {
                HeaderView()
                    .padding(.horizontal)
                DetectionResutlView(detectionResponse: detectorViewModel.detectionResult)
                ZStack {
                    TextEditorWithPlaceholder(text: $detectorViewModel.userInput, placeholder: "Paste text or type here...")
                    DetectorButtonsView(clearAction: detectorViewModel.clearUserInput)
                        .padding()
                }
                HelperTextView(isValidInput: detectorViewModel.isValidInput, inputLength: detectorViewModel.userInputLength)
                AsyncButton(action: {
                    await detectorViewModel.detect()
                }, isLoading: detectorViewModel.isLoading, isDisabled: detectorViewModel.isLoading || !detectorViewModel.isValidInput, buttonTitle: "Analyze")
            }
            .padding()
            .alert(isPresented: $detectorViewModel.showingError) {
                Alert(title: Text("Oops, Something Went Wrong"), message: Text("Don't worry, it's not your fault. Our team is on it."))
            }
        }
        .onTapGesture {
            self.endTextEditing()
        }
    }
}

struct DetectorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetectorView()
        }
    }
}
