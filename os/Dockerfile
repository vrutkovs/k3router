
FROM quay.io/coreos/butane as butane
COPY files/ files/
ADD os.bu /os.bu
RUN butane --pretty --strict -d ./files os.bu > /os.ign

FROM quay.io/coreos-assembler/fcos:testing-devel
COPY --from=butane /os.ign os.ign
RUN /usr/libexec/ignition-apply os.ign && rm -f os.ign \
    && rpm-ostree install firewalld tuned iwl7260-firmware NetworkManager-wifi cockpit cockpit-networkmanager cockpit-podman cockpit-storaged \
    && ostree container commit
