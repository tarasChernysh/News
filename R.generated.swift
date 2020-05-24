//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.image` struct is generated, and contains static references to 5 images.
  struct image {
    /// Image `defaulfImage`.
    static let defaulfImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "defaulfImage")
    /// Image `emptyList`.
    static let emptyList = Rswift.ImageResource(bundle: R.hostingBundle, name: "emptyList")
    /// Image `nav_more_icon`.
    static let nav_more_icon = Rswift.ImageResource(bundle: R.hostingBundle, name: "nav_more_icon")
    /// Image `search_icon`.
    static let search_icon = Rswift.ImageResource(bundle: R.hostingBundle, name: "search_icon")
    /// Image `unknowFormatImage`.
    static let unknowFormatImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "unknowFormatImage")
    
    /// `UIImage(named: "defaulfImage", bundle: ..., traitCollection: ...)`
    static func defaulfImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.defaulfImage, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "emptyList", bundle: ..., traitCollection: ...)`
    static func emptyList(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.emptyList, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "nav_more_icon", bundle: ..., traitCollection: ...)`
    static func nav_more_icon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.nav_more_icon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "search_icon", bundle: ..., traitCollection: ...)`
    static func search_icon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.search_icon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "unknowFormatImage", bundle: ..., traitCollection: ...)`
    static func unknowFormatImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.unknowFormatImage, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 4 nibs.
  struct nib {
    /// Nib `FilterTVC`.
    static let filterTVC = _R.nib._FilterTVC()
    /// Nib `NewsTVC`.
    static let newsTVC = _R.nib._NewsTVC()
    /// Nib `PlaceholderView`.
    static let placeholderView = _R.nib._PlaceholderView()
    /// Nib `SourceTVC`.
    static let sourceTVC = _R.nib._SourceTVC()
    
    /// `UINib(name: "FilterTVC", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.filterTVC) instead")
    static func filterTVC(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.filterTVC)
    }
    
    /// `UINib(name: "NewsTVC", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.newsTVC) instead")
    static func newsTVC(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.newsTVC)
    }
    
    /// `UINib(name: "PlaceholderView", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.placeholderView) instead")
    static func placeholderView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.placeholderView)
    }
    
    /// `UINib(name: "SourceTVC", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.sourceTVC) instead")
    static func sourceTVC(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.sourceTVC)
    }
    
    static func filterTVC(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> FilterTVC? {
      return R.nib.filterTVC.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? FilterTVC
    }
    
    static func newsTVC(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> NewsTVC? {
      return R.nib.newsTVC.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? NewsTVC
    }
    
    static func placeholderView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.placeholderView.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }
    
    static func sourceTVC(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SourceTVC? {
      return R.nib.sourceTVC.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SourceTVC
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 3 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `FilterTVC`.
    static let filterTVC: Rswift.ReuseIdentifier<FilterTVC> = Rswift.ReuseIdentifier(identifier: "FilterTVC")
    /// Reuse identifier `NewsTVC`.
    static let newsTVC: Rswift.ReuseIdentifier<NewsTVC> = Rswift.ReuseIdentifier(identifier: "NewsTVC")
    /// Reuse identifier `SourceTVC`.
    static let sourceTVC: Rswift.ReuseIdentifier<SourceTVC> = Rswift.ReuseIdentifier(identifier: "SourceTVC")
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
    try nib.validate()
  }
  
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _NewsTVC.validate()
      try _PlaceholderView.validate()
    }
    
    struct _FilterTVC: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = FilterTVC
      
      let bundle = R.hostingBundle
      let identifier = "FilterTVC"
      let name = "FilterTVC"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> FilterTVC? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? FilterTVC
      }
      
      fileprivate init() {}
    }
    
    struct _NewsTVC: Rswift.NibResourceType, Rswift.ReuseIdentifierType, Rswift.Validatable {
      typealias ReusableType = NewsTVC
      
      let bundle = R.hostingBundle
      let identifier = "NewsTVC"
      let name = "NewsTVC"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> NewsTVC? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? NewsTVC
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "defaulfImage", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'defaulfImage' is used in nib 'NewsTVC', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct _PlaceholderView: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "PlaceholderView"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "emptyList", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'emptyList' is used in nib 'PlaceholderView', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct _SourceTVC: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = SourceTVC
      
      let bundle = R.hostingBundle
      let identifier = "SourceTVC"
      let name = "SourceTVC"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SourceTVC? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SourceTVC
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
      try main.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let categoryVC = StoryboardViewControllerResource<CategoryVC>(identifier: "CategoryVC")
      let name = "Main"
      let newsCategoryVC = StoryboardViewControllerResource<NewsCategoryVC>(identifier: "NewsCategoryVC")
      let newsVC = StoryboardViewControllerResource<NewsVC>(identifier: "NewsVC")
      let searchVC = StoryboardViewControllerResource<SearchVC>(identifier: "SearchVC")
      let sourceVC = StoryboardViewControllerResource<SourceVC>(identifier: "SourceVC")
      
      func categoryVC(_: Void = ()) -> CategoryVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: categoryVC)
      }
      
      func newsCategoryVC(_: Void = ()) -> NewsCategoryVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: newsCategoryVC)
      }
      
      func newsVC(_: Void = ()) -> NewsVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: newsVC)
      }
      
      func searchVC(_: Void = ()) -> SearchVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: searchVC)
      }
      
      func sourceVC(_: Void = ()) -> SourceVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: sourceVC)
      }
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.main().categoryVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'categoryVC' could not be loaded from storyboard 'Main' as 'CategoryVC'.") }
        if _R.storyboard.main().newsCategoryVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'newsCategoryVC' could not be loaded from storyboard 'Main' as 'NewsCategoryVC'.") }
        if _R.storyboard.main().newsVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'newsVC' could not be loaded from storyboard 'Main' as 'NewsVC'.") }
        if _R.storyboard.main().searchVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'searchVC' could not be loaded from storyboard 'Main' as 'SearchVC'.") }
        if _R.storyboard.main().sourceVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'sourceVC' could not be loaded from storyboard 'Main' as 'SourceVC'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}