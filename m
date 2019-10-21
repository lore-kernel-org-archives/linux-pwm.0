Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54909 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfJUOR1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 10:17:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so13549661wmp.4
        for <linux-pwm@vger.kernel.org>; Mon, 21 Oct 2019 07:17:25 -0700 (PDT)
Date: Mon, 21 Oct 2019 16:17:21 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20191021141721.GA1476994@ulmo>
References: <20191021105830.1357795-1-thierry.reding@gmail.com>
 <20191021111847.c5j4qycyqy5wmynh@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20191021111847.c5j4qycyqy5wmynh@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH] Revert "pwm: Let pwm_get_state() return the last
 implemented state"
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pwm@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 01:18:47PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Oct 21, 2019 at 12:58:30PM +0200, Thierry Reding wrote:
> > It turns out that commit 01ccf903edd6 ("pwm: Let pwm_get_state() return
> > the last implemented state") causes backlight failures on a number of
> > boards. The reason is that some of the drivers do not write the full
> > state through to the hardware registers, which means that ->get_state()
> > subsequently does not return the correct state. Consumers which rely on
> > pwm_get_state() returning the current state will therefore get confused
> > and subsequently try to program a bad state.
> >=20
> > Before this change can be made, existing drivers need to be more
> > carefully audited and fixed to behave as the framework expects. Until
> > then, keep the original behaviour of returning the software state that
> > was applied rather than reading the state back from hardware.
>=20
> I would really prefer to fix that in the framework instead. This is

There's nothing to fix in the framework. The framework isn't broken, the
drivers are.

> something that affects several drivers (cros-ec, imx27, atmel, imx-tpm,
> lpss, meson, sifive, sprd and stm32-lp). This is im my eyes really
> sufficient to justify a framework wide solution instead of adapting
> several drivers in a way that doesn't affect the values programmed to
> hardware.

Can you come up with a proposal for how to want to implement this in the
framework?

Thierry

> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
>=20
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Thanks
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2tve8ACgkQ3SOs138+
s6GHpw/9GYOgNp2EvuAjjsfFTHen1k1dcaxq+o0AA4va2oT+diXvqto5L6C2fpKN
S0B3dR/sSBeGdBt+vZDyW0TC4tU9ez8LtX1ia+d0bkrroF7I+Ikr2YdtC1lkGfeQ
BBt4aTqegtXOXL+rctg85q6NRvbN8zNMUvP+bho5YrO68ShjsgjUBq/wmQ+T6WP+
iMH55Y/YYDzBG+p+Lv1PAtTQ+a9EQnutSikqw2WeKIYOl9GBHvGdvPwH+Kt3gvAY
rpKNOHqKPZUkeF7e0Wcpvy+KkxNVWWOkIvn3WvOTTdOoa7uyJwXvJRAjBHxezQuz
1TKZ5Oxro+bVb/v+w1tly89ulSquLmXM6yJnQIW+i5TVBlpZH2DVnskfplmn+lNH
ObVLDgAtqZ1j51g2+ilruRQH+fkuBuws5bPZYrpxfqsZgYA2vh23TJsc2qyEwptJ
rZBTfJ0EUaxnhPiZGHQLVakLVYF0a8n1T3HN2jR7pjNXWpJOV+m5vzxCc72aVF0o
C9wyz2qJbBply2Q2+4Urnwx6cH2sFGivMqRVo+kK/2FdO9ZUVpf1KatxoZWwAsGq
pO8bwA90ONcmDLOxR8ZFCdxD+6xKHcPqIblUHWgoOFEpCumNdiJ1yeO6qyy1P9e0
dDrSKaV4hcQCdv4jLsxIhfpzAktgjB4DPrrfdKFXGJaL9+91dY4=
=9gHC
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
