//Add 'PRC' brefore inserting a product record
trigger ProductCodeUpdate on Product2 (before insert) {
   List<Product2> proList = trigger.new; //newer version of records
    for(Product2 pro : proList){
        if(pro.productCode != null && pro.productCode !=''){
            pro.productCode = 'PRC-' + pro.productCode;
        }
    }


}