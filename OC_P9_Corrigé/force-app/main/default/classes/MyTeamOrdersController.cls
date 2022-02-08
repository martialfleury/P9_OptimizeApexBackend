public with sharing class MyTeamOrdersController {
    public decimal SumOders{
        get{
            AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order WHERE status='Activited'];
            return (decimal)groupedResults.get('total');
        }
        set;
    }
}