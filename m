From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [RESEND PATCH V13 3/3] Input: new da7280 haptic driver
Date: Wed, 24 Jun 2020 18:28:18 +0200
Message-ID: <20200624162818.zjdtdlocxxndbsld@taurus.defre.kleine-koenig.org>
References: <cover.1592221223.git.Roy.Im@diasemi.com>
 <135761fd309eb9424faeb631b6e6c66147b57666.1592221223.git.Roy.Im@diasemi.com>
 <20200623144105.mxhcrtezbghjb2vb@taurus.defre.kleine-koenig.org>
 <DB8PR10MB3356697B41C0FB97F5FD330185950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
 <20200624133726.en7q52rpdtzvhajz@taurus.defre.kleine-koenig.org>
 <DB8PR10MB3356AFC38358881B471E76A285950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ssqstu72niiomjy3"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DB8PR10MB3356AFC38358881B471E76A285950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-input-owner@vger.kernel.org
To: Roy Im <roy.im.opensource@diasemi.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--ssqstu72niiomjy3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jun 24, 2020 at 03:39:52PM +0000, Roy Im wrote:
> On Wed, Jun 24, 2020 at 10:37 PM, Uwe Kleine-K=F6nig wrote:
> > On Wed, Jun 24, 2020 at 12:04:24PM +0900, Roy Im wrote:
> > > 		period2freq =3D 1000000 / state.period;
> > > 		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> > > 		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> > > 			dev_err(dev, "Unsupported PWM frequency (%u)\n",
> > > 				period2freq);
> > > 			return -EINVAL;
> > > 		}
> > > If you look ok, let me update this so.
> >=20
> > looks fine.
> >=20
> > Note that you don't need the division if you check for:
> >=20
> > 	if (state.period > 100000 || state.period < 4000) {
> > 		...
> >=20
> > (maybe the compiler is already clever enough to get rid of the division=
 for you, but then the check is:
> >=20
> > 	if (state.period > 100000 || state.period < 3985) {
> >=20
> > because of rounding errors.)
>=20
> OK, you are right, that will be better. So let me change that as below
> if you look fine.

I look fine, the code however is wrong. :-)

> 	/* Check PWM period, PWM freq =3D 1000000 / state.period.
> 	 * The valid PWM freq range: 10k ~ 250kHz.
> 	 */
> 	if (state.period > 100000 || state.period < 3985) {

You want 4000 here ---------------------------------^^^^, don't you?

> 		dev_err(dev, "Unsupported PWM period (%u)\n",
> 			state.period);
> 		return -EINVAL;
> 	}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ssqstu72niiomjy3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7zfx8ACgkQwfwUeK3K
7AniMQf/dBjyVOi2QoJQg3cVZrxy9KBfFrnyeVumg/hVSCwc8hsLVMbdFBRn6dkZ
FwPNz8m/VierY1+XotTGKhco99rqJOi78sBcXMBRwnEaLry7iPurnDVktCfDCeAu
LMI29s2kqKh/+3jCT/H04Vdt/a5nT7+ZEcoONf2sXqbovRKd1BE3HHvNMIO+6xTY
Rgk0wNbRTsC4U3msBGrZcrqKD3lBCTlIaWae0zDkAkrlFS590UCsJNWUoKA07WnC
waGAfJwAGHYy7jOB/iQoDbNr8n+ENEyh7kGeAlch4+4nyNKsATERH9LrvLFAFL0+
S3zijgTEyMRzyTfY4DFLqjyp98NqjA==
=Q+Ni
-----END PGP SIGNATURE-----

--ssqstu72niiomjy3--
