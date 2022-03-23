import SwiftUI
import Quartz
import AppKit

class QuicklookWrapper: NSObject
{
    private var previewURL : URL

    init (url : URL)
    {
        self.previewURL = url
        super.init()

        guard let panel = QLPreviewPanel.shared() else { return }
        
        if QLPreviewPanel.sharedPreviewPanelExists() && panel.isVisible {
            panel.orderOut(nil)
        }
        else {
            panel.dataSource = self
            panel.center()
            panel.makeKeyAndOrderFront(nil)
        }
    }
}

extension QuicklookWrapper: QLPreviewPanelDataSource {
    
    func numberOfPreviewItems(in panel: QLPreviewPanel!) -> Int {
        return 1
    }

    func previewPanel(_ panel: QLPreviewPanel!, previewItemAt index: Int) -> QLPreviewItem! {
        return previewURL as QLPreviewItem
    }
    
    override func acceptsPreviewPanelControl(_ panel: QLPreviewPanel!) -> Bool {
        return true
    }
}
