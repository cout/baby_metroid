macro assertpc(addr)
?pc:
  assert ?pc == <addr>, "Expected ", pc, " to equal <addr>"
endmacro
