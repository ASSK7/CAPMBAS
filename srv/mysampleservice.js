const mysrvdemo = function(srv){
     srv.on("myFunction",(req,res) => {
         return "Hello " + req.data.msg;
     });
}

module.exports = mysrvdemo; 