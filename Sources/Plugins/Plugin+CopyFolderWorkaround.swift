//
//  Plugin+CopyFolderWorkaround.swift
//
//
//  Created by Yuhan Chen on 2025/07/05.
//

import Foundation
import Publish

private enum CopyFolderError: Error {
    case invalidSourceDirectory
}

extension Plugin {
    /// In the latest versions, `copyItem(at:to:)` cannot copy folders correctly without a trailing slash.
    /// This is necessary because currently the `Publish` library is not actively maintained, and this workaround
    /// ensures subfolders are copied correctly.
    public static func copyResourcesWorkaround() -> Self {
        Plugin(name: "CopyResourcesWorkaround") { context in
            let resourcesFolder = try context.folder(at: "Resources")
            let outputFolder = try context.folder(at: "Output")
            
            try copyFolder(from: resourcesFolder.url, to: outputFolder.url)
        }
    }
    
    private static func copyFolder(
        from sourceURL: URL,
        to destinationURL: URL
    ) throws {
        let fileManager = FileManager.default
        
        // Ensure the source URL points to a valid directory
        let isSourceDirectory = (try sourceURL.resourceValues(forKeys: [.isDirectoryKey])).isDirectory
        guard isSourceDirectory == true else {
            throw CopyFolderError.invalidSourceDirectory
        }

        // Create the destination directory if it doesn't exist
        try fileManager.createDirectory(
            at: destinationURL,
            withIntermediateDirectories: true
        )
        
        // Get the contents of the source directory
        let contents = try fileManager.contentsOfDirectory(
            at: sourceURL,
            includingPropertiesForKeys: nil
        )
        
        for sourceItemURL in contents {
            let fileName = sourceItemURL.lastPathComponent
            let destinationItemURL = destinationURL.appendingPathComponent(fileName)
            
            // Remove the destination item if it already exists
            if fileManager.fileExists(atPath: destinationItemURL.path) {
                try fileManager.removeItem(at: destinationItemURL)
            }
            
            // Copy the source item to the destination
            try fileManager.copyItem(at: sourceItemURL, to: destinationItemURL)
        }
    }
}
