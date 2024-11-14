# MiniSocial - Web3 Social Media Demo

MiniSocial is a decentralized social media platform built on the Ethereum blockchain that allows users to create, edit, and interact with posts in a trustless and transparent manner. This dApp demonstrates core social media functionalities while leveraging Ethereum's smart contract capabilities for data integrity and decentralized user authentication.

## Technology Stack

- **Frontend:**
  - javascript
  - HTML
  - css
  - Bootstrap 
  - Font Awesome 
  - Web3.js 

- **Smart Contract:**
  - Solidity 
  - Ethereum blockchain
  - MetaMask
  - Hardhat local testnet
  - Remix IDE

## Features

- 📝 Create and publish posts to Ethereum blockchain
- ✏️ Edit your own posts
- 👍 Like/Dislike posts with on-chain tracking
- 🔄 Real-time updates using Web3 events
- 👤 User authentication via MetaMask
- 📱 Responsive design
- ⛓️ Blockchain-based data persistence

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/minisocial.git
cd minisocial
```

2. Deploy the smart contract:
   - Open Remix IDE (https://remix.ethereum.org)
   - Create a new file named `MiniSocial.sol`
   - Copy the smart contract code into the file
   - Compile the contract
   - Deploy to your chosen Ethereum network (testnet recommended)
   - Save the deployed contract address

3. Configure the frontend:
   - Open `index.html`
   - Update the `contractAddress` variable with your deployed contract address and the `contractABI` with your contract ABI:
   ```javascript
   const contractAddress = "YOUR_DEPLOYED_CONTRACT_ADDRESS";
   const contractABI = [//contcat ABI];
   ```

4. Run Hardhat Network (local testnet) in stand-alone mode (`chain file`):
   - You need to have node.js and yarn in your computer.
   - Open CMD and run `cd chain`, then run `yarn hardhat node`.
     
5. Serve the frontend:
   - You can use any local server. For example, with Xampp

## Smart Contract Functions

### Core Functions

- `publishPost(string memory _message)`: Create a new post
- `modifyPost(uint256 postId, string memory _newMessage)`: Edit an existing post
- `deletePost(uint256 postId)`: Delete a post
- `likePost(uint256 postId)`: Like a post
- `dislikePost(uint256 postId)`: Dislike a post

### View Functions

- `getTotalPosts()`: Get the total number of posts
- `getPost(uint256 index)`: Get details of a specific post
- `getUserPosts(address user)`: Get all posts by a specific user
- `getUserPostsWithDetails(address user)`: Get detailed information about a user's posts

## Usage

1. Connect MetaMask:
   - Click "Change User" to connect your MetaMask wallet
   - Approve the connection request in MetaMask
   - Ensure you're connected to the correct Ethereum network

2. Create a post:
   - Type your message in the "What's on your mind?" text area
   - Click "Post" to publish
   - Confirm the transaction in MetaMask

3. Interact with posts:
   - Like/Dislike: Click the thumbs up/down buttons
   - Edit: Click the "Edit" button on your own posts
   - Refresh: Click the "Refresh" button to load new posts

## Limitations

- Maximum post length: 280 characters
- Users can only edit/delete their own posts
- One like/dislike per user per post
- Liking removes previous dislike and vice versa
- Gas costs for all interactions (posting, liking, etc.)

## Security Features

- Author-only post modification
- Input validation for message length
- Protection against double-voting
- MetaMask-based user authentication
- Transaction-based operations for data integrity

## Project Interface

![Screenshot 2024-11-14 005846](https://github.com/user-attachments/assets/54015a03-1df2-451f-8be4-657494030325)
![Screenshot 2024-11-14 005748](https://github.com/user-attachments/assets/fd6d814e-1b4a-457d-a169-b019bab2dc51)
![Screenshot 2024-11-14 005828](https://github.com/user-attachments/assets/dba45aa7-c978-42a7-8055-12efa39b62e6)

## Project Created By:
**Ammar AMZIL**
