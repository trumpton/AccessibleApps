
function Component()
{
    // default constructor
}

Component.prototype.createOperations = function()
{
    component.createOperations();
    if (systemInfo.productType === "windows") {
        component.addOperation("CreateShortcut", 
		"@TargetDir@/bin/EncPad.exe", 
		"@StartMenuDir@/EncPad.lnk",
            	"workingDirectory=@TargetDir@", 
		"iconPath=@TargetDir@/bin/EncPad.exe",
            	"iconId=1", "description=Encrypt Pad");
    }
}
