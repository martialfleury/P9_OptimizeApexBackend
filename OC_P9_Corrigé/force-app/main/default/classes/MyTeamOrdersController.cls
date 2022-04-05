public with sharing class MyTeamOrdersController 
{
    public decimal SumOders
    {
        get{
            // AggregateResult groupedResults = [SELECT SUM(TotalAmount)total FROM Order WHERE status='Activited'];
            // return (decimal)groupedResults.get('total');
            //List<Order> orderActivated =;

            Decimal sumTotalAmount = 0;
            for (Order odr  : [SELECT Id, Status, TotalAmount FROM Order WHERE Status = 'Activated']) 
            {
                if(odr.TotalAmount!= null)
                {
                    sumTotalAmount += odr.TotalAmount;

                }
            }
            return  sumTotalAmount;

        }
        set;
    }
}