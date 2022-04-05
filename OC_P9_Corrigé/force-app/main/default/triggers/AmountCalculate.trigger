trigger AmountCalculate on Order (before update) 
{

	// Order newOrder= trigger.new[0];
	// newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;

	for (Order oneOrder : Trigger.new) 
	{
		if(oneOrder.TotalAmount != null && oneOrder.ShipmentCost__c != null)
		{
		
			oneOrder.NetAmount__c = oneOrder.TotalAmount - oneOrder.ShipmentCost__c;
		}
		
	}
	
}