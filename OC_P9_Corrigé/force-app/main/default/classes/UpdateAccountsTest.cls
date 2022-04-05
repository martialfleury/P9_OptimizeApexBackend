@isTest
public with sharing class UpdateAccountsTest 
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
        for (Order order : orderTest)
        {
            order.Status = 'Activated';
        }
        update orderTest;
    }
    
    @IsTest
    static void UpdateAccountsBatch()
    {
        //  List<Order> ordersToUpdate =  new List<Order>();
        // //List<Order> ordersToUpdate =  [SELECT Id, Status, TotalAmount FROM Order];
        // for (Order od : [SELECT Id, Status, TotalAmount FROM Order]) 
        // {
        //     od.Status = 'Activated';
        //     ordersToUpdate.add(od);
        // }

        // update ordersToUpdate;

        Test.startTest();
        UpdateAccounts batch = new UpdateAccounts();
        Id batchId = Database.executeBatch(batch);
        Test.stopTest();
        List <Account> results = [SELECT Id, 
        Chiffre_d_affaire__c  FROM Account WHERE Id IN 
                                    (SELECT AccountId FROM Order WHERE status = 'Activated')];
        //System.assert(ordersToUpdate.size()>0);
        System.assertEquals(3, results.size());
        for (Account account : results)
        {
            System.assertEquals(5*10*2*102, account.Chiffre_d_affaire__c);

        }

       }
}
