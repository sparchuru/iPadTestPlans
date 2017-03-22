module IPhoneHomePagePO
    
    Xpath_hamburger ='//UIAButton[@label="Navigation list"]'
    Xpath_homebutton = '//UIAStaticText[@label="HOME"]'
    Xpath_PencilButton = "//UIAButton[@label='Navigation edit']"
    Xpath_searchIcon = "//UIAButton[@label='Search']"
    Xpath_newsHeadline = "//UIATableGroup[contains(@name,'@varData')]"
    Xpath_newsHeadlineUndrSection = "//UIATableGroup[contains(@name,'@varData')]/following-sibling::UIATableGroup[1]/preceding-sibling::UIATableCell[1]"
    Xpath_newsHeadlineUndrLastSection = "//UIATableGroup[contains(@name,'@varData')]/following-sibling::UIATableCell[1]"
    Xpath_doneBtnInStryPage = "//UIAButton[@label='DONE']"
    Xpath_sectionType ='//UIATableView[contains(@label,"@varData")]'
    Xpath_sectionPageOpened = "//UIAButton[@labe='@varData']"
    Xpath_homeInstoryPage = '//UIAButton[@label="Go back"]'
    Xpath_reportsActivInFavorites = '//UIAButton[@label="REPORTS" and @value="1"]'
    Xpath_QuotsInFavoritesPage = '//UIAElement[@label="Quote"]'
    Xpath_EventlClndrPage = "//UIAStaticText[@label='@varData']"
    Xpath_TabsInStoryPage ="//UIAButton[@label='@varData']"
    Xpath_window = "//UIATableView[1]"
  Xpath_settingsbutton = "//UIAButton[@label='SETTINGS']"
    Xpath_firsttablegrouptext = "//UIAApplication/UIAWindow/UIATableView[1]/UIATableGroup[1]/UIAStaticText[@label='Top News']"
    Xpath_lasttablegrouptext  = "//UIATableGroup[@name='Top News']/UIAStaticText[@label='Top News']"
    #After clicked on hamburger (home ,markets,news.... portfolio dashboard) and tablegroups
    Common_xpath ="//UIAStaticText[@label='@varData']"
  TablegroupsinHome_xpath = "//UIATableGroup[@name='@varData']"
  Xpath_totaltablegroups = "//UIAApplication/UIAWindow/UIATableView[1]/UIATableGroup"
    #Open the story under the tablegroup if label is present
    Pctablecell_xpath = "//UIATableGroup[@name='Portfolio Contribution Summary']/following-sibling::UIATableCell/UIAStaticText[@label='@varData']"
    Wlisttablecell_xpath = "//UIATableGroup[@name='Watch List Summary']/following-sibling::UIATableCell/UIAStaticText[@label='@varData']"
  Eventsummarytablecell_xpath = "//UIATableGroup[contains(@name,'Events Summary')]/following-sibling::UIATableCell/UIAStaticText[@label='@varData']"
    # count the number of tablecell in middle tablegroup
    ContainsLabel_xpath = "//XCUIElementTypeStaticText[contains(@label,'@varData')]"
    Tablegroup_xpath = "//XCUIElementTypeStaticText[@label = '@varData']/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeCell" 
    Tablegroup1_xpath = "//XCUIElementTypeStaticText[@label = '@varData']/ancestor::XCUIElementTypeOther[1]//following-sibling::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeCell"
  Identifierlookup_xpath = "//UIAStaticText[@label='Identifier Lookup']"   #new
    Searchtext_xpath = "//UIATextField[@label = 'Search']"
    FDSUSticker_xpath = "//UIATableGroup[@name = 'Equity']/following-sibling::UIATableCell/UIAStaticText[@label='FDS-US']"
  Xpath_reportsinactive = '//UIAButton[@label="@varData" and @value=""]'  #new
    Xpath_newsBtnActive  = '//UIAButton[@label="@varData" and @value="1"]'  #new
    Xpath_Newsheadlines   = "//UIATableView[@label = 'FDSNewsHeadlinesTableViewController']/UIATableCell"
    Xpath_Newsheadline  = "//UIATableView[@label = 'FDSNewsHeadlinesTableViewController']/UIATableCell[1]"
    Xpath_facebookStry  = "//UIAStaticText[contains(@label,'@varData')]"
  
    def IPhoneHomePagePO.ReplaceString(xpath, replacingWord, originalWord = "@varData")
        return xpath.gsub originalWord, replacingWord
    end
end 