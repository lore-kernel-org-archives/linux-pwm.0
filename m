From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH repost2] pwm: renesas-tpu: remove support for sh7372
Date: Fri, 18 Aug 2017 17:28:01 +0200
Message-ID: <20170818152801.GA18307@ulmo>
References: <20170818100858.GA15521@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34047 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdHRP2F (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Aug 2017 11:28:05 -0400
Content-Disposition: inline
In-Reply-To: <20170818100858.GA15521@verge.net.au>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 12:09:01PM +0200, Simon Horman wrote:
> Remove support for the SH7372 (SH-Mobile AP4) from the renesas-tpu driver.
>=20
> Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy file")
> removes this SoC from the kernel in v4.1.
>=20
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt | 1 -
>  drivers/pwm/pwm-renesas-tpu.c                             | 1 -
>  2 files changed, 2 deletions(-)

Applied, thanks.

Thierry

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmXB4EACgkQ3SOs138+
s6EQ/BAAuM2XlL+KPSzdKoO3Q26ek1Its1QmuGy5geSATWQI3hvLuC8eNrWTgdOb
tWAmpJMWzNnBksbSPhVHrDJygkHts81+HKSShueqTd+tYeR+NRh013XlsjcR0d/V
7TxDRBWT7iz1nAlBgCHYS7F5LESi/XMnwzwo+9JCqFWkYYjBqyzZz+Gwtzj83HgE
ue6ezrLUtCIGK6qEfm0oLpf8oxYSdYz6TUucUWBvWWiYD7BJe/aCMDZXyFT5Yjgf
RQl09oZvF+8tbBdCwZZQxeQIUB4SFvoWENtnkZ2793BXHxDaBWMxA/bBTP3SSh9N
YgDi5g+ZYpGiCpcotcKWkhpjdkkRaxWjeLrK72fDyQLAAgx2eEwSI8ciJ9Z/zryy
aC5ncG5Pn99X9aSsDFSbDwR1hn0UwuFhfTeuLOt22UUrzfH6u83MZSGQF0JcySH9
UJivoLng//YkcJwwtqQNfMNAFqjdJX+QWMm1z2tUa8HhtXfajuTdWcJJttVG1n5q
zEtsrhhoUFgFsW2iFlAQwTCvQmZZG/HD8gXCw7VtANrx5PDtJOjBWUOTd3IgaNf2
R6pkWcFDEq8aWPYjI6rxqw6j2yhaFlM/JvR2HC6eEtzOYij1M8JrydnCBQbV8w2q
TMyOeoyPayplz496Z/7N9m6Mr8DQBq4mWQWE4xdiIQtg9ButYPs=
=QHE3
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
