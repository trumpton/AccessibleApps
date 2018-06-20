
function Component()
{
    // default constructor
}

Component.prototype.createOperations = function()
{
    component.createOperations();
    if (systemInfo.productType === "windows") {
        component.addOperation("CreateShortcut", 
		"@TargetDir@/bin/ContactManager.exe", 
		"@StartMenuDir@/ContactManager.lnk",
            	"workingDirectory=@TargetDir@", 
		"iconPath=@TargetDir@/bin/ContactManager.exe",
            	"iconId=1", "description=Contact Manager");
    }
}
