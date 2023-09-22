const EducationCertificates = artifacts.require('EducationCertificates');

module.exports = function (deployer){
    deployer.deploy(EducationCertificates);
};