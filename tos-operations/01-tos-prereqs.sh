sudo snap install dotnet-sdk --classic
sudo snap alias dotnet-sdk.dotnet dotnet
sudo snap install dotnet-runtime-60 --classic
sudo snap alias dotnet-runtime-60.dotnet dotnet

export DOTNET_ROOT=/snap/dotnet-sdk/current