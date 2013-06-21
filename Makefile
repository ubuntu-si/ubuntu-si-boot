iso:
	mkdir iso
	
	rm -rf DVD/casper64
	mount -t iso9660 -o loop ../ubuntu-si/dist64/binary-hybrid.iso ./iso
	mkdir DVD/casper64 -p
	cp iso/casper/* DVD/casper64/ -R
	sync
	umount ./iso
	
	rm -rf DVD/casper
	mount -t iso9660 -o loop ../ubuntu-si/dist32/binary-hybrid.iso ./iso
	mkdir DVD/casper -p
	cp iso/casper/* DVD/casper/ -R
	sync
	umount ./iso
	
	rm -rf iso
	cd DVD; mkisofs -o ../output.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table .
test:
	kvm -m 1024 -cdrom output.iso -boot d

.PHONY: iso test
