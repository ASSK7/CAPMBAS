using { afreed.db.CdsViews } from '../db/CdsView';
using { afreed.db.master , afreed.db.transaction } from '../db/datamodel';



service cdsService {

    entity POWorklist as projection on CdsViews.POWorklist;
    entity ProductOrders as projection on CdsViews.ProductViewSub;
    entity ProductAggregation as projection on CdsViews.CProductValuesView;
 
 }