# SHTextStorage
A Swift Package containing an `NSTextStorage` subclass for syntax highlighting, and supporting classes for defining language regex rules / color matching, written in Objective-C. As the user enters text, all line(s) falling under the edited range will be reprocessed with the rule set.

![Demo](/Screenshots/demo-asm6.gif)

## Why Objective-C and not Swift?
Performance is the main reason. `NSTextStorage`, when subclassed in Swift, exposes a Swift-style `String` property, along with methods for reading and setting formatting attributes across different ranges of the string.  A `UITextView` is still based on `NSString` / `NSAttributedString` under the hood, and the Swift-style `String` property in the `NSTextStorage` would be constantly read and converted to `NSString` / `NSAttributedString`. For small amounts of text, this was still fine, but anything larger was noticeably slower when using a Swift-based `NSTextStorage` subclass.

## Future plans
- add more tests
- clean up interface
- support some common languages out of the box, either via a separate Swift package that depends on this one, or as built-in languages in this package.

## Example usage in a UIViewController
```swift
import UIKit
import SHTextStorage

class SHViewController: UIViewController {
    static private let fontSize: CGFloat = 23.0
    
    // Define language regex rules, which will be applied in the order listed
    static private let language = SHLanguage(
        name: "6502 Assembly (ASM6)",
        rules: [
            SHRule(
                pattern: "(\\s|^)(clc|cld|cli|dex|dey|inx|iny|nop|pha|pla|rti|rts|sei|tax|tay|tsx|txa|txs|tya|adc|and|asl|bcc|bcs|beq|bit|bmi|bne|bpl|brk|bvc|bvs|clv|cmp|cpx|cpy|dec|eor|inc|jmp|jsr|lda|ldx|ldy|lsr|ora|php|plp|rol|ror|sbc|sec|sed|sta|stx|sty)(\\s|$)",
                options: [.caseInsensitive, .anchorsMatchLines],
                category: .keyword),
            SHRule(
                pattern: "(\\s|^)(\\.?)(pad|org|byte|word|align|incbin|bin|include|incsrc|error|enum|ende|rept|endr|macro|endm|ifdef|ifndef|if|else|elseif|endif|base|fillvalue|dsb|dsw|hex|dl|dh|db|dw|equ)(\\s|$)",
                options: [.caseInsensitive, .anchorsMatchLines],
                category: .directive),
            SHRule(
                pattern: "\\$([0-9a-f])+",
                options: [.caseInsensitive],
                category: .hex),
            SHRule(
                pattern: "#\\$([0-9a-f])+",
                options: [.caseInsensitive],
                category: .hexLiteral),
            SHRule(
                pattern: "\\%([0-1])+",
                options: [],
                category: .binary),
            SHRule(
                pattern: "#\\%([0-1])+",
                options: [],
                category: .binaryLiteral),
            SHRule(
                pattern: "#([0-9])+",
                options: [],
                category: .decimal),
            SHRule(
                pattern: ",",
                options: [],
                category: .default),
            SHRule(
                pattern: ";(.*)$",
                options: [.anchorsMatchLines],
                category: .comment)
    ])
    
    // define UIColor for SHCategory text types used by the defined rules
    static private let colors: [SHColor] = [
        SHColor(category: .default, color: .label),
        SHColor(category: .keyword, color: .systemRed),
        SHColor(category: .directive, color: .brown),
        SHColor(category: .hex, color: .systemBlue),
        SHColor(category: .hexLiteral, color: .systemIndigo),
        SHColor(category: .binary, color: .systemGreen),
        SHColor(category: .binaryLiteral, color: .systemTeal),
        SHColor(category: .decimal, color: .systemPink),
        SHColor(category: .comment, color: .secondaryLabel)
    ]
    
    // define NSTextStorage subclass
    private let textStorage: SHTextStorage = SHTextStorage(
        language: SHViewController.language,
        colors: SHViewController.colors,
        fontSize: SHViewController.fontSize,
        logging: false)
    
    // create UITextView with SHTextStorage
    private lazy var srcTextView: UITextView =
    {
        let layoutManager = NSLayoutManager()
        layoutManager.allowsNonContiguousLayout = false
        self.textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer()
        layoutManager.addTextContainer(textContainer)
        let view = UITextView(frame: .zero, textContainer: textContainer)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = self.textStorage.font
        view.backgroundColor = UIColor.systemBackground
        view.autocorrectionType = UITextAutocorrectionType.no
        view.dataDetectorTypes = []
        view.smartInsertDeleteType = .no
        view.smartDashesType = .no
        view.smartQuotesType = .no
        view.autocapitalizationType = .none
        view.keyboardType = .asciiCapable
        return view
    }()
    
    // add UiTextView to view hierarchy
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.srcTextView)
        NSLayoutConstraint.activate([
            self.srcTextView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.srcTextView.leadingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.srcTextView.trailingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.srcTextView.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
```
