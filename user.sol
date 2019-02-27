pragma solidity ^0.4.17;

 contract user{
  struct use{

     string  name;
     bool  is_manufacturer;
     uint   ph_no;
     string  mail;
     address[] owns;
  }
  mapping (address=>use) public owners;
  address [] public ownership;

 function getdetails(address _address) public view returns(string,bool,uint,string){
  return(owners[_address].name,owners[_address].is_manufacturer,owners[_address].ph_no,owners[_address].mail);
 }

 function createUser(address _address ,string _name,bool _man, uint _pno,string _mail) public{
    require(owners[_address].ph_no==0);
     var p=owners[_address];
     p.name=_name;
     p.is_manufacturer=_man;
     p.ph_no=_pno;
     p.mail=_mail;
     ownership.push(_address);

 }
 function verify(address _address) public view{
  require(owners[_address].ph_no!=0);

 }
 function checkman(address _address) public view returns(bool){
     verify(_address);
     return owners[_address].is_manufacturer;
 }

 function get(address _address,address _padd) private view returns(uint){
     uint i;
     for(i=0;i<owners[_address].owns.length;i++){
         if(owners[_address].owns[i]==_padd){
             return i;
         }
     }
     return i;
 }

 function transact(address rec,address _padd) public {
     verify(msg.sender);
     verify(rec);
     uint i=get(msg.sender,_padd);
     require(i!=owners[msg.sender].owns.length);
     delete owners[msg.sender].owns[i];
     owners[rec].owns.push(_padd);
 }
 function createasset(address _address) public {
     require(owners[msg.sender].is_manufacturer);
     owners[msg.sender].owns.push(_address);
 }
 function getowns() public view returns(address[]){
     return owners[msg.sender].owns;
 }
}
