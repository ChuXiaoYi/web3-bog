// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Blog {
    string public name;
    address public owner;

    using Counters for Counters.Counter;
    Counters.Counter private _postIds;

    struct Post {
        uint id;
        string title;
        string content;
        bool published;
    }

    mapping(uint => Post) private idToPost;
    mapping(string => Post) private hashToPost;

    event PostCreated(uint id, string title, string hash);
    event PostUpdated(uint id, string title, string hash, bool published);

    constructor(string memory _name) {
        console.log("Deploying a Blog with name:", _name);
        name = _name;
        owner = msg.sender;
    }

    modifier OnlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function updateName(string memory _name) public {
        name = _name;
    }

    function transferOwnerShip(address _newOwner) public OnlyOwner{
        owner = _newOwner;
    }

    function fetchPost(string memory _hash) public view returns (Post memory) {
        return hashToPost[_hash];
    }

    function createPost(string memory title, string memory hash) public OnlyOwner {
        _postIds.increment();
        uint id = _postIds.current();
        Post memory post = Post(id, title, hash, false);
        idToPost[id] = post;
        hashToPost[hash] = post;
        emit PostCreated(id, title, hash);
    }

    function updatePost(uint id, string memory title, string memory hash, bool published) public OnlyOwner {
        Post memory post = Post(id, title, hash, published);
        idToPost[id] = post;
        hashToPost[hash] = post;
        console.log("update Post", id, title, hash);
        emit PostUpdated(id, title, hash, published);
    }
    
    function fetchPosts() public view returns (Post[] memory) {
        Post[] memory posts = new Post[](_postIds.current());
        for (uint i = 0; i < _postIds.current(); i++) {
            posts[i] = idToPost[i + 1];
        }
        return posts;
    }
}
