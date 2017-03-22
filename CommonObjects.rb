module CommonObjects
    
    StaticText_xpath = "//XCUIElementTypeStaticText[@label='@varData']"
    ButtonType_xpath = "//XCUIElementTypeButton[@label='@varData']"
    ContainsLabel_xpath = "//XCUIElementTypeStaticText[contains(@label,'@varData')]"
    def CommonObjects.ReplaceString(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
    end
end 