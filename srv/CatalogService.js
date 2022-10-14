module.exports = cds.service.impl(async function(){
    const {
        EmployeeSet , POs
    }=this.entities;  //this represents current service object i.e.CatalogService.cds

this.before('UPDATE',EmployeeSet,(req,res) => {
    if(parseFloat(req.data.salaryAmount) > 1000000){
        req.error(500,"Salary should not be greater than one million");
    }
});

//Action
this.on('boost',async req => {
 try {
     const ID = req.params[0];
     const tx = cds.tx(req);
     await tx.update(POs).with({
         GROSS_AMOUNT : { '+=' : 20000 },
         NOTE : 'Boosted!!'
     }).where(ID);
     return "Boost was Successfull";
 } catch (error) {
     return "Error " + error.toString();
 }
});

//Function
this.on('largestOrder',async req => {
    try {
        const ID = req.params[0];
        const tx = cds.tx(req);
        const reply = await tx.read(POs).orderBy({
            GROSS_AMOUNT : 'desc'
        }).limit(1);
        return reply;
    } catch (error) {
        return "Error " + error.toString();
    }
   });

}); 



