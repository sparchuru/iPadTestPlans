module GeneralPagePO

Xpath_btnInBluClr = "//XCUIElementTypeButton[@label='@varData' and @value = '1']"

 def GeneralPagePO.Replace(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
 end
end
