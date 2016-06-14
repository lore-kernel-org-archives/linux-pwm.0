From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: atmel-hlcdc: Fix default PWM polarity
Date: Tue, 14 Jun 2016 10:55:38 +0200
Message-ID: <20160614085538.GA24442@ulmo.ba.sec>
References: <1463476352-7485-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160517110005.GA26166@ulmo.ba.sec>
 <20160614095826.3bbbfd26@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35313 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbcFNIzm (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Jun 2016 04:55:42 -0400
Received: by mail-wm0-f49.google.com with SMTP id v199so110888357wmv.0
        for <linux-pwm@vger.kernel.org>; Tue, 14 Jun 2016 01:55:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160614095826.3bbbfd26@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2016 at 09:58:26AM +0200, Boris Brezillon wrote:
> Hi Thierry,
>=20
> On Tue, 17 May 2016 13:00:05 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Tue, May 17, 2016 at 11:12:32AM +0200, Boris Brezillon wrote:
> > > The PWM device exposed by the HLCDC IP is configured with an inverted
> > > polarity by default. Registering the PWM chip with the normal polarity
> > > was not a problem before commit 42e8992c58d4 ("pwm: Add core
> > > infrastructure to allow atomic updates") because the ->set_polarity()
> > > hook was called no matter the current polarity state, but this is no =
longer
> > > the case.
> > >=20
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Fixes: 42e8992c58d4 ("pwm: Add core infrastructure to allow atomic up=
dates") =20
> >=20
> > That's not technically correct, because it's the driver that has the
> > bug. The core change merely exposes it. How about if I sort this into
> > the pwm-atomic branch and reword the commit message accordingly? That
> > way things should all stay bisectible.
>=20
> I don't see this change in your branch. Do you want me to resend this
> fix after reworking the commit message?

I must have forgotten about it. I've applied it to my fixes branch now,
for which I plan on sending a pull request tomorrow.

Thierry

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXX8aGAAoJEN0jrNd/PrOhXSgP/0NqhhNEtUDK6c3skINlzVYv
oF9NI786gAoZN+lD9FWspjPQM4qh0LmtlHCyQAA4/aEGVIAyuEPzzbcWcWrFbGL7
ySOo5hbdDL+sonrdrOmx11B39HAewYIilFqzzGzYTaAXfe1756JHSFrYqLy5+mQu
/gdIViEXpIaLUTJNJfMeaptb0Kj0afYoM93T+8AF8JSmv+huxxV+8spFpkg4SCTc
2fdEilWib7kAGpEUWSNgBsVrJNC3J/aA8jMuOBzBel1JUjVj22JGaJ7nyurvVV50
0KadyctVlDkWoeynXtfBU2TE6qmvbSJqHLsq6/QEf8NJuI2TS6CbAyaLVUf++lwi
vdvxQyDq8eTxwzkoTiV9TbHPmxxo45oYTb3W5FiQtmmP7JWEFM0ef35wIqbAIgws
ATCKB2kVY3YXtGa7gxoxRACXMnDN8MXGh2Wy3blJFhV4iteyx0pmX+59unU+DW7y
AqGjBgRKzXxLQkGjPe2y3zyd1Ji9T9obX6E+12/QVnhTFNBe2buGt/5pQZ+pVT43
zhsJD/tjeICgnoLshNETbtnXAbkA9d8pIGbq33rwdLPAgij+r9+8ZDjcpVxGE4Iv
WDds/xq++ZOBf15dayTfx9z4InULNxKqKT4eynYXKnRRmuVr3LgtSfhUg4sG/pJq
pqkxVJbzZS/M+TMit6ug
=h5OO
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
