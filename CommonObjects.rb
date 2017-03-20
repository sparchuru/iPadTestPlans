module CommonObjects
    
    StaticText_xpath = "//XCUIElementTypeStaticText[@label='@varData']"
    ButtonType_xpath = "//XCUIElementTypeStaticButton[@label='@varData']"
    def CommonObjects.ReplaceString(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
    end
end 