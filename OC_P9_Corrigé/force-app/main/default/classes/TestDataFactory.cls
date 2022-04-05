public with sharing class TestDataFactory 
{

    //// generate a list of accounts
    public static List<Account> createAccounts(Integer nbAccount) 
    {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < nbAccount; i++) {
            Account account = new Account(Name='name_' + i);
            accounts.add(account);
        }
        insert accounts;
        return accounts;
    }

    // generate a order for a given list of accounts
    public static List<Order> createOrdersForAccounts(List<Account> accounts, Integer nbOrder, Integer unitPrice, Integer quantity)
    {
         // create Contracts and Orders
         List<Contract> contracts = new List<Contract>();
         List<Order> orders = new List<Order>();
         for (Account account : accounts) 
         {
             Contract contract = new Contract(
                 AccountId=account.id, 
                 Status='Draft',
                 ContractTerm=5
             );
             contracts.add(contract);
 
             for (Integer k = 0; k < nbOrder; k++) {
                Order order = new Order(
                    AccountId=account.id,
                    ContractId=contract.id,
                    Status='Draft',
                    EffectiveDate=Date.today(),
                    Pricebook2Id=Test.getStandardPricebookId()
                    );
                orders.add(order);
            }
         }
         insert contracts;
         insert orders;

          // create Product2, PricebookEntry, OrderItems and activate Orders
        Product2 product = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        insert product;
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = product.Id,
            UnitPrice = unitPrice,
            IsActive = true
        );
        insert pbe;

        List<OrderItem> items = new List<OrderItem>();
        
        
        for (Order order : orders) 
        {
            OrderItem  item1 = new OrderItem 
            (
                OrderId = order.Id,
                PricebookEntryId = pbe.Id,
                Quantity = quantity,
                UnitPrice = unitPrice,
                product2Id = product.Id

            );

             OrderItem item2 = new OrderItem 
             (
                    OrderId = order.Id,
                    PricebookEntryId = pbe.Id,
                    Quantity = quantity,
                    UnitPrice = unitPrice,
                    product2Id = product.Id
            );
            items.add(item1);
           
            items.add(item2);
        }
            insert items;

        
        /**for (Order order : orders) 
        {
          
        }
          insert items;*/

          return orders;

    }
     

      
    
       

        
        /** Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
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

         
       
    } */
}
