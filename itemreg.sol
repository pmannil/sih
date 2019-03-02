pragma solidity ^0.4.17;

contract items{
    uint public itemCount;
    address[] public tr;

    function items() public{
        itemCount=1000;
    }

    struct asset{
        string name;
        uint32 weight;
        uint32 date;
        uint32 expd;
        address parid;
        address[] state;
        bool dis;
        bool ispacket;
        bool is_batched;
        }

        mapping (address => asset) public assetlist;
        address[]  public assetarray;

        function createAsset(bool _ispacket,string _name,uint32 _weight,uint32 _date,uint32 _expd) public returns (address){
           address _address=address(itemCount);
           require(assetlist[_address].date==0);
          var a=assetlist[_address];
          itemCount+=10;
          a.ispacket=_ispacket;
          if(_ispacket){

            a.name=_name;
            a.weight=_weight;
            a.date=_date;
            a.expd=_expd;
            //a.parid=0;
            a.dis=false;
           // a.state.push(msg.sender);
            itemCount=itemCount+1;
           assetarray.push(_address);
          }
          else{
            //var a=assetlist[_address];
            //a.name=_name;
            //a.weight=_weight;
            a.date=_date;
            a.expd=_expd;
            a.parid=0;
            a.dis=false;
          }         //assetlist[_address]=c;
          a.is_batched=false;
            return _address;
        }
       //for current   addresss
       function assign_parid(address curaddress,address paradd) public {
           if(assetlist[curaddress].parid==address(0)){
             assetlist[curaddress].is_batched=true;
           assetlist[curaddress].parid=paradd;
           }
       }
       //buyerid,product id
    function statepush(address _newid,address _id) private{
        verify(_id);
         assetlist[_id].state.push(_newid);
     }
     //for disintegrated parent
    function discard(address _id) private{
        verify(_id);
         assetlist[_id].dis=true;
     }
     //for disintegrated parent
    function checkDiscard(address _id) private view returns(bool){
        verify(_id);
         return (assetlist[_id].dis);
    }


    // for disintegated parent
     function getCurid(address _id) public  returns(address){
        if(!checkDiscard(_id))
         {
             assetlist[_id].dis=true;
         }
        return assetlist[_id].state[assetlist[_id].state.length-1];
     }
     //for current asset
     function checkOwnership(address _id) public returns(address){
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
                require(assetlist[i].state.length>=1||assetlist[i].parid!=0);
                return true;
            }

            function transact(address receiver,address id,uint _date) public returns(string){
                verify(id);
                require(_date<assetlist[id].expd);
                address curr_own=checkOwnership(id);
                if(curr_own!=msg.sender){
                    if(assetlist[id].state.length==0){
                       return "Security Alert!";//Error if not the owner
                    }
                else{
                    return "Not the owner";
                    }
                }
               //transact only if the parent is discarded and the current is not
               if((assetlist[id].parid==0||assetlist[assetlist[id].parid].dis)&&!assetlist[id].dis)
               {
                 assetlist[id].state.push(receiver);
                 return "Successfully transacted";
               }
               else
               return "Parent already disintegrated";

                //return "Alert!";
            }
            function track(address _address) public  returns (address[]){
                delete tr;
                uint i;
               while(assetlist[_address].parid!=address(0))
               {
                   i=assetlist[_address].state.length;
                 for(i=i;i>0;i--)
                 {
                     tr.push(assetlist[_address].state[i-1]);

                 }

                 _address=assetlist[_address].parid;
               }
                i=assetlist[_address].state.length;
                 for(i=i;i>0;i--)
                 {
                     tr.push(assetlist[_address].state[i-1]);

                 }
               return tr;

            }
            function getState(address _address) public view returns(address[]){
                return assetlist[_address].state;
            }
            function getDetails(address _address) public view returns(string,uint32, uint32,uint32,bool ,bool ){
              verify(_address);
              var a= assetlist[_address];
              return (a.name,a.weight,a.date,a.expd,a.ispacket,a.is_batched);
            }
            function finalize(address _address) public {
              assetlist[_address].state.push(msg.sender);
            }
    }
