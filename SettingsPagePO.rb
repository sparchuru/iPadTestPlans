module SettingsPagePO
    GeneralXpath = "//XCUIElementTypeCell[@label='@varData']" #this is to  get the xpaths of left panel elements in Settings page
    CommonXpath  = "//XCUIElementTypeStaticText[@label='@varData']" # for all static text type in  general page.
    ButtontypeXpath = "//XCUIElementTypeButton[@label='@varData']"  # buttons in General page 
    NavigationtileXpath = "//XCUIElementTypeImage[@name='TileNav_Q']"   #  arrow mark in home page setup window 
   # Inhouse page objects
   LimaOverRideFieldXpath = '//XCUIElementTypeTextField[@label="override name"]'
  #AlertOkXpath = ''
   UseStagingSwitchXpath = "//XCUIElementTypeSwitch[@label='staging switch']"
   InhousePageElementsXpath = "//XCUIElementTypeStaticText[@label='@varData'] | //XCUIElementTypeButton[@label='@varData']"
    def SettingsPagePO.ReplaceString(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
    end
end 
