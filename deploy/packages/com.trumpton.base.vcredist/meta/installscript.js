
function Component()
{
    // default constructor
}

Component.prototype.createOperations = function()
{
    component.createOperations();
    if (systemInfo.productType === "windows") {
		component.addOperation("Execute",
		"@TargetDir@/redist/vcredist_x64.exe") ;
    }
}
