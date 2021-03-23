pragma solidity >=0.4.22 <0.8.2;

contract Owned {
    
    address private owner;
    
    constructor() public
    {
        owner = msg.sender;
    }
    
    modifier OnlyOwner
    {
        require
        (
            msg.sender == owner,
            'You must be the owner!'
        );
        _;
    }
    
    function ChangeOwner(address newOwner) public OnlyOwner 
    {
        owner = newOwner;
    }
    
    function GetOwner() public returns (address)
    {
        return owner;
    }
    
}

contract Test is Owned
{
    enum RequestType {NewHome, EditHome}
    
    struct Ownership
    {
        string homeAddress;
        address owner;
        uint p;
    }
    
    struct Owner
    {
        string name;
        uint passSer;
        uint passNum;
        string date;
        string phoneNumber;
    }
    
    struct Home
    {
        string homeAddress;
        uint area;
        uint cost;
    }
    
    struct Request
    {
        RequestType requestType;
        Home home;
        uint result;
    }
    
    struct Employee
    {
        string name;
        string position;
        string phoneNumber;
        bool isset;
    }
    
    mapping(string => Employee) private employees;
    mapping(address => Owner) private owners;
    mapping(address => Request) private requests;
    mapping(unit => address) private reqCase;
    mapping(string => Home) private homes;
    mapping(string => Ownership[]) private ownerships;
    unit countId = 0;
    
    // ДОМ
    function AddHome(string memory _adr, uint _area, uint _cost) public
    {
        Home memory h;
        h.homeAddress = _adr;
        h.area = _area;
        h.cost = _cost;
        homes[_adr] = h;
    }
    
    function GetHome(string memory adr) public returns(uint _area, uint _cost)
    {
        return (homes[adr].area, homes[adr].cost);
    }
    
    function EditHome(string memory _adr, uint _area, uint _cost) public
    {
        homes[_adr].area = _area;
        homes[_adr].cost = _cost;
    }
    
    // РАБОТНИК
    function AddEmployee(address _adr, string memory _name, string memory _position, string memory _phoneNumber) public OnlyOwner
    {
        Employee memory e;
        e.name = _name;
        e.position = _position;
        e.phoneNumber = _phoneNumber;
        e.isset = true;
        employees[_id] = e;
    }
    
    function GetEmployee(address adr) public OnlyOwner returns(string memory _name, string memory _position, string memory _phoneNumber)
    {
        return (employees[adr].name, employees[adr].position, employees[adr].phoneNumber);
    }
    
    function EditEmployee(address _adr, string memory _name, string memory _position, string memory _phoneNumber) public Only Owner
    {
        employees[_adr].name = _name;
        employees[_adr].position = _position;
        employees[_adr].phoneNumber = _phoneNumber;
    }
    
    function DeleteEmployee(address _adr) public OnlyOwner
    {
        delete employees[_adr];
    }

    // ЗАПРОС
    function AddRequestHome(address empl, string memory _homeAddress, uint _area, uint _cost) public 
    {
        Request memory r;
        Home memory h;
        h.homeAddress = _homeAddress;
        h.area = _area;
        h.cost = _cost;
        r.requestType = RequestType.NewHome;
        r.home = h;
        r.result = 1;
        requests[empl] = r;
        reqCase[countID] = empl;
        countID++;
    }
    
    function GetRequests() public returns (string[] memory reqType, string[] memory Address, uint256[] memory Area, uint256[] memory Cost)
    {
        string[] memory reqType = new string[](countID);
        string[] memory Address = new string[](countID);
        uint[] memory Cost = new uint[](countID);
        uint[] memory Area = new uint[](countID);
        for (uint i = 0; i < countID; i++) 
        {
            reqType[i] = requests[reqCase[i]].requestType == RequestType.NewHome ? "NewHome" : "EditHome";
            Address[i] = requests[reqCase[i]].home.homeAddress;
            Cost[i] = requests[reqCase[i]].home.cost;
            Area[i] = requests[reqCase[i]].home.area;
        }
        return (reqType, Address, Cost, Area);
    }
}