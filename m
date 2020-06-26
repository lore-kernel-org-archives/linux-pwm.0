From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v14 3/3] Input: new da7280 haptic driver
Date: Fri, 26 Jun 2020 17:56:04 +0200
Message-ID: <20200626155604.poqryunm7fyqmgek@pengutronix.de>
References: <cover.1593017969.git.Roy.Im@diasemi.com>
 <8b05f5bd46eac415c628e965f59b2b57aff86bbe.1593017969.git.Roy.Im@diasemi.com>
 <20200626061853.hyb7dwta6ths2qo2@taurus.defre.kleine-koenig.org>
 <DB8PR10MB33563278561DFC2E50420F1C85930@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5pzi4sldrmy6sm6j"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DB8PR10MB33563278561DFC2E50420F1C85930@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-input-owner@vger.kernel.org
To: Roy Im <roy.im.opensource@diasemi.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--5pzi4sldrmy6sm6j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 01:17:29PM +0000, Roy Im wrote:
> > On Fri, June 26, 2020 3:19 PM, Uwe Kleine-K=F6nig wrote:
> > Hello,
> > from the PWM POV I'm happy now. Just a few minor comments that I notice=
d while checking the PWM details.
>=20
> Many thanks for your comments.
>=20
> >=20
> > On Thu, Jun 25, 2020 at 01:59:29AM +0900, Roy Im wrote:
> > > +		val =3D haptics->ps_seq_id << DA7280_PS_SEQ_ID_SHIFT |
> > > +			haptics->ps_seq_loop << DA7280_PS_SEQ_LOOP_SHIFT;
> >=20
> > If you write this as:
> >=20
> > 	val =3D FIELD_PREP(DA7280_PS_SEQ_ID_MASK, haptics->ps_seq_id) |
> > 		FIELD_PREP(DA7280_PS_SEQ_LOOP_MASK, haptics->ps_seq_loop);
> >=20
> > you get some additional checks for free and can drop all defines for ..=
=2E_SHIFT .
>=20
> It is not difficult to update that as you advise, but I think having
> the shift there explicitly makes it more readable, so most of the
> drivers from my team have the defines(shift) up to now. I guess this
> is a kind of subjective thing.=20
> Do you think it is still necessary? Then I will update as you said.

No, from my side it's not a hard requirement (and after all I'm not the
one who will take your commit). I personally like it better with
FIELD_PREP, but I can still sleep if you don't agree :-)

What I don't like about having both ..._SHIFT and ..._MASK is that there
is some duplication as ..._SHIFT can be calculated from ..._MASK:

	#define LALA_SHIFT (ffs(LALA_MASK) - 1)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5pzi4sldrmy6sm6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl72GpEACgkQwfwUeK3K
7An3Fgf+PE90XwKk0lfI4SJm01zg8Vo94+Ws2c/C57cMSLglwYArUOdp75/yOQJe
9NsLyWB5iQ68ENFFCF9qvvEK27iZG5pBeRuJXSFAdyfEdnCGpSDsDi/VqlhjSKqO
dMjn1mcOftN8n9Zj4E8UehTsEte3nbfY+3upnRkYQW4Y12NlfJcAPQ8DdWypbJ9W
8fFMsIdZp8u+HMpSmjS+LGr9g9bBZAn+5+VgD9pfMM2oOTVhMYXYPwl6d7sBW/IV
WOeHC3vSUQ87G7EXzTV4KVo4RHwxbydEt52Gzt42Jt8iKQxEpG80hEqWx6j0RloH
8QEaDWWQGHvaGnoHwsnRXOw6TKqZdg==
=osHN
-----END PGP SIGNATURE-----

--5pzi4sldrmy6sm6j--
