// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract StudentData {
    struct Student {
        uint256 rollNumber;
        string name;
        string department;
        uint8 semester;
    }

    Student[] public students;
    event FallbackCalled(address sender);

    function addStudent(
        uint256 rollNumber,
        string calldata name,
        string calldata department,
        uint8 semester
    ) external {
        require(rollNumber > 0, "Invalid roll number");
        require(bytes(name).length > 0, "Name is required");
        require(semester >= 1 && semester <= 8, "Semester must be 1 to 8");

        students.push(Student(rollNumber, name, department, semester));
    }

    function getStudentCount() external view returns (uint256) {
        return students.length;
    }

    receive() external payable { }  

    fallback() external payable  {
        emit FallbackCalled(msg.sender);
    }
}
