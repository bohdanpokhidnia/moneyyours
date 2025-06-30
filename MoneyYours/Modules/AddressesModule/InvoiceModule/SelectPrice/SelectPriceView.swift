//
//  SelectPriceView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 25.01.2025.
//

import SwiftUI

struct SelectPriceView: View {
    @FocusState private var isFocusedTextField: Bool
    @State private var priceText: String = ""
    @ObservedObject var viewModel: SelectPriceViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            saveButton
        }
        .overlay(alignment: .top) {
            contentView
        }
        .padding([.horizontal, .bottom], 16)
        .background(.invoiceBackground)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.backButtonTapped()
                } label: {
                    Image(systemName: "arrow.backward")
                        .tint(.beanRed)
                }
            }
        }
        .onAppear {
            priceText = viewModel.price.wrappedValue.sumString
        }
    }
}

private extension SelectPriceView {
    private var contentView: some View {
        VStack(spacing: 32) {
            Button {
                viewModel.priceTypeButtonTapped()
            } label: {
                SelectPriceRow(priceKind: viewModel.price.wrappedValue.kind)
            }
            
            priceTextField
            
            additionalFields
        }
    }
    
    private var priceTextField: some View {
        VStack(spacing: 8) {
            Text("Sum")
                .foregroundStyle(.slateGrey)
                .font(.footnote)
            
            HStack(spacing: 8) {
                PriceTextField(text: $priceText)
                    .background {
                        GeometryReader { geometry in
                            Color.clear
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                    .fixedSize()
                    .tint(.beanRed)
                    .keyboardType(.decimalPad)
                    .focused($isFocusedTextField)
                    .onChange(of: priceText) { oldValue, newValue in
                        viewModel.updatePrice(text: newValue)
                    }
                    .onReceive(viewModel.$isTextFieldFocused) { newValue in
                        // прокидаємо назад у View, коли ViewModel вирішив змінити фокус
                        if isFocusedTextField != newValue {
                            isFocusedTextField = newValue
                        }
                    }
                
                Text(viewModel.currency.string)
            }
            .font(.price)
        }
    }
    
    @ViewBuilder
    private var additionalFields: some View {
        switch viewModel.price.wrappedValue.kind {
        case .fixed:
            EmptyView()
            
        case .calculate:
            calculatePriceView
            
//        case .multi:
//            multiPriceView
        }
    }
    
    private var calculatePriceView: some View {
        HStack(spacing: 16) {
            TitleTextField(
                title: "Previously count",
                placeholder: "Value",
                text: $viewModel.oldCounterText
            )
//            .onChange(of: store.previouslyCounterText) { _, newValue in
//                store.previouslyCounterText = newValue.formatted(.priceInput)
//            }
            
            TitleTextField(
                title: "Current count",
                placeholder: "Value",
                text: $viewModel.newCounterText
            )
//            .onChange(of: store.currentCounterText) { _, newValue in
//                store.currentCounterText = newValue.formatted(.priceInput)
//            }
        }
        .keyboardType(.numberPad)
    }
    
//    private var multiPriceView: some View {
//        VStack(spacing: 16) {
//            calculatePriceView
//            
//            Divider()
            
//            HStack(spacing: 16) {
//                TitleTextField(
//                    title: "Previously count",
//                    placeholder: "Value",
//                    text: $store.multiPreviouslyCounterText
//                )
//                .onChange(of: store.multiPreviouslyCounterText) { _, newValue in
//                    store.multiPreviouslyCounterText = newValue.formatted(.priceInput)
//                }
//                
//                TitleTextField(
//                    title: "Current count",
//                    placeholder: "Value",
//                    text: $store.multiCurrentCounterText
//                )
//                .onChange(of: store.multiCurrentCounterText) { _, newValue in
//                    store.multiCurrentCounterText = newValue.formatted(.priceInput)
//                }
//            }
//            .keyboardType(.numberPad)
//        }
//    }
    
    private var saveButton: some View {
        Button("Save") {
            viewModel.saveButtonTapped()
        }
        .buttonStyle(
            BottomActionButtonStyle(fillColor: .beanRed)
        )
        .disabled(viewModel.isDisableSaveButton)
    }
}

#Preview {
    SelectPriceView(
        viewModel: SelectPriceViewModel(
            coordinator: .preview,
            price: .constant(.fixed(id: UUID(5), value: .zero))
        )
    )
}
