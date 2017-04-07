module IPhoneHomePagePO
    
  Xpath_newsHeadlineUndrLastSection = '//XCUIElementTypeStaticText[contains(@label,"@varData")]/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeCell[1]//XCUIElementTypeStaticText
  #EvntSmryTableGrpInHome_xpath = 
  Xpath_totaltablegroups = "//XCUIElementTypeTable[1]/XCUIElementTypeOther" #/XCUIElementTypeStatiText"   
  Xpath_tableGrp = "//XCUIElementTypeTable[1]/XCUIElementTypeOther[@varData]/XCUIElementTypeStaticText"
  #Open the story under the tablegroup if label is present
  Pctablecell_xpath = "//XCUIElementTypeStaticText[@label='Portfolio Contribution Summary']/ancestor::XCUIElementTypeOther/following-sibling::XCUIElementTypeCell/XCUIElementTypeStaticText[@label='@varData']"
  Wlisttablecell_xpath = "//UIATableGroup[@name='Watch List Summary']/following-sibling::UIATableCell/UIAStaticText[@label='@varData']"
  Eventsummarytablecell_xpath = "//UIATableGroup[contains(@name,'Events Summary')]/following-sibling::UIATableCell/UIAStaticText[@label='@varData']"
  # count the number of tablecell in middle tablegroup
  Tablegroup_xpath = "//XCUIElementTypeStaticText[@label = '@varData']/ancestor::XCUIElementTypeOther/following-sibling::XCUIElementTypeCell" 
  Tablegroup1_xpath = "//XCUIElementTypeStaticText[@label = '@varData']/ancestor::XCUIElementTypeOther[1]//following-sibling::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeCell"
  EventSmryTbleGrpXpath = "//XCUIElementTypeStaticText[contains(@label,'Events Summary')]/ancestor::XCUIElementTypeOther[1]//following-sibling::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeCell"
  Xpath_TbleCelsUndrSection = "//XCUIElementTypeCell[preceding-sibling::XCUIElementTypeOther/XCUIElementTypeStaticText[contains(@label,'@varData')] and following-sibling::XCUIElementTypeOther][@secondparam]/XCUIElementTypeStaticText[1]"
  Xpath_TbleCelsUndrLastSection = '//XCUIElementTypeOther[@varData]/following-sibling::XCUIElementTypeCell/XCUIElementTypeStaticText[1]'
  Xpath_sectionsInHome = '//XCUIElementTypeOther/XCUIElementTypeStaticText'
  Xpath_specificCellUndrSection = '//XCUIElementTypeStaticText[contains(@label,"@varData")]/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeCell[@secondparam]//XCUIElementTypeStaticText'
# Xpath_firstHdLineUndrSection = '//XCUIElementTypeStaticText["@varData"]/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeCell[1]'
    def IPhoneHomePagePO.ReplaceString(xpath, replacingWord, replacingWord1 = nil ,originalWord = "@varData",originalWord1 = '@secondparam')
        if replacingWord1 == nil
           return xpath.gsub originalWord, replacingWord
        else
            return (xpath.gsub originalWord, replacingWord).gsub(originalWord1,replacingWord1)
        end  
        
    end
    
end 
