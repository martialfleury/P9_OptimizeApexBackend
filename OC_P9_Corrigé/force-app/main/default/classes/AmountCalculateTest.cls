@isTest 
public with sharing class AmountCalculateTest
  {
   
    @TestSetup
    static void makeData()
    {
        Integer nbAccount = 3;
        Integer nbOrder = 202;
        Integer unitPrice = 10;
        Integer quantity = 5;

        List <Account> accountTest = TestDataFactory.createAccounts(nbAccount);
        List <Order> orderTest= TestDataFactory.createOrdersForAccounts( accountTest,nbOrder,unitPrice,quantity);

    }
    
    @IsTest
    static void CalculMontantTriggerTest()
    {
        List<Order> ordersToUpdate =  new List<Order>();
        //List<Order> ordersToUpdate =  [SELECT Id, Status, TotalAmount FROM Order];
        for (Order od : [SELECT Id, Status, NetAmount__c, TotalAmount FROM Order])
        {
            od.Status = 'Activated';
            od.ShipmentCost__c = 25;
            ordersToUpdate.add(od);
        }
        Test.startTest();
        update ordersToUpdate;
        Test.stopTest();
        Order orderToCheck = [SELECT Id, Status, NetAmount__c, TotalAmount FROM Order LIMIT 1];
        Decimal netAmount = orderToCheck.NetAmount__c;
        System.debug(netAmount);
        System.debug(orderToCheck.TotalAmount);
        Integer expectedAmount = (10*5*2)-25;

        System.assertEquals(expectedAmount, netAmount);
        System.assertNotEquals(null, orderToCheck.TotalAmount );
    }
}