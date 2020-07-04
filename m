From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [RFC PATCH 00/10] Netronix embedded controller driver for Kobo
 and Tolino ebook readers
Date: Sat, 4 Jul 2020 22:58:08 +0200
Message-ID: <20200704205808.GD2578@latitude>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
 <20200630084051.66feadea@aktux>
 <20200630071523.GA2983@latitude>
 <20200630221447.3e03ae28@aktux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200630221447.3e03ae28@aktux>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko.stuebner-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 10:14:47PM +0200, Andreas Kemnade wrote:
> On Tue, 30 Jun 2020 09:15:23 +0200
> Jonathan Neusch=C3=A4fer <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org> wrote:
>=20
> > On Tue, Jun 30, 2020 at 08:40:51AM +0200, Andreas Kemnade wrote:
> > [...]
> > > got a chance to test it on a Tolino Shine 2 HD.
> > > It uses the RTC from the RC5T619 but backlight seems to go via MSP430
> > > EC.
> > >=20
> > > I got this.
> > >=20
> > > [    1.453603] ntxec 0-0043: Netronix embedded controller version f11=
0 detected.
> > > [   10.723638] ntxec-rtc 21a0000.i2c:embedded-controller@43:rtc: regi=
stered as rtc0
> > > [   10.775276] ntxec-pwm: probe of 21a0000.i2c:embedded-controller@43=
:pwm failed with error -5 =20
> >=20
> > Hmm, -EIO from the PWM driver.
> >=20
> turing debugging on:

(edited for compactness:)
> [  330.332971] i2c i2c-0: write slave address: addr=3D0x86   ACK received
> [  330.334420] i2c i2c-0: write byte: B0=3D0xA3              ACK received
> [  330.334790] i2c i2c-0: write byte: B1=3D0x0               No ACK

> [  330.352339] i2c i2c-0: write slave address: addr=3D0x86   ACK received
> [  330.362208] i2c i2c-0: write byte: B0=3D0xA1              ACK received
> [  330.362479] i2c i2c-0: write byte: B1=3D0xFF              No ACK

> [  330.363112] i2c i2c-0: write slave address: addr=3D0x86   ACK received
> [  330.363362] i2c i2c-0: write byte: B0=3D0xA2              ACK received
> [  330.363608] i2c i2c-0: write byte: B1=3D0xFF              No ACK

Hmm, it doesn't ack the writes to 0xA3, 0xA1 and 0xA2, which should
disable the PWM output and then disable the auto-off timer (according to
the vendor kernel).

And you said in your other mail that you can actually toggle the light
with writes to 0xA3, so I suspect a bug in the EC firmware here (which
may have gone unnoticed because the vendor kernel doesn't check if the
i2c transfers succeed). :/

IMHO we should get this driver merged first, and perhaps add a quirk to
deal with the missing ACKs later (unless a better solution is found).


Jonathan

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl8A7VcACgkQCDBEmo7z
X9vtUBAApZaMG6edUQzNMvP9gVMXHNm96Rk1KQowxkW4xF6zOnil/x4PcUwgqfKV
tA1xaZMavflayrHqj1wKuLPWnrJ1xdulK/PnULdnXalCJSVqGHjwyKf3/+onibzr
o6rS+U9ToxbkTeTdV8DjcGz2qmNeJjpaExuZTlvXHQxH7a6SUwK23JVuiChwe2M3
ycD3RQp/jvAOEW4+e/y6iGat1skMV+dUglcitX6pYBoYu8u4FoSfZ3v/O6JTqqS3
IeLfBc0IMjGuYbEn+RRkHbnLTNidHt+ptsNl6Q+p7eaRGCeGXIaCeeFPbBp1LXMf
C559niYKdWD+MQV6diLUHGMO5s4WrQiQ/qP4K+R9qQHKXyD84XYPXJX+QO+up2qb
jDyutjtILNt5YFUKNbvimcWy/rlDa1sdVaFK8Dt9o0zdkT25FATE8SU0eRFwf396
vqwWeGF2b9mNRPzWzbpQYhEDvIR+OCuDfi085F0sYtBuPBY1vcy4mbVDjDGU0ulT
T90dH/DU7C7DJwA7w6sxeb+8MZ5VGTHLsGZ+tB84pMaKJOlvTdRLD7J1+aUpqBmh
BiSTJlIZeiiR04ip4vNYgsuHM79LlEapJuhJbYLMk3oBWtRAkrToyZEjWTDfp3Ik
JzLHmXz38TYOeGG7A2vWQTIQb1eAw9Alh4Gu2OdzWW0fmR8NWCI=
=5RFu
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
