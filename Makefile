TITLE       := AnimeHub
VERSION     := 1.00
TITLE_ID    := ANHB00001
CONTENT_ID  := IV0000-ANHB00001_00-ANIMEHUB000000

LIBS        := -lc -lkernel -lc++

TOOLCHAIN   := $(OO_PS4_TOOLCHAIN)
PROJDIR     := src
INTDIR      := build

CXX         := clang++
LD          := ld.lld
CDIR        := linux

CXXFLAGS    := --target=x86_64-pc-freebsd12-elf -fPIC -funwind-tables -c -isysroot $(TOOLCHAIN) -isystem $(TOOLCHAIN)/include -isystem $(TOOLCHAIN)/include/c++/v1
LDFLAGS     := -m elf_x86_64 -pie --script $(TOOLCHAIN)/link.x --eh-frame-hdr -L$(TOOLCHAIN)/lib $(LIBS) $(TOOLCHAIN)/lib/crt1.o

all: eboot.bin

$(INTDIR):
	mkdir -p $(INTDIR)

$(INTDIR)/main.o: $(PROJDIR)/main.cpp | $(INTDIR)
	$(CXX) $(CXXFLAGS) -o $@ $<

eboot.bin: $(INTDIR)/main.o
	$(LD) $(INTDIR)/main.o -o $(INTDIR)/AnimeHub.elf $(LDFLAGS)
	$(TOOLCHAIN)/bin/$(CDIR)/create-fself -in=$(INTDIR)/AnimeHub.elf -out=$(INTDIR)/AnimeHub.oelf --eboot "eboot.bin" --paid 0x3800000000000011

clean:
	rm -rf $(INTDIR) eboot.bin
