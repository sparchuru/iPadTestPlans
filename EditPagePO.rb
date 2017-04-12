module EditPagePO

Done_xpath = "//UIAButton[@label='DONE']"
Cancel_xpath = "//UIAButton[@label='CANCEL']"
Grabber_xpath ="//UIAButton[@label='@varData']"
Reordercell_xpath = "//UIAApplication/UIAWindow[1]/UIATableView[1]/UIATableCell[@varData]/UIAButton[contains(@label,'Reorder')]"
# Read the text of the tickers in 
Tablecellstext_xpath = "//UIAApplication/UIAWindow[1]/UIATableView[1]/UIATableCell[@varData]/UIAStaticText"
# radio button followed to the tickers 
Activate_xpath = "//XCUIElementTypeStaticText[@label='@varData']/following-sibling::XCUIElementTypeButton[@value='1']"
Deactivate_xpath = "//XCUIElementTypeStaticText[@label='@varData']/following-sibling::XCUIElementTypeButton[not(@value='1')]"
#tablecell ticker xpath
Ticker_xapth ="//UIAStaticText[@label='@varData']"

##################### Verify the opened ticker same as tapped from edit window 
Summarywndw_xpath = "//UIAButton[@label='Go back']/following-sibling::UIAStaticText[@label='@varData']"
Element_xpath = "//UIAButton[@label='@varData']" #it is for holding,news...
##################### after clicked on Portfolio contribution Summary and Watch List summary
Radiobuttonactivated_xpath = "//XCUIElementTypeCell[@varData]/XCUIElementTypeButton[contains(@label,'Exclude Off Q') and @value='true']"
Textofportfolios_xpath = "//UIATableCell[@varData]/UIAButton[contains(@label,'Exclude Off Q') and @value='1']/preceding-sibling::UIAStaticText"
Radiobuttondeactivated_xpath = "//XCUIElementTypeCell[@varData]/XCUIElementTypeButton[contains(@label,'Exclude Off Q') and @value='']"
EvntSmryActvRdioBtn_xpath = "//XCUIElementTypeStaticText[contains(@label,'Events Summary')]/following-sibling::UIAButton[@value='true']"
EvntSmryDeActvRdioBtn_xpath = "//XCUIElementTypeStaticText[contains(@label,'Events Summary')]/following-sibling::UIAButton[@value='']"

ActvRdioBtn_xpath = "//XCUIElementTypeButton[@value = '1']"
FirstActivRdioBtn_xpath = "//XCUIElementTypeButton[@value = '1'][1]"


Backbutton_xpath = "//UIAButton[@label='Go back']"
##############  Afetr click on any ticker in the edit page.
Items_xpath = "//UIAStaticText[@label='@varData']"
Radiobtnoftest_xpath = "//UIAStaticText[@label='TEST123']/following-sibling::UIAButton[contains(@label,'Exclude Off Q')]"
Wndw_xpath ="//UIATableView[1]"
Radiobtnoftestenabled_xpath = "//UIAStaticText[@label='TEST123']/following-sibling::UIAButton[contains(@label,'Exclude Off Q') and @value='1']"
Radiobtnoftestdisabled_xpath = "//UIAStaticText[@label='TEST123']/following-sibling::UIAButton[contains(@label,'Exclude Off Q') and @value='']"

 def EditPagePO.Replace(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
 end
end