From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: Is PWM subsystem maintainable?
Date: Mon, 16 Jan 2017 22:58:51 +0100
Message-ID: <20170116215851.GA18142@ulmo.ba.sec>
References: <CAHp75Vc1ksvru8sY_Sj4dgNMsyL5rfjWuz3JeuBDWJkd4Re90A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34595 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbdAPV6z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Jan 2017 16:58:55 -0500
Content-Disposition: inline
In-Reply-To: <CAHp75Vc1ksvru8sY_Sj4dgNMsyL5rfjWuz3JeuBDWJkd4Re90A@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2017 at 04:50:45PM +0200, Andy Shevchenko wrote:
> Hi!
>=20
> I'm really puzzled. Do we have a maintainer for PWM subsystem? Is he
> responsive?

Oh, I'm around, just having a streak of bad luck since early December
and therefore more busy with real life than I'd like.

> We sent already two series (1 + 4) of patches regarding to two
> different drivers and not a single patch has been commented and / or
> applied for *months*. One more had been sent week or so ago.
>=20
> For our uncountable pings we didn't receive any word on what's going on.
> If there is any trouble with patches we would really eager to fix them.

I'm aware of your patches and I plan on applying them for v4.11, I just
need to find a large enough slot to apply, test build and push.

"Uncountable" is maybe a little strong, though.

Thierry

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh9QhsACgkQ3SOs138+
s6FySRAAvB5QsMvzruG1tMchPyZteQeGTJdakZaolevRkiI9k6oCkkTwOAHCFb6O
F4g5yqivtlzYTKLlAoRANINNXzndG9Kjlx4JUiLQD9l+inxSKqZjTKWDcBg+qUAN
jIWQFE9K664oyGNoiqZEhEZ53KspOxWROdvNAfaazfGjSYarUOYPuzSU26coSfFv
AEXzZFYuw+uM//BW4vZbg7+/MnO3bSAW4U5myD3Dln7E5qCSO66MnQ0uVmSLHbZM
ahC83LtAtm0+dWD6NMZVriDAD1tRlEhj8atD/wxQfp6LOmFP7QjaofHrv5ZR20tz
hePdGuUVxXOpFJ2XhDmjTpa2BX/LkwQc0g2EalDu+zH4y1D4N4ubSMLNXum4k16O
7Q8eeuyt2m0iC1QF6aCQOsTywVjuQtK2407MNjuzzxSF7f77of1iALEAkilao9Ox
SeZbaprMlb65Lcf4YTE0L39ZuY0K9FD7jpWh0Si6CqHjukT4FHYvFR/G4bAWpOs7
HURdwWA6y4UEv9TD/j9oBDvENP/5LwW6rF5i2kqquORgDticuziw4+FegFomX2Nx
pfSVUthYAnw/QhtOjJNXWtaGmALZt5SLav4yd2VGc/sVeJmnkQv0UR6ZKJ2LGe/l
e0xgrVYLlTO4zFEA/Xnrr5s+qDK0JCyizXyGx8W7PE4o+GXHMRI=
=/c9h
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
