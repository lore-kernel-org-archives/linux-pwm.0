From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v7 2/5] pwm: add the Berlin pwm controller driver
Date: Mon, 5 Oct 2015 16:30:15 +0200
Message-ID: <20151005143015.GB27759@ulmo>
References: <1443797990-10809-1-git-send-email-antoine.tenart@free-electrons.com>
 <1443797990-10809-3-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38175 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbbJEOaS (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2015 10:30:18 -0400
Content-Disposition: inline
In-Reply-To: <1443797990-10809-3-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2015 at 04:59:47PM +0200, Antoine Tenart wrote:
> Add a PWM controller driver for the Marvell Berlin SoCs. This PWM
> controller has 4 channels.
>=20
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  drivers/pwm/Kconfig      |   9 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-berlin.c | 221 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 231 insertions(+)
>  create mode 100644 drivers/pwm/pwm-berlin.c

Applied, with minor tweaks, thanks.

Thierry

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWEol3AAoJEN0jrNd/PrOhXKUP/0/QRluk11XPgF5GojwX8yM2
IKUlTJG54b0973A6Ee0UGlL9cVPAv9Jd6cxFPfMCf86TeZUTppOt/PKcJ7ylIfIT
DHZR6GXJCEFSbCounrleRhbIa3qoNRIJMCoO+IpLdna4TCYB7sqq9CZMhXxyWAi0
2Tnn3JId8QR3Atb708kmpWhRzoK/w+SJ/FS8t1Zn6J1bzio2ewr7iXj/U+4npqnh
h1vW1B+WhpEl80GVMIrGeGN5UPteXhse+31J67c3y+2BUQl+kvVCAAOh1q1z9LGQ
btEXCCyjHe0FNf6yc40YqfklKS2UVVZyJx07lHU+u3c/ofVIcc7feBcP/yxIOV3U
pcIL/pJCMLUAgr2e6s2pIvo7BV+16G/BazIJ/Y29FQx4T7IMLQ9o/Bq/cc8gA9Sg
DrNOsGWfjwEKRX2sPyv/lYJVb2cjqStBUUfai8ibGrkwdR1IMcxKETQlwb/bgkya
2L9JKEldc5R8+j4S9WBjpZwWBwi+VKtlN4iMoqeYl8xHC62gwBbmSCeWIzt0HG/m
B3x55i3erejeQkjzaPYYD8G0SJSOGNE6/C+8nTa2O9+Vdnpgm9Jv9qav3amQ21Kq
+rkGbACUudRqPhbBDwmOw6a1s8rSvoBhdNAoZtW33hZhFPlII3u1DhIgY+15L4I/
rhQbbulQ5iCRO8frzNeZ
=7Se3
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
