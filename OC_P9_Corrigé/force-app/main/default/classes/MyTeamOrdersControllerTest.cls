@IsTest
public with sharing class MyTeamOrdersControllerTest 
{

    @TestSetup
    static void makeData()
    {
        Integer nbAccount = 3;
        Integer nbOrder = 102;
        Integer unitPrice = 10;
        Integer quantity = 5;
        List <Account> accountTest = TestDataFactory.createAccounts(nbAccount);
        List <Order> orderTest= TestDataFactory.createOrdersForAccounts( accountTest,nbOrder,unitPrice,quantity);
       
    }
    
    @isTest
    static void testSumOders()
    {
        
        /**List<Order> ordersToUpdate =  new List<Order>();
        List<Order> ordersToUpdate =  [SELECT Id, Status, TotalAmount FROM Order];
        
        Test.startTest();
        update ordersToUpdate;
        Test.stopTest();
        Decimal sumOrders = ordersToUpdate.sumOrders;
        Decimal expectedResult = (10*5*102*3);
        System.assertEquals(expectedResult, sumOrders);*/
        List <Order> lsOrdersUpdate = new List <Order>();

        List<Order> ordersToUpdate =  [SELECT Id, Status, TotalAmount FROM Order];
        //System.assertNotEquals(null, ordersToUpdate[0].TotalAmount);


        
        Test.startTest();
        for (Order od :ordersToUpdate) 
        {
            od.Status = 'Activated';
            lsOrdersUpdate.add(od);
        }

        update lsOrdersUpdate;
        Test.stopTest();
        // List<Order> orderActivated =  [SELECT Id, Status, TotalAmount FROM Order WHERE Status = 'Activated'];
        // System.assertNotEquals(null, orderActivated[0].TotalAmount);
        // Decimal sumTotalAmount = 0;
        // for (Order odr  : orderActivated) 
        // {
        //     if(odr.TotalAmount!= null)
        //     {
        //         sumTotalAmount += odr.TotalAmount;

        //     }

            
            
        // }

        MyTeamOrdersController controller = new MyTeamOrdersController();
        Decimal sumOrders = controller.SumOders;

        Decimal expectedResult = (10*5*102*3*2);
        System.assertEquals(expectedResult, sumOrders);

    }

}