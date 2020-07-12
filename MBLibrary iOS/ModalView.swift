//
//  ModalView.swift
//  MBLibrary iOS
//
//  Created by Marco Boschi on 11/07/2020.
//  Original code by Guido Hendriks
//  https://stackoverflow.com/a/61239704/5031210
//  Copyright © 2020 Marco Boschi. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct ModalView<T: View>: UIViewControllerRepresentable {
    let view: T
    @Binding var isModal: Bool
    let onDismissalAttempt: (() -> Void)?

    func makeUIViewController(context: Context) -> UIHostingController<T> {
        UIHostingController(rootView: view)
    }

    func updateUIViewController(_ uiViewController: UIHostingController<T>, context: Context) {
        uiViewController.parent?.presentationController?.delegate = context.coordinator
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIAdaptivePresentationControllerDelegate {
        let modalView: ModalView

        init(_ modalView: ModalView) {
            self.modalView = modalView
        }

        func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
            !modalView.isModal
        }

        func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
            modalView.onDismissalAttempt?()
        }
    }
}

@available(iOS 13.0, *)
extension View {

    public func presentation(isModal: Binding<Bool>, onDismissalAttempt: (() -> Void)? = nil) -> some View {
        ModalView(view: self, isModal: isModal, onDismissalAttempt: onDismissalAttempt)
    }

}
