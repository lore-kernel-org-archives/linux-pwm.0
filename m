From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: lpss: Prevent on_time_div overflow on lower
 frequencies
Date: Fri, 10 Jun 2016 15:40:55 +0200
Message-ID: <20160610134055.GJ27142@ulmo.ba.sec>
References: <1465562601-44876-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j+MD90OnwjQyWNYt"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34029 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbcFJNk6 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jun 2016 09:40:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id n184so18046849wmn.1
        for <linux-pwm@vger.kernel.org>; Fri, 10 Jun 2016 06:40:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1465562601-44876-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Dan O'Donovan <dan@emutex.com>, linux-pwm@vger.kernel.org


--j+MD90OnwjQyWNYt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2016 at 03:43:21PM +0300, Mika Westerberg wrote:
> If duty_ns is large enough multiplying it by 255 overflows and results
> wrong duty cycle value being programmed. For example with 10ms duty when
> period is 20ms (50%) we get
>=20
>   255 * 10000000 / 20000000 =3D -87
>=20
> because 255 * 10000000 overlows int. Whereas correct value should be
>=20
>   255 * 10000000 / 20000000 =3D 127
>=20
> Fix this by using unsigned long long as type for on_time_div and changing
> integer literals to use proper type annotation.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Resending with linux-pwm address corrected.
>=20
> This is on top of Dan's patch:
>=20
>   https://patchwork.ozlabs.org/patch/628683/
>=20
>  drivers/pwm/pwm-lpss.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--j+MD90OnwjQyWNYt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXWsNnAAoJEN0jrNd/PrOhlWMP/1Y79ySMNGg24oTQcgGyP0Eq
4yVUTI6M+o+328X1CrvPXeAgBkCBCxckUkH4mjcRoYzy1xtTEOydtu7je+99KV9C
znTjudKbSV4LGiKBj8GL1uPevOACVW4IhBKaod8Q1TmLAXPYcjyaFkYqNNKDEZZ9
ka87TmJR1mXm5HKB6swuckwkOnfqprZewEdUlSfiG+QziVGVtej+gDwWDeQGLGDu
XbpdWNp6nP3dNiN2BSHY4PFO22+7QBJTJniVzl0ETGZeKbSPf3U9Iezesb54Zg3L
8gQlCXIngRYyDSWACzNKxjWHU7whuhdy+Flrq8cTx19gejmXdqrDfDAs7CSSVFK6
JFCo54OVheC4++Ebsw1THDT1U/ch2LVJupWVDuItm8tzjBysjMOwKfUQAGWLVsGO
aPonzi46sPOr7oWZyTEUEjILFNuEwFj7QTuIHH63VEs4++fG7W0exqxmlqR7fjn+
mmF7R8PHYKIH+N7OJ/U5t1HuKDwCiPavh8jgs/Azv6UyPG5Q00DN8+DOAjhkX1g8
+eKxjZaDKN6ykXA9YTHEX8KfmN+ZDYPcJqyFHPfJ24fgCcJWT90PQCdCh+v+ix+E
ByzG1BxzW9/gn79VfLZS7VlM7P+gIg2RrVYKl2ZZLVUxdiC6hKpcOV0a6WAK3Nsc
udsIxwBiVuPACJR4wdZP
=6Nf3
-----END PGP SIGNATURE-----

--j+MD90OnwjQyWNYt--
