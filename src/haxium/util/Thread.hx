package haxium.util;

#if neko
typedef Thread = neko.vm.Thread;
#else
typedef Thread = cpp.vm.Thread;
#end
