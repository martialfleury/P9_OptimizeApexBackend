global class UpdateAccounts implements Database.Batchable<sObject>
{
    
    global Database.QueryLocator start(Database.BatchableContext info)
    { 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Activated'
        /**  return Database.getQueryLocator('SELECT Id, Chiffre_d_affaire__c, (SELECT TotalAmount FROM Orders WHERE Status=\'Activated\')
         FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status=\'Activated\')');*/
        return Database.getQueryLocator('SELECT Id , (SELECT TotalAmount FROM Orders WHERE Status =\'Activated\') FROM Account WHERE Id IN (SELECT AccountId FROM Order )');
    
    }
        
    // global void execute(Database.BatchableContext info, List<Account> accounts){  
    global void execute(Database.BatchableContext info, List<Account> accountsWithOrders)
    {  
         AccountService.calculateCA(accountsWithOrders);
       
    }    
        
    global void finish(Database.BatchableContext info)
    {     
        
    } 
}