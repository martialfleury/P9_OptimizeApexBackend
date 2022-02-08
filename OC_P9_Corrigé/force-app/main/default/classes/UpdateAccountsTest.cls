@isTest
public with sharing class UpdateAccountsTest {

    @TestSetup
    static void makeData(){
        Account acc = TestDataFactory.createAccount();
        TestDataFactory.createOrder(acc.Id);
    }
    
    @IsTest
    static void UpdateAccountsBatch(){
        List<Order> ordersToUpdate =  new List<Order>();
        //List<Order> ordersToUpdate =  [SELECT Id, Status, TotalAmount FROM Order];
        for (Order od : [SELECT Id, Status, TotalAmount FROM Order]) {
            od.Status = 'Activated';
            ordersToUpdate.add(od);
        }

        update ordersToUpdate;

        Test.startTest();
        UpdateAccounts batch = new UpdateAccounts();
        Database.executeBatch(batch);
        Test.stopTest();
        

        
    }
}
