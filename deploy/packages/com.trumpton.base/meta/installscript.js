
function Component()
{
    // default constructor
}

Component.prototype.createOperations = function()
{
    component.createOperations();
    if (systemInfo.productType === "windows") {
        component.addOperation("CreateShortcut", 
		"@TargetDir@/maintenancetool.exe", 
		"@StartMenuDir@/TrumptonAppsMaintenanceTool.lnk",
            	"workingDirectory=@TargetDir@", 
		"iconPath=@TargetDir@/maintenancetool.exe",
            	"iconId=1", "description=Uninstall / Modify Trumpton Apps");
    }
}
