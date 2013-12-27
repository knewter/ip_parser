# IP Parser

Just a sample project to parse IP packets in Elixir...

## Getting the sample packet in a handy bit format

So here's what I did to get the sample packet into bit format.  I had it in hex,
initially, and then I used this to write it to a file:


```
iex(14)> hex = '4510002C24B200004006FDDFAC100009AC1000010447001760C6DF900000000060020200F9460000020405B4'
iex(15)> bits = Enum.reduce(hex, [], fn(elem, accum) -> accum ++ [:erlang.list_to_integer([elem], 16)] end)
[4, 5, 1, 0, 0, 0, 2, 12, 2, 4, 11, 2, 0, 0, 0, 0, 4, 0, 0, 6, 15, 13, 13, 15,
 10, 12, 1, 0, 0, 0, 0, 9, 10, 12, 1, 0, 0, 0, 0, 1, 0, 4, 4, 7, 0, 0, 1, 7, 6,
 0, ...]
iex(16)> out = Enum.reduce(bits, <<>>, fn(elem, accum) -> <<accum :: bitstring, elem :: size(4)>> end)
iex(17)> File.write!("./sample_packet.bits", bits, [:write])
:ok
```

It's not the most efficient way I could have done that, to be sure, but it works
fine.

## Usage

Once you have the bits for the file in front of you, you'll want to be able to
decode them  Something like this:

```elixir
bits = File.read!("./sample_packet.bits")
# Get a record destructured out of the binary
record = IPPacket.Record.from_bits(bits)
record.protocol_version == 4 #=> true
record.size_in_bits == 160 #=> true
```

