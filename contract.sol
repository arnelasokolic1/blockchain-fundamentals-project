//JUST TO KEEP MY CONTRACT 


CONTRACT ADDRESS : 0x5c0325f24ef153896d8E5Cf182Ef047dF18A0D31


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QuizContract {

    struct Question {
        string questionText;
        string[] options;
        uint256 correctAnswer;
    }

    address public admin;
    Question[] public questions;

    // Mappings to store user scores and whether they attempted the quiz
    mapping(address => uint256) public userScores;
    mapping(address => bool) public hasAttemptedQuiz;

    // Events
    event QuestionAdded(uint256 id, string questionText, string[] options);
    event QuestionRemoved(uint256 id);
    event QuizAttempted(address indexed user, uint256 score);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender; // Set the contract creator as the admin
    }

    // Function to add a question
    function addQuestion(
        string memory _questionText,
        string[] memory _options,
        uint256 _correctAnswer
    ) public onlyAdmin {
        require(
            _correctAnswer >= 1 && _correctAnswer <= 4,
            "Correct answer must be between 1 and 4"
        );
        questions.push(Question(_questionText, _options, _correctAnswer));
        emit QuestionAdded(questions.length - 1, _questionText, _options);
    }

    // Function to remove a question
    function removeQuestion(uint256 _id) public onlyAdmin {
        require(_id < questions.length, "Invalid question ID");
        for (uint256 i = _id; i < questions.length - 1; i++) {
            questions[i] = questions[i + 1];
        }
        questions.pop();
        emit QuestionRemoved(_id);
    }

    // Function to get question count
    function getQuestionCount() public view returns (uint256) {
        return questions.length;
    }

    // Function to get question by ID
    function getQuestion(uint256 _id)
        public
        view
        returns (
            string memory,
            string[] memory,
            uint256
        )
    {
        require(_id < questions.length, "Invalid question ID");
        Question memory q = questions[_id];
        return (q.questionText, q.options, q.correctAnswer);
    }

    // Function to attempt the quiz
    function attemptQuiz(uint256 _score) public {
        require(!hasAttemptedQuiz[msg.sender], "User has already attempted the quiz");
        hasAttemptedQuiz[msg.sender] = true;
        userScores[msg.sender] = _score;
        emit QuizAttempted(msg.sender, _score);
    }

    // Function to get the user's score
    function getUserScore(address _user) public view returns (uint256) {
        return userScores[_user];
    }

    // Function to check if the user has attempted the quiz
    function userHasAttempted(address _user) public view returns (bool) {
        return hasAttemptedQuiz[_user];
    }
}



CONTRACT ABI 


[
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_questionText",
				"type": "string"
			},
			{
				"internalType": "string[]",
				"name": "_options",
				"type": "string[]"
			},
			{
				"internalType": "uint256",
				"name": "_correctAnswer",
				"type": "uint256"
			}
		],
		"name": "addQuestion",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_score",
				"type": "uint256"
			}
		],
		"name": "attemptQuiz",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "questionText",
				"type": "string"
			},
			{
				"indexed": false,
				"internalType": "string[]",
				"name": "options",
				"type": "string[]"
			}
		],
		"name": "QuestionAdded",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			}
		],
		"name": "QuestionRemoved",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "user",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "score",
				"type": "uint256"
			}
		],
		"name": "QuizAttempted",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_id",
				"type": "uint256"
			}
		],
		"name": "removeQuestion",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "admin",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_id",
				"type": "uint256"
			}
		],
		"name": "getQuestion",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			},
			{
				"internalType": "string[]",
				"name": "",
				"type": "string[]"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getQuestionCount",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_user",
				"type": "address"
			}
		],
		"name": "getUserScore",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "hasAttemptedQuiz",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "questions",
		"outputs": [
			{
				"internalType": "string",
				"name": "questionText",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "correctAnswer",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_user",
				"type": "address"
			}
		],
		"name": "userHasAttempted",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "userScores",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]