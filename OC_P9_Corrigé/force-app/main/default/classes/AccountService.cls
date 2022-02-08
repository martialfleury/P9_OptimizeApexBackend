public with sharing class AccountService {
    public static void calculateCA(List<Account> accountsWithOrders) {
        for(Account myAccount : accountsWithOrders){
            myAccount.Chiffre_d_affaire__c = 0;
            for(Order order : myAccount.Orders){
                myAccount.Chiffre_d_affaire__c += order.TotalAmount;
            }
        }
        update accountsWithOrders;
    }
}
