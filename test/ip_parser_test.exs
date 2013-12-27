defmodule IpParserTest do
  use ExUnit.Case

  setup do
    bits = File.read!("./sample_packet.bits")
    # Get a record destructured out of the binary
    packet = IPPacket.Record.from_bits(bits)
    {:ok, packet: packet}
  end

  test "getting protocol version", meta do
    assert meta[:packet].protocol_version == 4
  end

  test "getting header size", meta do
    assert meta[:packet].size_in_words == 5
    assert meta[:packet].size_in_bits == 160
  end

  test "getting protocol", meta do
    assert meta[:packet].protocol == 6
    assert meta[:packet].protocol_atom == :tcp
    assert meta[:packet].tcp?
  end
end
