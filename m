From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [RFC PATCH 04/10] mfd: Add base driver for Netronix embedded
 controller
Date: Sun, 28 Jun 2020 10:29:06 +0200
Message-ID: <20200628082906.GB2561@latitude>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
 <20200620224222.1312520-3-j.neuschaefer@gmx.net>
 <20200627101738.2fe4abc3@aktux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200627101738.2fe4abc3@aktux>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko.stuebner-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2020 at 10:17:38AM +0200, Andreas Kemnade wrote:
> On Sun, 21 Jun 2020 00:42:15 +0200
> Jonathan Neusch=C3=A4fer <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org> wrote:
>=20
> > Third-party hardware documentation is available at
> > https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-cont=
roller
> >=20
> > The EC supports interrupts, but the driver doesn't make use of them so
> > far.
> >=20
> > Known problems:
> > - The reboot handler is installed in such a way that it directly calls
> >   into the i2c subsystem to send the reboot command to the EC. This
> >   means that the reboot handler may sleep, which is not allowed.
> >=20
> see
> https://patchwork.ozlabs.org/project/linux-i2c/patch/20190415213432.8972-=
3-contact-FE0fJ5eluzM67TsDOn+PKw@public.gmane.org/
>=20
> for a fix of such problems.=20

So far, regmap isn't involved here, but I'll remember it when I switch
to regmap.

Between when I first wrote this driver and now, the I2C has added
support for transfers in atomic contexts very late in the system's life
(exactly what happens when you reset a system via PMIC/EC), so this
problem seems to be gone from my driver, for now.
(See commit 63b96983a5ddf ("i2c: core: introduce callbacks for atomic trans=
fers"))


[...]
> > +int ntxec_write8(struct ntxec *ec, u8 addr, u8 value)
> > +{
> > +	return ntxec_write16(ec, addr, value << 8);
> > +}
> > +EXPORT_SYMBOL(ntxec_write8);
> > +
>=20
> do we really need both 16bit and 8bit accessors?

No, the hardware/firmware doesn't care.

> If not, then simply use regmap_i2c_init and set val_bits accordingly.
> Maybe just doing the << 8 in the constants?

Thanks, I'll try this approach.

The values are not always constants, for example in the PWM driver:

	res |=3D ntxec_write8(pwm->ec, NTXEC_PERIOD_HIGH, period >> 8);
	res |=3D ntxec_write8(pwm->ec, NTXEC_PERIOD_LOW, period);
	res |=3D ntxec_write8(pwm->ec, NTXEC_DUTY_HIGH, duty >> 8);
	res |=3D ntxec_write8(pwm->ec, NTXEC_DUTY_LOW, duty);


Jonathan

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl74VL8ACgkQCDBEmo7z
X9vsEg//cjP0FgATqceA5CjhLzEVJxxLCujFQN03O2AvzBf5EdlAzS+Rbl8vmTqw
aGm+JAhI0gHbQgTni2UFe58LXIjCY6PG1weU2Zge52QLRIFsfKnh2qz9sAJUPBXD
vrJOSTrlxBy7j4kAg4vsWpo1y0a+hg7NVzaV4VLtnhb7iEPjnbjgupi28gx2ak/P
gJrVyIJOLMiHAOpJe+TiZPVUphklEBC/tLOZkq70vw6PElkemNNC9ajufmf2V+D6
kItW8NNCiOVXC6+1tklpoZlyttCPfVVv8XpTk+KtjEIghryk6aGbDxxD1HNOAUyz
TqgtqsDwJh7Wr6YC6cDsiwD9YAzg2MvtplzHaOYpOEeXRT2ZjUxtz4MJ5YdxaXfl
QApB1HpUzZvAECUOO4tRR+Olq1rB4y3g3pjn+NEH7XtKZiokxtT/8iCvcHIkIwLG
LFiQ7E2Lha6nprVbGyiCG1l3uz8FZtqdrHzXxeVkkMvvFDSWXSNWKGogw6/SNGTc
vB8tkxixvppfKlbS2j4kBXe1griaqSFPC6epS9VT1NpNGecekg+5M+6OEm+LTq+v
XI4kTNYHd9GacgNzLbSQG3p0nNg6YGdyYXXID5jArsVOPbRThclnNLDajEQ9r2IZ
3DAjcL/TTRxwmCiAFAoNMVRnBvGOxyrWJ5YuLslonkne5i2lAFE=
=7+bu
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
