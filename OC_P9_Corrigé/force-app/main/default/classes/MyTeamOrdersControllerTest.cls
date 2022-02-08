@IsTest
public with sharing class MyTeamOrdersControllerTest {

    @TestSetup
    static void makeData(){
        Account acc = TestDataFactory.createAccount();
        TestDataFactory.createOrder(acc.Id);

    }
    
    @isTest
    static void testSumOders(){
        
        List<Order> ordersToUpdate =  new List<Order>();
        //List<Order> ordersToUpdate =  [SELECT Id, Status, TotalAmount FROM Order];
        for (Order od : [SELECT Id, Status, TotalAmount FROM Order]) {
            od.Status = 'Activated';
            ordersToUpdate.add(od);
        }

        update ordersToUpdate;

        MyTeamOrdersController mt =  new MyTeamOrdersController();

        Decimal d = mt.SumOders;
        mt.SumOders = 0;

        // System.assertEquals(null, d);
    }
}