import SwiftUI
import SwiftData
import AlertToast

struct SettingsScreen: View {
    @Query var routines: [Routine]
    @Query var blocks: [Block]
    @Environment(\.modelContext) private var modelContext
    @Environment(AppState.self) var appState
    
    @State private var isImporting = false
    @State private var isExporting = false
    
    @State private var toastShow = false
    @State private var toastText = ""
    @State private var toastType = AlertToast.AlertType.complete(.green)

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        ShareLink(
                            item: Backup(routines: routines, blocks: blocks),
                            preview: SharePreview(Date().getBackupFileName(), image: Image("Backup"))
                        ) {
                            Text("Backup to file")
                        }
                        
                        Button(action: {
                            isImporting = true
                        }) {
                            Text("Restore from Backup")
                        }
                    }
                }
                .fileImporter(isPresented: $isImporting,
                                allowedContentTypes: [.json]) { res in
                    do {
                        
                        let fileUrl = try res.get()
                        if fileUrl.startAccessingSecurityScopedResource() {
                            let fileData = try Data(contentsOf: fileUrl)
                            let backup = try JSONDecoder().decode(Backup.self, from: fileData)
                            try restoreBackup(backup: backup)
                            showToast(text: "The backup was successfully restored", type: .complete(.green))
                        }
                    } catch  {
                        showToast(text: "Error: Backup Failed", type: .error(.red))
                    }
                 }
                .scrollContentBackground(.hidden)
                .navigationBarTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(InsetGroupedListStyle())
                
            }
            .background {
                VStack(alignment: .center)  {
                    Spacer()
                    Image("Smuzy_Settings")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.4)
                        .padding(.bottom, 20)
                        .frame(width: 100, height: 220)
                    Text("App version \(Bundle.main.releaseVersionNumber) (\(Bundle.main.buildVersionNumber))")
                        .foregroundColor(.gray.opacity(0.3))
                        .listRowBackground(Color.clear)
                        .padding(.bottom, 30)
                    
                }
            }
        }
        .toast(isPresenting: $toastShow) {
            AlertToast(displayMode: .hud, type: toastType, title: toastText)
        }
    }

    func restoreBackup(backup: Backup) throws {
        try modelContext.delete(model: Routine.self)
        try modelContext.delete(model: Block.self)
        try modelContext.save()
        backup.routines.forEach { modelContext.insert($0) }
        backup.blocks.forEach { modelContext.insert($0) }
        try modelContext.save()
        appState.loadDayGrid(modelContext: modelContext)
    }
    
    func showToast(text: String, type: AlertToast.AlertType) {
        toastType = type
        toastText = text
        toastShow = true
    }
}

#Preview {
    SettingsScreen()
        .environment(AppState())
        .modelContainer(for: [Routine.self, Block.self])
}
