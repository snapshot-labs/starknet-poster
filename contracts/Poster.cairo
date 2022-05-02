%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

@event
func new_post(
  address: felt,
  content_len: felt,
  content: felt*,
  tag_len: felt,
  tag: felt*
):
end

@external
func post{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr: felt}(
  content_len : felt,
  content : felt*,
  tag_len : felt,
  tag : felt*
) -> ():
  let (address) = get_caller_address()
  new_post.emit(address, content_len, content, tag_len, tag)
  return ()
end
