function Component()
{
    // default constructor
}

Component.prototype.createOperations = function()
{
    component.createOperations();
    if (systemInfo.productType === "windows") {
        component.addOperation("CreateShortcut", 
		"@TargetDir@/bin/EncryptFolder.exe", 
		"@StartMenuDir@/EncryptFolder.lnk",
            	"workingDirectory=@TargetDir@", 
		"iconPath=@TargetDir@/bin/EncryptFolder.exe",
            	"iconId=1", "description=Encrypt / Decrypt Folder");
    }
}

