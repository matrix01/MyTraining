/*
		Group 3 	
	
	FARHAN AR RAFI
  	SYMUNUR RAHMAN
  	MD. REZWANUL ISLAM
  	MD MILAN MIA

*/

class Address{
    Customer customer;
}

class HomeAddress extends Address{
    String getAddress(){
        return customer.homeAddress;
    }
}

class WorkAddress extends Address{
    String getAddress(){
        return customer.workAddress;
    }
}

class OtherAddress extends Address{
    String getAddress(){
        return customer.workAddress;
    }
    
}

class Order{
    String orderId;
    Restaurant restaurantReceivingOrder;
    Customer customerPlacingOrder;
    Address addressType;
    String otherAddress;
    public string getDeliveryAddress(){
        customerPlacingOrder.otherAddress=otherAddress;
        customerPlacingOrder.getAddress(addressType)
    }
}

class Customer{
    String homeAddress;
    String workAddress;
    String otherAddress;
    String getAddress (Address addressType){
        return addressType.getAddress();
    }
}

