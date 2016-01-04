From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [patch] pwm: omap-dmtimer: Potential NULL dereference on error
Date: Mon, 4 Jan 2016 09:00:00 +0100
Message-ID: <20160104080000.GC23057@ulmo>
References: <20151221131304.GA27286@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37590 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbcADIAD (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Jan 2016 03:00:03 -0500
Content-Disposition: inline
In-Reply-To: <20151221131304.GA27286@mwanda>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 21, 2015 at 04:13:04PM +0300, Dan Carpenter wrote:
> "omap" is NULL so we can't dereference it.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> It's weird that request_by_node() and free() are allocate/free pairs.
> Also this was Thierry's last minute tweaks mentioned in the changelog,
> Neil Armstrong is innocent.  :P

Applie, thanks.

Thierry

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWiiaAAAoJEN0jrNd/PrOhqdQP/0isijZgbJY8al9OuVdK3+Vk
7Asr5GEiqg3LbG3eC91X8Km0ZfbhkIEX2fQVc+vCjoBlvEUfSjG8o4RHbD57gzDO
+qMj4TIHEZFlrn7UtzKUvfn9bBJAyLNHxeWgeJbpDD9D8CTUQdaVppnwt9JkgU4Q
RQMI1viAtg1PvP+JZ6cHf6tSraN1CAUWUqS/6iPYstnPdcQORRK8omVZUNhub8+Y
2IGrSEGM/qFAEmoG/ae+dKy5Hz/oPTHGLfksH6107vMU1kgiTCMoFDyYCTUP7Wbz
oajxRI3k2pxtWtUySe5Vao895PL5vBiggGt5TW/r8hqysxM18ro6rVHD/50Gik8x
KDnh6hl6tOgPppNBtaj4LmqycGNpGSpXTuYvDat9v95ehOLHHGzKWadTze9uF1iL
+cg6oPkVaYh7AYtyDX3MNEGHC6c7ms+3mLYLpcDsBy4BMsALYb+gyyhymvQhh2Ri
34nrXZqWqd6hHHoJbkdhyGpOMdqiMN/D2MNFrRmXXJAF/r58nXAvdF8ApqIQ9YZ6
cvQeP/XPdX26ByItSoIwjtxyci+gLPhmRDSIm06rQw5pOPI3iWvzeCSm5qvQwnMs
J1sVcd6ewENKORWsqBqT16ROiGR57x7HqQ+PTPp/1zsyQwe2HL58yfy+P/PUYON7
c8fFiXP++YJQRwDV3Vnt
=+fN7
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
