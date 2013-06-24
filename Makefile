iso:
	mkdir iso
	
	rm -rf DVD/casper64
	mount -t iso9660 -o loop ../ubuntu-64bit-iso/dist64/binary-hybrid.iso ./iso
	mkdir DVD/casper64 -p
	cp iso/casper/* DVD/casper64/ -R
	sync
	umount ./iso
	
	rm -rf DVD/casper
	mount -t iso9660 -o loop ../ubuntu-32bit-iso/dist32/binary-hybrid.iso ./iso
	mkdir DVD/casper -p
	cp iso/casper/* DVD/casper/ -R
	sync
	umount ./iso
	
	rm -rf iso
	
	rm output.iso
	genisoimage -o ./output.iso \
	-no-emul-boot -boot-load-size 4 -boot-info-table \
	-r -b isolinux/isolinux.bin -c isolinux/boot.cat -J -l -cache-inodes -allow-multidot \
	-p "Ubuntu.si" \
	-no-emul-boot -boot-load-size 4 -boot-info-table \
	-V "Ubuntu.si 12.04 LTS" -cache-inodes -r -J -l \
	-x ./DVD/casper/filesystem.manifest \
	-joliet-long -input-charset utf-8 \
	./DVD
	isohybrid output.iso

test:
	kvm -m 1024 -cdrom output.iso -boot d

.PHONY: iso test
