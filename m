From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: lpss: fix base_unit calculation for PWM frequency
Date: Fri, 10 Jun 2016 15:38:41 +0200
Message-ID: <20160610133841.GI27142@ulmo.ba.sec>
References: <1464706264-19344-1-git-send-email-dan@emutex.com>
 <1464791472-17738-1-git-send-email-dan@emutex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JIpyCmsTxyPLrmrM"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36398 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161261AbcFJNio (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jun 2016 09:38:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id m124so17985552wme.3
        for <linux-pwm@vger.kernel.org>; Fri, 10 Jun 2016 06:38:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464791472-17738-1-git-send-email-dan@emutex.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Dan O'Donovan <dan@emutex.com>
Cc: linux-pwm@vger.kernel.org, mika.westerberg@linux.intel.com


--JIpyCmsTxyPLrmrM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 01, 2016 at 03:31:12PM +0100, Dan O'Donovan wrote:
> The base_unit calculation applies an offset of 0x2 which adds
> significant error for lower frequencies and doesn't appear to be
> warranted - rounding the division result gives a correct value.
>=20
> Also, the upper limit check for base_unit is off-by-one; the upper
> nibble of base_unit is invalid if >=3D128 according to the Table 88
> in the Z8000 Processor Series Datasheet Volume 1 (Rev. 2).
>=20
> Verified on UP Board (Cherry Trail) and Minnowboard Max (Bay Trail).
>=20
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> v2:
>  * fixed error in a code comment regarding base_unit, spotted by Mika
>=20
>  drivers/pwm/pwm-lpss.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Applied, thanks.

Thierry

--JIpyCmsTxyPLrmrM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXWsLeAAoJEN0jrNd/PrOhfCIQAJ/2lJ+M1CR/aQIs7mxx6I+w
gg00wYhO06PyMJpgNOGhfD+Hj7JpNEq0u085AZOchskepkQK5n00UnTXgTe5pwwB
RHmwZdSc0h1qygaAP1Yi98yucXvLCkp+lEWogL7xLYmlIS3jJz8NAYpXugjMYqwo
Gn6EyC1tbnW5bnzpKVRuY7bJtfdMkPJa5OllAsFEbUbINUMSkNhU2cM1jBC+tURD
vwGXdxCI/PjbH7avgKyX+wHZ8FHMBa6Q7sLg2KCuLz70aVpj3vpDBSbE01mlJaMm
i3f5e8v9wDzDyCUa/mCAmaTIj5Na7RqfHX65EcfAT/hupTIWwya+5S09tsu1ry5z
+5Eiw1U0w2cazM0zMM/ODelHCeTb0Lwg6xp+Ow5JG+CTdyyBuYLaVtcYT3ZAuyZA
HNnSRBoZKY8Bu4RgdwdZIPWVEaoN6IB/qy3GFrT5VXVAC8n1dXWp/U+p84Gy74Jz
SWtAgSnb/D9kfjPeXT3xgTIIogyKu5FfSCN9VnFvnLFEX4ragmP/OGGA9IYcT9yj
SO0Db1mJ4JshacTEgk6c8fC3JUHj8KkPXV+h/8mMRGKISd7UBF2/ITbhJW2OeJKn
4pf6zBwVj8YFeH+6nt0pzn88NzE5fGd4CcNGXxOYFjIfoLQRgl9pX2zZYdHwqiEP
i9I8KV7hp8Nhx01/OBxe
=VRgo
-----END PGP SIGNATURE-----

--JIpyCmsTxyPLrmrM--
