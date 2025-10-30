import SwiftUI

struct AddOrEditNoteView: View {
    // Optional existing note fields for edit mode
    var existingTitle: String?
    var existingContent: String?

    // Called when user taps Save; returns the entered title and content
    var onSave: (String, String) -> Void

    // Dismiss handler (usually provided by parent via environment)
    @Environment(\.dismiss) private var dismiss

    // Local editable state
    @State private var title: String = ""
    @State private var content: String = ""

    // Validation
    private var isSaveDisabled: Bool {
        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    init(existingTitle: String? = nil,
         existingContent: String? = nil,
         onSave: @escaping (String, String) -> Void) {
        self.existingTitle = existingTitle
        self.existingContent = existingContent
        self.onSave = onSave
        // _title and _content will be set in body via .task or .onAppear
    }

    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter title", text: $title)
                    .textInputAutocapitalization(.sentences)
            }

            Section(header: Text("Content")) {
                TextEditor(text: $content)
                    .frame(minHeight: 160)
            }
        }
        .navigationTitle(existingTitle == nil ? "Add Note" : "Edit Note")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    let t = title.trimmingCharacters(in: .whitespacesAndNewlines)
                    let c = content.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !t.isEmpty, !c.isEmpty else { return }
                    onSave(t, c)
                    dismiss()
                }
                .disabled(isSaveDisabled)
            }
        }
        .onAppear {
            if let existingTitle, !existingTitle.isEmpty {
                self.title = existingTitle
            }
            if let existingContent, !existingContent.isEmpty {
                self.content = existingContent
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddOrEditNoteView(existingTitle: nil, existingContent: nil) { title, content in
            print("Saved: \(title) / \(content)")
        }
    }
}
