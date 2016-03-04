From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/6] pwm: pwm-img: test clock rate to avoid division by 0
Date: Fri, 4 Mar 2016 16:01:30 +0100
Message-ID: <20160304150130.GB26400@ulmo.nvidia.com>
References: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
 <1456958018-7849-4-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36789 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbcCDPBf (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Mar 2016 10:01:35 -0500
Content-Disposition: inline
In-Reply-To: <1456958018-7849-4-git-send-email-wsa@the-dreams.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pwm@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2016 at 11:33:34PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> The clk API may return 0 on clk_get_rate, so we should check the result b=
efore
> using it as a divisor.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>=20
> Should go individually via subsystem tree.
>=20
>  drivers/pwm/pwm-img.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

Thierry

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW2aNKAAoJEN0jrNd/PrOhrDkQALxc3vaC8cXSFuPl4OODUe8e
m8k/64Uud/EDpWV57WbOKSKuUpf8RdnpsyNZjwhuMiDMbuoz74CmBruZ4hIQRAtZ
WKJXSI7d5PxuDm64p5R2i26fbmr0O6LvSXNZhjC6sKdqptG9MJ2wX2aFaO4dv/Df
I59PYbK+qkKcZdKQIXsIuWuRUXV0inn30mcBlYIFlBZvOHIeFwOrnKqbAgP7ef+B
LoB+vaJMMfjhr9b2u6lAmTj0L5IVDlq7D3ASaXW0CQi8bg9zWfbnQRQ/hmkLMMY0
qIVnaFQsXVVSdChO7U8KVXlm8RSE0qCIk58VsZilcZkTie4uF2QGhyCPikcvpmLN
BWUZpEUwGFVqFLciFYne8yv6W8YSbKMCscWzaUlfQLWlZi8ZF7KOUILMEE7CKwk2
85pO7t2WlMZRw4XY0hjjq7Ib0m4rvYNoMDwt/Gc3C1DG0dQB+VAoWFvOUU4WaDga
xVvAoADItYbh1KetCY0CL9FrC8TSIrD+VSgAKfr/Kyaz6zGhXSkOAuYP+H1KZOE2
ru+LYL4glqIC+9REE9R2OHkhxc5Cy+CrEib4Svia8buS0kScKO6+WI9cOQZtMbpf
5KBi9i9KyVjJRW07w+Y9ohQor23y2rlj9ZIw+ag7jXWqPLNIgzC9UXnSR/J4FCBl
ZBm9F+QeukGT/9OndROj
=Zr2X
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
