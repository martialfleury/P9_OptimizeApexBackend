trigger UpdateAccountCA on Order (after update)
{

  // récupération de la liste des comptes pour les commandes actives
  set<Id> accountIds = new set<Id>();
  for(Order order : trigger.new)
  {
    if(order.Status == 'Activated')
    {
      accountIds.add(order.AccountId);
    }
  }
  // mise à jour du CA
  if(accountIds.size() > 0)
  {
    // List<Account> accountsWithOrders = [SELECT Id, Chiffre_d_affaire__c, (SELECT TotalAmount FROM Orders WHERE Status='Activated')
    List<Account> accountsWithOrders = [SELECT Id, (SELECT TotalAmount FROM Orders WHERE Status='Activated')
                                          FROM Account
                                          WHERE Id IN :accountIds
                                        ];
    AccountService.calculateCA(accountsWithOrders);
    update accountsWithOrders;
  }

}