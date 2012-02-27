webchat.exe: webchat.opa
	opa --parser js-like $<

clean::
	rm -rf _build _tracks webchat.exe
