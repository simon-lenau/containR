if [ ${ubuntu_packages} ]; then \
    for item in ${ubuntu_packages}; do \
    apt-get install -y ${item}; \
    done;
fi;