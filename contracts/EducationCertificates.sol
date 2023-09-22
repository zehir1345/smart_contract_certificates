// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract EducationCertificates {
    struct Certificate {
        string studentName;
        string courseName;
        uint256 issueDate;
        string certificateHash; // Belgeyi saklamak için bir IPFS veya benzeri link
    }

    mapping(address => Certificate[]) public studentCertificates;

    event CertificateAdded(address indexed studentAddress, string studentName, string courseName, uint256 issueDate);

    function addCertificate(string memory _studentName, string memory _courseName, uint256 _issueDate, string memory _certificateHash) public {
        require(bytes(_studentName).length > 0);
        require(bytes(_courseName).length > 0);
        require(_issueDate > 0);
        require(bytes(_certificateHash).length > 0);

        Certificate memory newCertificate = Certificate(_studentName, _courseName, _issueDate, _certificateHash);
        studentCertificates[msg.sender].push(newCertificate);

        emit CertificateAdded(msg.sender, _studentName, _courseName, _issueDate);
    }

    function getCertificateCount(address studentAddress) public view returns (uint) {
        return studentCertificates[studentAddress].length;
    }

    function viewCertificate(address studentAddress, uint index) public view returns (string memory, string memory, uint256, string memory) {
        require(index < studentCertificates[studentAddress].length);
        Certificate memory cert = studentCertificates[studentAddress][index];
        return (cert.studentName, cert.courseName, cert.issueDate, cert.certificateHash);
    }
}
