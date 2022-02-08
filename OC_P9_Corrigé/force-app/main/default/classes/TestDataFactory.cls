public with sharing class TestDataFactory {

    public static Account createAccount (){
        Account acc1 = new Account(Name = 'Test Account 1', Chiffre_d_affaire__c=0);
        insert acc1;

        return acc1;
    }

    public static Order createOrder(Id AccountId){
        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert pd1;
 
        //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;

        Order o1 = new Order(AccountId = AccountId, Status='Draft',
            ShipmentCost__c = 0,NetAmount__c = 0,  Pricebook2Id = Test.getStandardPricebookId(),
            EffectiveDate=Date.today());
        insert o1;

        OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert oi1;
        OrderItem oi2 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
        insert oi2;  

        return o1;
    }
}
