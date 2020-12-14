//
//  ViewController.swift
//  ClickableLabel2
//
//  Created by Kirill Suslov on 2020-11-26.
//

import UIKit
import CoreText

class ViewController: UIViewController{
    @IBOutlet var label1: UILabel!
	@IBOutlet var textView: UITextView!

    var linkRange: NSRange!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabel()
        setUpSecondLabel()
    }
    
    func setUpLabel() {
        let text = "Need help? Visit the "
        let link = "Help Center"
        let fullText = "\(text) \(link)"
        let attributedString = NSMutableAttributedString(string: fullText)
        linkRange = NSRange(location: text.count + 1, length: link.count)
        
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.blue,
            range: linkRange
        )
        
//        attributedString.addAttribute(
//            .font,
//            value: UIFont.systemFont(ofSize: 17),
//            range: NSRange(location: 0, length: fullText.count)
//        )
        
        label1.attributedText = attributedString
        label1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLabelTap)))
        label1.isUserInteractionEnabled = true
    }
    
    func setUpSecondLabel() {
		let text = "Need help? Visit the "
		let link = "Help Center"
		let fullText = "\(text) \(link)"
        let attributedString = NSMutableAttributedString(string: fullText)
        let linkRange = NSRange(location: text.count + 1, length: link.count)
        attributedString.addAttribute(
            .link,
            value: "https://www.hackingwithswift.com",
            range: linkRange)
		
		attributedString.addAttribute(
			.font,
			value: UIFont.systemFont(ofSize: 17),
			range: NSRange(location: 0, length: fullText.count)
		)
		
		textView.attributedText = attributedString
		textView.isUserInteractionEnabled = true
		textView.isScrollEnabled = false
		textView.isEditable = false
		textView.isSelectable = false
		textView.delegate = self
    }
    
    @objc func handleLabelTap(gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            guard let attributedString = label1.attributedText else { return }
            let textStorage = NSTextStorage(attributedString: attributedString)
            let layoutManager = NSLayoutManager()
            textStorage.addLayoutManager(layoutManager)
            let textContainer = NSTextContainer(size: label1.bounds.size)
            layoutManager.addTextContainer(textContainer)
            
            let location = gesture.location(in: label1)
            
            let characterIndex = layoutManager.characterIndex(for: location, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
            
            if characterIndex >= linkRange.location && characterIndex < linkRange.location + linkRange.length {
                doWhateverYouWant()
            }
        }
    }
    
    private func doWhateverYouWant() {
        print("The link was tapped, and I can do whatever I want now!")
    }
}

extension ViewController: UITextViewDelegate  {
	func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
		doWhateverYouWant()
		return true
	}
}
