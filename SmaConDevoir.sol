// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract MiniSocial {
    struct Post {
        string message;
        address author;
        uint256 createdAt;
        uint256 updatedAt;
        uint256 likes;
        uint256 dislikes;
        bool isDeleted;
    }

    struct UserInteraction {
        bool hasLiked;
        bool hasDisliked;
    }

    uint256 public constant MAX_POST_LENGTH = 280; // Maximum length of a post message
    
    Post[] public posts;
    mapping(uint256 => mapping(address => UserInteraction)) public userInteractions;
    mapping(address => uint256[]) public userPosts;

    // Events
    event PostAdded(uint256 indexed postId, address indexed author, string message, uint256 timestamp);
    event PostModified(uint256 indexed postId, string newMessage, uint256 timestamp);
    event PostDeleted(uint256 indexed postId, address indexed author, uint256 timestamp);
    event PostLiked(uint256 indexed postId, address indexed user, uint256 newLikeCount);
    event PostDisliked(uint256 indexed postId, address indexed user, uint256 newDislikeCount);

    // Modifiers
    modifier validPostId(uint256 postId) {
        require(postId < posts.length, "Invalid post ID");
        require(!posts[postId].isDeleted, "Post has been deleted");
        _;
    }

    modifier onlyAuthor(uint256 postId) {
        require(posts[postId].author == msg.sender, "Only the author can perform this action");
        _;
    }

    // Core functions
    function publishPost(string memory _message) public {
        require(bytes(_message).length > 0, "Message cannot be empty");
        require(bytes(_message).length <= MAX_POST_LENGTH, "Message too long");

        uint256 postId = posts.length;
        posts.push(Post({
            message: _message,
            author: msg.sender,
            createdAt: block.timestamp,
            updatedAt: block.timestamp,
            likes: 0,
            dislikes: 0,
            isDeleted: false
        }));

        userPosts[msg.sender].push(postId);
        emit PostAdded(postId, msg.sender, _message, block.timestamp);
    }

    function modifyPost(uint256 postId, string memory _newMessage) 
        public 
        validPostId(postId) 
        onlyAuthor(postId) 
    {
        require(bytes(_newMessage).length > 0, "Message cannot be empty");
        require(bytes(_newMessage).length <= MAX_POST_LENGTH, "Message too long");

        posts[postId].message = _newMessage;
        posts[postId].updatedAt = block.timestamp;
        
        emit PostModified(postId, _newMessage, block.timestamp);
    }

    function deletePost(uint256 postId) 
        public 
        validPostId(postId) 
        onlyAuthor(postId) 
    {
        posts[postId].isDeleted = true;
        emit PostDeleted(postId, msg.sender, block.timestamp);
    }

    function likePost(uint256 postId) public validPostId(postId) {
        UserInteraction storage interaction = userInteractions[postId][msg.sender];
        require(!interaction.hasLiked, "Already liked this post");

        if (interaction.hasDisliked) {
            interaction.hasDisliked = false;
            posts[postId].dislikes--;
        }

        interaction.hasLiked = true;
        posts[postId].likes++;

        emit PostLiked(postId, msg.sender, posts[postId].likes);
    }

    function dislikePost(uint256 postId) public validPostId(postId) {
        UserInteraction storage interaction = userInteractions[postId][msg.sender];
        require(!interaction.hasDisliked, "Already disliked this post");

        if (interaction.hasLiked) {
            interaction.hasLiked = false;
            posts[postId].likes--;
        }

        interaction.hasDisliked = true;
        posts[postId].dislikes++;

        emit PostDisliked(postId, msg.sender, posts[postId].dislikes);
    }

    // View functions
    function getTotalPosts() public view returns (uint256) {
        return posts.length;
    }

    function getPost(uint256 index) public view returns (
        string memory message,
        address author,
        uint256 likes,
        uint256 dislikes,
        uint256 createdAt,
        uint256 updatedAt,
        bool hasLiked,
        bool hasDisliked
    ) {
        require(index < posts.length, "Invalid post ID");
        Post storage post = posts[index];
        UserInteraction storage interaction = userInteractions[index][msg.sender];
        
        return (
            post.message,
            post.author,
            post.likes,
            post.dislikes,
            post.createdAt,
            post.updatedAt,
            interaction.hasLiked,
            interaction.hasDisliked
        );
    }

    function getUserPosts(address user) public view returns (uint256[] memory) {
        return userPosts[user];
    }

    function getUserPostsWithDetails(address user) public view returns (
        uint256[] memory postIds,
        string[] memory messages,
        uint256[] memory likes,
        uint256[] memory dislikes,
        uint256[] memory timestamps
    ) {
        uint256[] memory userPostIds = userPosts[user];
        uint256 length = userPostIds.length;
        
        messages = new string[](length);
        likes = new uint256[](length);
        dislikes = new uint256[](length);
        timestamps = new uint256[](length);
        
        for (uint256 i = 0; i < length; i++) {
            uint256 postId = userPostIds[i];
            Post storage post = posts[postId];
            
            messages[i] = post.message;
            likes[i] = post.likes;
            dislikes[i] = post.dislikes;
            timestamps[i] = post.createdAt;
        }
        
        return (userPostIds, messages, likes, dislikes, timestamps);
    }
}