module GeneralPagePO

General_xpath = "//UIAStaticText[@label='General']"
Back_xpath = "//UIAButton[@label='Go back']"
Array_xpath = "//UIAStaticText[@label='@varData']"
Array1_xpath = "//UIAButton[@label='@varData']" 
Xpath_btnInBluClr = "//XCUIElementTypeButton[@label='@varData' and @value = '1']"

### Add Portfolio/Watchlist window
AddSecuritytextbox_xpath = "//UIATextField[@label='Add Security']"
Alert_xpath = "//UIAAlert[@label='@varData']"
Xpath_textboxinalert9x ="//UIAStaticText[@label='@varData']/following-sibling::UIACollectionView[@value='page 1 of 1']/UIACollectionCell/UIATextField"
Xpath_textboxinalert = "//UIAStaticText[@label='@varData']/following-sibling::UIATableView[@value='moved to row 1 of 1']/UIATableCell/UIATextField"
Xpath_testgroupingcell = "//UIATableCell[@name='Test Grouping']/UIAStaticText[@label='Test Grouping']"
#Ibmusticker_xpath = "//UIATableGroup[@name = 'Equity']/following-sibling::UIATableCell/UIAStaticText[@label='@varData']" 
Verifyibmusticker_xpath = "//UIATableCell[@name ='Test Grouping']/following-sibling::UIATableCell/UIAStaticText[@label='@varData']"
Radiobtndisabled_xpath = "//XCUIElementTypeStaticText[@label='@varData']/following-sibling::XCUIElementTypeButton[contains(@label,'InlineToggle C') and not(contains(@value,'true'))]"
Radiobtnenabled_xpath = "//XCUIElementTypeStaticText[@label='@varData']/following-sibling::XCUIElementTypeButton[contains(@label,'InlineToggle C') and @value='1']"
Xpath_Watchlists = "//UIATableGroup[@name='Watch lists']/following-sibling::UIATableCell[@name = 'TEST123']"
Xpath_bottomtest123 = "//XCUIElementTypeStaticText[@label='TEST123']/ancestor::XCUIElementTypeCell/following-sibling::XCUIElementTypeCell"    #"//UIATableCell[@name = 'TEST123']/following-sibling::UIATableCell"
Xpath_TckrUndrTestGrp = "//XCUIElementTypeStaticText[@label='Test Grouping']/ancestor::XCUIElementTypeCell/following-sibling::XCUIElementTypeCell/XCUIElementTypeStaticText[@label='@varData']"
 def GeneralPagePO.Replace(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
 end
end