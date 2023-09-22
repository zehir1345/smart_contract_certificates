const truffleContract = require('truffle-contract');
const certtificatesContract = require("../build/contracts/EducationCertificates.json");

const web3provider = 'http://127.0.0.1:7545';

const certificates = truffleContract(certtificatesContract);
certificates.setProvider(web3provider);

contract("EducationCertificates", (account) => {
    let certificatesInstance;
    const owner = account[1];
    const user = account[4];
    
    before(async()=>{
      certificatesInstance = await certificates.deployed();
    });
    it('certificates values add and view', async()=>{
       const studentName = "Ali";
       const courseName = "Yazılım Geliştirme";
       const issueDate = 1695370919;
       const certificateHash = "abc.docx";

        await certificatesInstance.addCertificate(studentName,courseName,issueDate,certificateHash,{from : owner});
        const viewCert = await certificatesInstance.viewCertificate(owner, 0);
        assert.equal(studentName,viewCert.studentName,'doğru');
    });

});