// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract TicTacToe {
    
    address public player1;
    address public player2;
    uint public turn;
    uint public winnerWinnerChickenDinner;
    uint[] public board = new uint[](9);
    //top left corner is 1, then left to right, up to down
    
    constructor(address p2) {
        // at inception the contract takes the two players addresses
        player1 = msg.sender;
        player2 = p2;
        turn = 1;
    }
    
    function withdraw() public {
        require(msg.sender == player1, "Only player1 can withdraw");
        payable(player1).transfer(address(this).balance);
    }

    function myTurn() public view returns(bool) {
        //returns true if it's the sender's turn to play
        return (msg.sender == player1 && turn == 1) || (msg.sender == player2 && turn == 2);
    }
    
    function subCheckWin(uint a, uint b, uint c) private view returns (bool) {
        return board[a] > 0 && board[a] == board[b] && board[b] == board[c];
    }

    function checkWin() private view returns (uint) {
        //function used to check if there is a winning player
        for (uint i = 0; i < 3; i++) {
            if (subCheckWin(i, 3 + i, 6 + i)) {
                return board[i];
            }
            if (subCheckWin(3 * i, 3 * i + 1, 3 * i + 2)) {
                return board[3 * i];
            }
        }
        if (subCheckWin(0, 4, 8)) {
            return board[0];
        }
        if (subCheckWin(2, 4, 6)) {
            return board[2];
        }
        return 0;
    }
    
    function winner() public view returns (uint) {
        //getter for the winner attribute
        return winnerWinnerChickenDinner;
    }

    function validMove(uint a) public view returns (bool) {
        //function to assess whether a required move is valid or not
        //used both as an external callable function and internally to validate moves
        //before writing them to the board
        return !(winnerWinnerChickenDinner > 0 || a < 0 || a > 8 || board[a] > 0) &&
                ((msg.sender == player1 && turn == 1) || (msg.sender == player2 && turn == 2));
    }

    function play(uint a) public {
        //checks if a move is valid before inserting it to the board
        require(validMove(a), "Invalid move");
        board[a] = turn;
        winnerWinnerChickenDinner = checkWin();
        // Only switch turns if the game is still ongoing
        if (winnerWinnerChickenDinner == 0) {
            // Switch turns
            turn = (turn == 1) ? 2 : 1;
        }
    }

    function displayBoard() public view returns(uint[] memory) {
        //getter for the board
        return board;
    }
}
