global class UpdateAccounts implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        // return Database.getQueryLocator('SELECT Id, Chiffre_d_affaire__c, (SELECT TotalAmount FROM Orders WHERE Status=\'Activated\') FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status=\'Activated\')');
        return Database.getQueryLocator('SELECT Id , AccountId, Account.Chiffre_d_affaire__c, TotalAmount FROM Order WHERE Status=\'Activated\' AND AccountId != null');
    
    }
        
    // global void execute(Database.BatchableContext info, List<Account> accounts){  
    global void execute(Database.BatchableContext info, List<Order> orders){  

        
        // AccountService.calculateCA(accounts);
        List<Account> accounts = new List<Account>();
        for (Order od : orders) {
            accounts.add(
                new Account(Id = od.AccountId, Chiffre_d_affaire__c = od.Account.Chiffre_d_affaire__c)
            );
        }
        AccountService.calculateCA(accounts);
    }    
        
    global void finish(Database.BatchableContext info){     
        
    } 
}