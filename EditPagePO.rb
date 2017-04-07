module EditPagePO

##################### after clicked on Portfolio contribution Summary and Watch List summary
Radiobuttonactivated_xpath = "//XCUIElementTypeCell[@varData]/XCUIElementTypeButton[contains(@label,'Exclude Off Q') and @value='true']"
Radiobuttondeactivated_xpath = "//XCUIElementTypeCell[@varData]/XCUIElementTypeButton[contains(@label,'Exclude Off Q') and @value='']"
EvntSmryActvRdioBtn_xpath = "//XCUIElementTypeStaticText[contains(@label,'Events Summary')]/following-sibling::UIAButton[@value='true']"
EvntSmryDeActvRdioBtn_xpath = "//XCUIElementTypeStaticText[contains(@label,'Events Summary')]/following-sibling::UIAButton[@value='']"

ActvRdioBtn_xpath = "//XCUIElementTypeButton[@value = '1']"
FirstActivRdioBtn_xpath = "//XCUIElementTypeButton[@value = '1'][1]"

 def EditPagePO.Replace(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
 end
end
