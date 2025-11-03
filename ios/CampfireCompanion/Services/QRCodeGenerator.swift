import CoreImage
import CoreImage.CIFilterBuiltins
import UIKit

struct QRCodeGenerator {
    private let context = CIContext()

    func makeImage(from text: String, size: CGFloat = 240) -> UIImage? {
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(text.utf8)
        filter.correctionLevel = "H"

        guard let outputImage = filter.outputImage else {
            return nil
        }

        let scale = size / outputImage.extent.size.width
        let transformedImage = outputImage.transformed(by: CGAffineTransform(scaleX: scale, y: scale))

        guard let cgImage = context.createCGImage(transformedImage, from: transformedImage.extent) else {
            return nil
        }

        return UIImage(cgImage: cgImage)
    }
}
