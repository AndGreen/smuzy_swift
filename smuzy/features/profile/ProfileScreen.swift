import SwiftUI
import SwiftData
import AlertToast

struct Backup: Codable {
    var routines: [Routine]
    var blocks: [Block]
}

extension Backup: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .json)
            .suggestedFileName(Date().getBackupFileName())
    }
}

struct SettingsScreen: View {
    @Query var routines: [Routine]
    @Query var blocks: [Block]
    @Environment(\.modelContext) private var modelContext
    
    @State private var isImporting = false
    @State private var isExporting = false
    
    @State private var isToastShow = false
    @State private var toastText = ""
    @State private var toastType = AlertToast.AlertType.complete(.green)

    var body: some View {
        NavigationView {
            List {
                Section {
                    ShareLink(
                        item: Backup(routines: routines, blocks: blocks),
                        preview: SharePreview(Date().getBackupFileName(), image: Image(systemName: "book.pages")
                        )
                    ) {
                        Text("Backup to file")
                    }
                    
                    Button(action: {
                        isImporting = true
                    }) {
                        Text("Restore from Backup")
                    }
                }

                Text("App version \(Bundle.main.releaseVersionNumber) (\(Bundle.main.buildVersionNumber))")
                    .frame(
                        maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.gray.opacity(0.3))
                    .listRowBackground(Color.clear)
            }
            .fileImporter(isPresented: $isImporting,
                            allowedContentTypes: [.json]) { res in
                do {
                    let fileUrl = try res.get()
                    let fileData = try Data(contentsOf: fileUrl)
                    let backup = try JSONDecoder().decode(Backup.self, from: fileData)
                    restoreBackup(backup: backup)
                } catch{
                    print ("error reading: \(error.localizedDescription)")
                }
                
             }
            .background(Color("Background"))
            .scrollContentBackground(.hidden)
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(InsetGroupedListStyle())
        }
        
    }

    func restoreBackup(backup: Backup) {
         backup.routines.forEach { modelContext.insert($0) }
         backup.blocks.forEach { modelContext.insert($0) }
    }
    
}

#Preview {
    SettingsScreen()
        .environment(AppState())
        .modelContainer(for: [Routine.self, Block.self])
}
