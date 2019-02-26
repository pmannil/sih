pragma solidity ^0.4.17;

contract items{
    uint public itemCount;
    //uint public idcount;

    struct asset{
        string name;
        uint32 weight;
        uint32 date;
        uint32 expd;
       // uint16 id;
        address parid;
        address[] state;
        bool dis;
        }
        
        mapping (address => asset) public assetlist;
            
        
       // function getasset(uint pid) public view returns(asset){
        
         // return assetlist[pid];  
        //}
        
        function createAsset(bool ispacket,address _address,string _name,uint32 _weight,uint32 _date,uint32 _expd) public{
          
          var a=assetlist[_address];
          if(ispacket){
            
            a.name=_name;
            a.weight=_weight;
            a.date=_date;
            a.expd=_expd;
            //a.parid=0;
            a.dis=true;
            a.state.push(msg.sender);  
          }
          else{
            //var a=assetlist[_address];
            //a.name=_name;
            //a.weight=_weight;
            //a.date=_date;
            //a.expd=_expd;
           // a.parid=0;
            a.dis=false;
            a.state.push(msg.sender);
          }
            
        
            //assetlist[_address]=c;
             
            }
       //for current   addresss
       function assign_parid(address curaddress,address paradd) public {
           if(assetlist[curaddress].parid==address(0)){
           assetlist[curaddress].parid=paradd;
           }
       }
       //buyerid,product id
    function statepush(address _newid,address _id) public{
        verify(_id);
         assetlist[_id].state.push(_newid);
     }
     //for disintegrated parent
    function discard(address _id) public{
        verify(_id);
         assetlist[_id].dis=true;
     }
     //for disintegrated parent
    function checkDiscard(address _id) public view returns(bool){
        verify(_id);
         return (assetlist[_id].dis);
    }
         
    
    // for disintegated parent
     function getCurid(address _id) private  returns(address){
        if(!checkDiscard(_id))
         {
             assetlist[_id].dis=true;
         }
        return assetlist[_id].state[assetlist[_id].state.length-1];
     }
     //for current asset
     function checkownership(address _id) public returns(address){
         verify(_id);
         if(assetlist[_id].parid==address(0))
         {
            return assetlist[_id].state[assetlist[_id].state.length-1];
         }
         else
         {
            if(assetlist[_id].state.length==0){
             return getCurid(assetlist[_id].parid);
             }
            else{
             return assetlist[_id].state[assetlist[_id].state.length-1]; 
             }
         }
     }
           function verify(address i) public view returns(bool){
                require(assetlist[i].state.length==1||assetlist[i].parid!=0);
                return true;
            }
            
            function transact(address receiver,address id) public returns(string){
                verify(id);
                address curr_own=checkownership(id);
                if(curr_own!=msg.sender){
                    if(assetlist[id].state.length==0){
                       return "Security Alert!";//Error if not the owner
                    }
                else{
                    return "Not the owner";
                    }
                }
                assetlist[id].state.push(receiver);
                return "Successfully transacted";
            }
     }
        