pragma solidity ^0.4.17;
 
 contract Item
 {
     string public name;
     uint public mfd;
     uint public exp;
     uint public pid;
     uint public offset=1000;
     
     function Item( string _name, uint _mfd, uint _exp ) public{
         name=_name;
         mfd=_mfd;
         exp=_exp;
         pid=offset+10;
         offset=offset+10;
         }
     
 }