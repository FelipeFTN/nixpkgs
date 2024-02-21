{ lib
, azure-common
, azure-core
, buildPythonPackage
, fetchPypi
, isodate
, pythonOlder
, typing-extensions
}:

buildPythonPackage rec {
  pname = "azure-eventgrid";
  version = "4.17.0";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-6/bqxCAvewKR5lI6ulFpP3THu9DH1rDEFwsRynDJ6+k=";
  };

  propagatedBuildInputs = [
    azure-common
    azure-core
    isodate
  ]  ++ lib.optionals (pythonOlder "3.8") [
    typing-extensions
  ];

  # Module has no tests
  doCheck = false;

  pythonImportsCheck = [
    "azure.eventgrid"
  ];

  meta = with lib; {
    description = "A fully-managed intelligent event routing service that allows for uniform event consumption using a publish-subscribe model";
    homepage = "https://github.com/Azure/azure-sdk-for-python";
    changelog = "https://github.com/Azure/azure-sdk-for-python/blob/azure-eventgrid_${version}/sdk/eventgrid/azure-eventgrid/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ maxwilson ];
  };
}
