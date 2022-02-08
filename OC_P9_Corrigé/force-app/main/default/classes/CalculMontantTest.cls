@isTest 
public with sharing class CalculMontantTest {

    @TestSetup
    static void makeData(){
        Account acc = TestDataFactory.createAccount();
        TestDataFactory.createOrder(acc.Id);
    }
    
    @IsTest
    static void CalculMontantTriggerTest(){
        List<Order> ordersToUpdate =  new List<Order>();
        //List<Order> ordersToUpdate =  [SELECT Id, Status, TotalAmount FROM Order];
        for (Order od : [SELECT Id, Status, TotalAmount FROM Order]) {
            od.Status = 'Activated';
            ordersToUpdate.add(od);
        }

        update ordersToUpdate;

    }
}
