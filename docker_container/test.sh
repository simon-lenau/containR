export ubuntu_packages=$(cat ./ubuntu_packages)

if [ -n "${ubuntu_packages}" ]; then
    for item in ${ubuntu_packages}; do
        echo $item
    done
fi
