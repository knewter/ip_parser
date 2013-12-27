defrecord IPPacket.Record,
  protocol_version: nil,
  size_in_words: nil,
  tos: nil,
  total_length: nil,
  identifier: nil,
  flags: nil,
  fragment_offs: nil,
  ttl: nil,
  protocol: nil,
  header_checksum: nil,
  src_ip: nil,
  dst_ip: nil,
  options: nil,
  data: nil do

  def size_in_bits(record), do: record.size_in_words * 32

  def src_ip_string(record) do
    ip_string(record.src_ip)
  end

  def dst_ip_string(record) do
    ip_string(record.dst_ip)
  end

  defp ip_string(ip) do
    << first, second, third, fourth >> = << ip :: size(32) >>
    "#{first}.#{second}.#{third}.#{fourth}"
  end

  def protocol_atom(record) do
    case record.protocol do
      1  -> :icmp
      2  -> :igmp
      6  -> :tcp
      17 -> :udp
      _  -> :unknown
    end
  end

  def tcp?(record) do
    record.protocol_atom == :tcp
  end

  def from_bits(bits) do
    << protocol_version :: size(4),
       size_in_words :: size(4),
       tos :: size(8),
       total_length :: size(16),
       identifier :: size(16),
       flags :: size(3),
       fragment_offs :: size(13),
       ttl :: size(8),
       protocol :: size(8),
       header_checksum :: size(16),
       src_ip :: size(32),
       dst_ip :: size(32),
       options :: size(32),
       data :: binary >> = bits

    IPPacket.Record.new(
      protocol_version: protocol_version,
      size_in_words: size_in_words,
      tos: tos,
      total_length: total_length,
      identifier: identifier,
      flags: flags,
      fragment_offs: fragment_offs,
      ttl: ttl,
      protocol: protocol,
      header_checksum: header_checksum,
      src_ip: src_ip,
      dst_ip: dst_ip,
      options: options,
      data: data
    )
  end
end

