
function Component()
{
}

Component.prototype.createOperations = function()
{
    component.createOperations();
    if (systemInfo.productType === "windows") {
        component.addOperation("Execute", 
            "@TargetDir@/bin/CopyFiles.exe", 
            "@TargetDir@/ExampleConfiguration", 
            "@HomeDir@/TrumptonApps") ;
    }
}

