@isTest
public with sharing class UpdateAccountCATest {
    
    @TestSetup
    static void makeData(){
        Account acc = TestDataFactory.createAccount();
        TestDataFactory.createOrder(acc.Id);
    }
    
    @IsTest
    static void testUpdateAccount(){
        // List<Order> orders = [SELECT Id, Status, TotalAmount FROM Order];

        /*if (orders.size() > 0) {
            orders[0].Status = 'Activated';
            update orders[0];
        }*/
        
        List<Order> ordersToUpdate =  new List<Order>();
        //List<Order> ordersToUpdate =  [SELECT Id, Status, TotalAmount FROM Order];
        for (Order od : [SELECT Id, Status, TotalAmount FROM Order]) {
            od.Status = 'Activated';
            ordersToUpdate.add(od);
        }

        update ordersToUpdate;

        
    }
}