function Component()
{
    // default constructor
}

Component.prototype.createOperations = function()
{
    component.createOperations();
    if (systemInfo.productType === "windows") {
        component.addOperation("CreateShortcut", 
		"@TargetDir@/bin/ParseWeb.exe", 
		"@StartMenuDir@/ParseWeb.lnk",
            	"workingDirectory=@TargetDir@", 
		"iconPath=@TargetDir@/bin/ParseWeb.exe",
            	"iconId=1", "description=Parse Web");
    }
}
