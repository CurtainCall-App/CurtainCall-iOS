// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum CommonAsset {
  public static let hex1C1E21 = CommonColors(name: "hex1C1E21")
  public static let hex32363D = CommonColors(name: "hex32363D")
  public static let hex464B51 = CommonColors(name: "hex464B51")
  public static let hex71757C = CommonColors(name: "hex71757C")
  public static let hexA1A5AE = CommonColors(name: "hexA1A5AE")
  public static let hexC6C8CD = CommonColors(name: "hexC6C8CD")
  public static let hexE5E7EB = CommonColors(name: "hexE5E7EB")
  public static let hexF1F1F5 = CommonColors(name: "hexF1F1F5")
  public static let hexF8F8F8 = CommonColors(name: "hexF8F8F8")
  public static let hex0D1327 = CommonColors(name: "hex0D1327")
  public static let hexA9E7FA = CommonColors(name: "hexA9E7FA")
  public static let hexD4C6FD = CommonColors(name: "hexD4C6FD")
  public static let hexFFFCAB = CommonColors(name: "hexFFFCAB")
  public static let hex00C271 = CommonColors(name: "hex00C271")
  public static let hexFF334B = CommonColors(name: "hexFF334B")
  public static let hexFFD600 = CommonColors(name: "hexFFD600")
  public static let white = CommonColors(name: "white")
  public static let toastBackgroundGray = CommonColors(name: "toastBackgroundGray")
  public static let loginApple = CommonImages(name: "login_apple")
  public static let loginComment = CommonImages(name: "login_comment")
  public static let loginKakaotalk = CommonImages(name: "login_kakaotalk")
  public static let loginNaver = CommonImages(name: "login_naver")
  public static let navigationBackIcon = CommonImages(name: "navigation_back_icon")
  public static let checkIconGray14px = CommonImages(name: "check_icon_gray_14px")
  public static let checkIconGreen14px = CommonImages(name: "check_icon_green_14px")
  public static let toastFailedIcon24px = CommonImages(name: "toast_failed_icon_24px")
  public static let toastSuccessIcon24px = CommonImages(name: "toast_success_icon_24px")
  public static let checkOffIcon20px = CommonImages(name: "check_off_icon_20px")
  public static let checkOnIcon20px = CommonImages(name: "check_on_icon_20px")
  public static let logoSplash64px = CommonImages(name: "logo_splash_64px")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class CommonColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension CommonColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: CommonColors) {
    let bundle = CommonResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: CommonColors) {
    let bundle = CommonResources.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct CommonImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = CommonResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension CommonImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the CommonImages.image property")
  convenience init?(asset: CommonImages) {
    #if os(iOS) || os(tvOS)
    let bundle = CommonResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: CommonImages) {
    let bundle = CommonResources.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: CommonImages, label: Text) {
    let bundle = CommonResources.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: CommonImages) {
    let bundle = CommonResources.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
