@isTest
public with sharing class AccountServiceTest 
{
    @isTest
    Static void  AccountServiceTest() 
    {
        
        Integer nbAccount = 3;
        Integer nbOrder = 102;
        Integer unitPrice = 10;
        Integer quantity = 5;
        List <Account> accountTest = TestDataFactory.createAccounts(nbAccount);
        List <Order> orderTest= TestDataFactory.createOrdersForAccounts(accountTest,nbOrder,unitPrice,quantity);
        for (Account account : accountTest)
        {
            Account.Chiffre_d_affaire__c = 5*10*2;
        }
      
        Test.startTest();
        List <Database.SaveResult> results = Database.update(accountTest , false);
        Test.stopTest();
                        for (Database.SaveResult result : results)
                        {
                            System.assertEquals(True , result.isSuccess());
                            System.assertEquals(0, result.getErrors().size());
                        }
                        accountTest = [SELECT Chiffre_d_affaire__c FROM Account];
                        Decimal expectedCA = 5*10*2;
                        for (Account account : accountTest) 
                        { 
                            System.assertEquals(expectedCA,  Account.Chiffre_d_affaire__c);
                            
                        }

    }
}
