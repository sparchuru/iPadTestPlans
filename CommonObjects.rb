module CommonObjects
    
    StaticText_xpath = "//XCUIElementTypeStaticText[@label='@varData']"
    ButtonType_xpath = "//XCUIElementTypeButton[@label='@varData']"
    ContainsLabel_xpath = "//XCUIElementTypeStaticText[contains(@label,'@varData')]"
    InputField_xpath = "//XCUIElementTypeTextField[@label='@varData']"  
    AlertWndw_xpath = "//XCUIElementTypeAlert[@label='@varData']"
    AletWbdw1_xpath = '//XCUIElementTypeAlert[1]'
    def CommonObjects.ReplaceString(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
    end
end 