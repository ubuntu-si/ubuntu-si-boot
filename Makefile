iso:
	cd DVD; mkisofs -o ../output.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table .
test:
	kvm -m 1024 -cdrom output.iso -boot d

.PHONY: iso test
