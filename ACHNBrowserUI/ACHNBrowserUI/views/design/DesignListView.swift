//
//  DesignListView.swift
//  ACHNBrowserUI
//
//  Created by Otavio Cordeiro on 27.05.20.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI

struct DesignListView: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: DesignListViewModel
    @State private var sheet: Sheet.SheetType?

    // MARK: - Life cycle

    init(viewModel: DesignListViewModel = DesignListViewModel()) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        List {
            Button(action: {
                self.sheet = .designForm(editingDesign: nil)
            }, label: {
                Text("Add Creator/Design Item")
                    .foregroundColor(.acHeaderBackground)
            })

            ForEach(viewModel.designs) { design in
                DesignRowView(viewModel: DesignRowViewModel(design: design))
            }.onDelete { indexes in
                self.viewModel.deleteDesign(at: indexes.first!)
            }
        }
        .navigationBarTitle(Text("Designs"), displayMode: .automatic)
        .sheet(item: $sheet, content: { Sheet(sheetType: $0) })
    }
}

// MARK: - Preview

#if DEBUG
struct DesignListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DesignListView()
        }
    }
}
#endif
