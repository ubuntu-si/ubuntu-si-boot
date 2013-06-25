iso:
	rm -rf DVD/.disk
	mkdir DVD/.disk -p
	
	rm -rf DVD/casper64
	mkdir DVD/casper64 -p
	cp ../ubuntu-64bit-iso/dist64/binary/casper/* DVD/casper64/ -R
	cp ../ubuntu-64bit-iso/dist64/binary/.disk/* DVD/.disk/ -Rf
	sync
	
	rm -rf DVD/casper
	mkdir DVD/casper -p
	cp ../ubuntu-32bit-iso/dist32/binary/casper/* DVD/casper/ -R
	cp ../ubuntu-32bit-iso/dist32/binary/.disk/* DVD/.disk/ -Rf
	sync
		
	rm -f output.iso
	genisoimage -o ./output.iso \
	-no-emul-boot -boot-load-size 4 -boot-info-table \
	-r -b isolinux/isolinux.bin -c isolinux/boot.cat -J -l -cache-inodes -allow-multidot \
	-p "Ubuntu.si" \
	-no-emul-boot -boot-load-size 4 -boot-info-table \
	-V "Ubuntu.si 12.04 LTS" -cache-inodes -r -J -l \
	-x ./DVD/casper/filesystem.manifest \
	-joliet-long -input-charset utf-8 \
	./DVD

test:
	kvm -m 1024 -cdrom output.iso -boot d

.PHONY: iso test
