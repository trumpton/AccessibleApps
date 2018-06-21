
function Component()
{
}

Component.prototype.createOperations = function()
{
    component.createOperations();
    component.addOperation("Mkdir", "@HomeDir@/TrumptonApps") ;
    component.addOperation("CopyDirectory", "@TargetDir@/ExampleConfiguration/", "@HomeDir@/TrumptonApps/") ;
}

