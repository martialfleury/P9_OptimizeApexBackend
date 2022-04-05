@isTest
public with sharing class UpdateAccountCATest 
{
    @IsTest
    static void testUpdateAccountWithOrders()
    {
        set<Id> accountIds = new set<Id>();
        Integer nbAccount = 3;
        Integer nbOrder = 202;
        Integer unitPrice = 10;
        Integer quantity = 5;
        List <Account> accountTest =TestDataFactory.createAccounts(nbAccount);
        List <Order> orderTest = TestDataFactory.createOrdersForAccounts(accountTest,nbOrder,unitPrice,quantity);
        for ( Order order : orderTest)
        {
            order.Status = 'Activated';

        }
        
         Test.startTest();
         update orderTest;
         Test.stopTest();

         accountTest = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Activated')];
         System.assertEquals(nbAccount,accountTest.size());
         Decimal expectedCA = 202*10*5*2;
         for(Account account : accountTest)
         {
             System.assertEquals(expectedCA, account.Chiffre_d_affaire__c);
         }

        // List<Order> orders = [SELECT Id, Status, TotalAmount FROM Order];

        // if (orders.size() > 0) {
        //     orders[0].Status = 'Activated';
        //     update orders[0];
        // }
        
        // //List<Order> ordersToUpdate =  new List<Order>();
        // //List<Order> ordersToUpdate =  [SELECT Id, Status, TotalAmount FROM Order];
        // for (Order od : [SELECT Id, Status, TotalAmount FROM Order]) {
        //     od.Status = 'Activated';
        //     ordersToUpdate.add(od);
        // }

        // update ordersToUpdate;*/
        // List<Order>testUpdateOrders =  new List<Order>();
        // /**List <Order> testUpdateOrders = [SELECT Id, Chiffre_d_affaire__c, (SELECT TotalAmount FROM Orders WHERE Status='Activated')
        //                                                 FROM Account
        //                                                 WHERE Id IN :accountIds];*/

        // for (Order lsOd : [SELECT Id, Chiffre_d_affaire__c, (SELECT TotalAmount FROM Orders WHERE Status='Activated')
        //                   FROM Account
        //                   WHERE Id IN :accountIds])
        // {
        //     lsOd.Status =  'Activated';
        //     testUpdateOrders.add(lsOd);
        // }

        //  Test.startTest();
        //  update testUpdateOrders;
        //  Test.stopTest();
    
        //  UpdateAccounts account = new UpdateAccounts();

        //  Decimal realCA = account.realCA;
         
        //  Decimal expectedCA = (5*10)*2;
         
        //  System.assertEquals(expectedCA, realCA);
    }
}