pragma solidity >=0.4.22 <0.8.2;
pragma experimental ABIEncoderV2;

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
    
    unit private cost = 1e12;
    
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
        unit area;
        unit cost;
        address adr;
        bool isProcessed;
    }
    
    struct Employee
    {
        string name;
        string position;
        string phoneNumber;
        bool isset;
    }
    
    mapping(address => Employee) private employees;
    mapping(address => Owner) private owners;
    mapping(address => Request) private requests;
    address[] requestInitiator;
    mapping(string => Home) private homes;
    mapping(string => Ownership[]) private ownerships;
    
    unit private countId = 0;
    
     modifier OnlyEmployee {
        require(
            employees[msg.sender].isset != false,
            'Only Employee can run this function!'
            );
        _;
    }
    
    modifier Costs(uint value){
        require(
            msg.value >= value,
            'Not enough funds!!'
            );
        _;
    }
    
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
        if (employees[empl].isset == true){
            delete employees[empl];
            return true;
        }
        return false;
    }

    // ЗАПРОС
    function AddRequestHome(address empl, string memory _homeAddress, uint _area, uint _cost) public 
    {
        Request memory r;
        r.requestType = rType == 0? RequestType.NewHome: RequestType.EditHome;
        r.homeAddress = adr;
        r.area = area;
        r.cost = cost;
        r.result = 0;
        r.adr = rType==0?address(0):newOwner;
        r.isProcessed = false;
        requests[msg.sender] = r;
        requestInitiator.push(msg.sender);
        countID += msg.value;
        return true;
    }
    
    function GetRequest() public OnlyEmployee returns (uint[] memory, uint[] memory, string[] memory)
    {
        uint[] memory ids = new uint[](requestInitiator.length);
        uint[] memory types = new uint[](requestInitiator.length);
        string[] memory homeAddresses = new string[](requestInitiator.length);
        for(uint i=0;i!=requestInitiator.length;i++){
            ids[i] = i;
            types[i] = requests[requestInitiator[i]].requestType == RequestType.NewHome ? 0: 1;
            homeAddresses[i] = requests[requestInitiator[i]].homeAddress;
        }
        return (ids, types, homeAddresses);
    }
    
    function EditCost(uint _cost) public
    {
        cost = _cost;
    }
}
