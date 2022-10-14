const cds = require('@sap/cds');
const { employees } = cds.entities("afreed.db.master");


const mysrvdemo = function(srv){   // this was created in DAY 1 of CAPM Class
     srv.on("myFunction",(req,res) => {
         return "Hello " + req.data.msg;
     });



//Generic Handlers
//READ
srv.on('READ','ReadEmployeeSrv', async(req,res) => {
    var results = [];

    //cds query language - SELECT * FROM
    // results = await cds.tx(req).run(SELECT.from(employees));
    // results = await cds.tx(req).run(SELECT.from(employees).limit(3)); //limiting top 3  records
    //tx means transaction which means select query

    //cds query to read single record with where condition
    // results = await cds.tx(req).run(SELECT.from(employees).where({"nameFirst" : "Susan"}));

    //cds query to record if user passes key like /Enitty/key
    var whereCondition = req.data;
    if(whereCondition.hasOwnProperty("ID")){ //if it is ID field
        results = await cds.tx(req).run(SELECT.from(employees).where(whereCondition));
    } 
    else{
        results = await cds.tx(req).run(SELECT.from(employees).limit(1));
    }


    return results;
});


//CREATE
srv.on('CREATE','InsertEmployeeSrv', async(req,res) => {
    //For DML(INSERT,UPDATE,DELETE) statement we use .transaction instead of tx
    let returnData = await cds.transaction(req).run([
        INSERT.into(employees).entries([req.data])
    ]).then( (resolve,reject) => {
        if(typeof(resolve) !== undefined){
            return  req.data;
        }
        else{
            req.error(500,"There was an issue in insert");
        }
    }).catch(err => {
       req.error(500, "There was error "+err.toString());
    });
    return returnData ;

});


//UPDATE
srv.on('UPDATE','UpdateEmployeeSrv',async(req,res) => {
    returnData = await cds.transaction(req).run([
        UPDATE(employees).set({
            nameFirst : req.data.nameFirst
        }).where({ID : req.data.ID}) ,

        UPDATE(employees).set({
            nameLast : req.data.nameLast
        }).where({ID : req.data.ID})

    ]).then( (resolve,reject) => {
        if(typeof(resolve) !== undefined){
            return  req.data;
        }
        else{
            req.error(500,"There was an issue in Update");
        }
    }).catch(err => {
       req.error(500, "There was error "+err.toString());
    });
    return returnData ;
});


//Delete
srv.on('DELETE','DeleteEmployeeSrv',async(req,res) => {
    returnData = await cds.transaction(req).run([
        DELETE.from(employees).where(req.data)
    ]).then( (resolve,reject) => {
        if(typeof(resolve) !== undefined){
            return  req.data;
        }
        else{
            req.error(500,"There was an issue in Update");
        }
    }).catch(err => {
       req.error(500, "There was error "+err.toString());
    });
    return returnData ;
});


}

module.exports = mysrvdemo; 