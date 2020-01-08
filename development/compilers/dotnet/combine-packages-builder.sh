source $stdenv/setup

mkdir -p $out

# CLI will follor real path, so we have to copy it
cp $cli/dotnet $out/
mkdir $out/bin
ln -s $out/dotnet $out/bin/

# Create runtime & host links
for runtime in $runtimes; do
  for h in $(ls $runtime/host); do
    mkdir -p $out/host/$h
    ln -sf $runtime/host/$h/* $out/host/$h
  done
  for i in $(ls $runtime/shared); do
    mkdir -p $out/shared/$i
    ln -sf $runtime/shared/$i/* $out/shared/$i
  done
done

# Link SDKs
mkdir -p $out/{sdk,packs,templates,sdk/NuGetFallbackFolder}
for sdk in $sdks; do
  test -d $sdk/templates && ln -sf $sdk/templates/* $out/templates/
  test -d $sdk/packs && ln -sf $sdk/packs/* $out/packs/
  test -d $sdk/sdk && for sd in $(ls $sdk/sdk); do
    [ "$sd" = "NuGetFallbackFolder" ] && continue
    ln -sf $sdk/sdk/$sd $out/sdk/
  done
  # Link NuGetFallbackFolder contents
  test -d $sdk/sdk/NuGetFallbackFolder && find $sdk/sdk/NuGetFallbackFolder -type f -exec ln -sf {} $out/sdk/NuGetFallbackFolder/ \;
done

# Print installed components
$out/bin/dotnet --info
