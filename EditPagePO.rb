module EditPagePO

Summarywndw_xpath = "//XCUIElementTypeButton[@label='Go back']/following-sibling::XCUIElementTypeStaticText[@label='@varData']"
# radio button followed to the tickers 
Activate_xpath = "//XCUIElementTypeStaticText[@label='@varData']/following-sibling::XCUIElementTypeButton[@value='1']"
Deactivate_xpath = "//XCUIElementTypeStaticText[@label='@varData']/following-sibling::XCUIElementTypeButton[not(contains(@value,'true'))]"
##################### after clicked on Portfolio contribution Summary and Watch List summary
Radiobuttonactivated_xpath = "//XCUIElementTypeCell[@varData]/XCUIElementTypeButton[contains(@label,'Exclude Off Q') and @value='1']"
Radiobuttondeactivated_xpath = "//XCUIElementTypeCell[@varData]/XCUIElementTypeButton[contains(@label,'Exclude Off Q') and not(contains(@value,'true'))]"
ActvRdioBtn_xpath = "//XCUIElementTypeButton[@value = '1']"
FirstActivRdioBtn_xpath = "//XCUIElementTypeButton[@value = '1'][1]"
Textofportfolios_xpath = "//XCUIElementTypeCell[@varData]//XCUIElementTypeButton[contains(@label,'Exclude Off Q') and @value='1']/preceding-sibling::XCUIElementTypeStaticText"

EvntSmryActvRdioBtn_xpath = "//XCUIElementTypeStaticText[contains(@label,'Events Summary')]/following-sibling::UIAButton[@value='true']"
EvntSmryDeActvRdioBtn_xpath = "//XCUIElementTypeStaticText[contains(@label,'Events Summary')]/following-sibling::UIAButton[@value='']"
# Read the text of the tickers in 
Tablecellstext_xpath = "//XCUIElementTypeApplication//XCUIElementTypeWindow[1]//XCUIElementTypeCell[@varData]/UIAStaticText"
Reordercell_xpath = "//XCUIElementTypeApplication//XCUIElementTypeWindow[1]//XCUIElementTypeCell[@varData]/XCUIElementTypeButton[contains(@label,'Reorder')]"
Ticker_xapth ="//XCUIElementTypeStaticText[@label='@varData']"


 def EditPagePO.Replace(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
 end
end
