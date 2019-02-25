pragma solidity ^0.4.17;

contract Itemregister{
    uint public id;
    uint public par_id;
    uint[] public state;
    
    
    function Itemregister(uint _id)  public
    {
       
        id=_id;
     }
     function setparent(uint _parid) public{
         par_id=_parid;
         
     }
     function statepush(uint newid) public{
         state.push(newid);
     }
     function discard() public{
         state.push(0);
     }
     function checkDiscard() view returns(bool){
         if(state[state.length-1]==0)
         {
             return true;
         }
         else {
             return false;
         }
         
     }
     function getCurid() view returns(uint){
         if(state[state.length-1]==0)
         {
             return state[state.length-2];
             
     }
     else{
         return state[state.length-1];
     }
     
}