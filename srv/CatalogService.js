module.exports = cds.service.impl(async function(){
    const {
        EmployeeSet
    }=this.entities;  //this represents current service object i.e.CatalogService.cds

this.before('UPDATE',EmployeeSet,(req,res) => {
    if(parseFloat(req.data.salaryAmount) > 1000000){
        req.error(500,"Salary should not be greater than one million");
    }
});

}); 



