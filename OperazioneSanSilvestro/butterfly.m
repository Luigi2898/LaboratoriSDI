function [Arp, Aip, Brp, Bip] = butterfly(Ar, Ai, Br, Bi, Wr, Wi)

Arp = Ar + Br * Wr - Bi * Wi;
Aip = Ai + Br * Wi + Bi * Wr;
Brp = -Arp + 2 * Ar;
Bip = -Aip + 2 * Ai;

end
