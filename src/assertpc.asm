macro assertpc(addr)
?pc:
  assert ?pc == <addr>, "Expected ", pc, " to equal ", hex(<addr>)
endmacro
