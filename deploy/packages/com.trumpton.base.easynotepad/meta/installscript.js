function Component()
{
    // default constructor
}

Component.prototype.createOperations = function()
{
    component.createOperations();
    if (systemInfo.productType === "windows") {
        component.addOperation("CreateShortcut", 
		"@TargetDir@/bin/EasyNotepad.exe", 
		"@StartMenuDir@/EasyNotepad.lnk",
            	"workingDirectory=@TargetDir@", 
		"iconPath=@TargetDir@/bin/EasyNotepad.exe",
            	"iconId=1", "description=Easy Notepad");
    }
}

