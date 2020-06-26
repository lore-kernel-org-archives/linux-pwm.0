From: Roy Im <roy.im.opensource@diasemi.com>
Subject: RE: [PATCH v14 3/3] Input: new da7280 haptic driver
Date: Fri, 26 Jun 2020 13:17:29 +0000
Message-ID: <DB8PR10MB33563278561DFC2E50420F1C85930@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1593017969.git.Roy.Im@diasemi.com>
 <8b05f5bd46eac415c628e965f59b2b57aff86bbe.1593017969.git.Roy.Im@diasemi.com>
 <20200626061853.hyb7dwta6ths2qo2@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20200626061853.hyb7dwta6ths2qo2@taurus.defre.kleine-koenig.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Roy Im <roy.im.opensource@diasemi.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

> On Fri, June 26, 2020 3:19 PM, Uwe Kleine-K=F6nig wrote:
> Hello,
> from the PWM POV I'm happy now. Just a few minor comments that I noticed =
while checking the PWM details.

Many thanks for your comments.

>=20
> On Thu, Jun 25, 2020 at 01:59:29AM +0900, Roy Im wrote:
> > +		val =3D haptics->ps_seq_id << DA7280_PS_SEQ_ID_SHIFT |
> > +			haptics->ps_seq_loop << DA7280_PS_SEQ_LOOP_SHIFT;
>=20
> If you write this as:
>=20
> 	val =3D FIELD_PREP(DA7280_PS_SEQ_ID_MASK, haptics->ps_seq_id) |
> 		FIELD_PREP(DA7280_PS_SEQ_LOOP_MASK, haptics->ps_seq_loop);
>=20
> you get some additional checks for free and can drop all defines for ..._=
SHIFT .

It is not difficult to update that as you advise, but I think having the sh=
ift there explicitly makes it more readable, so most of the drivers from my=
 team have the defines(shift) up to now. I guess this is a kind of subjecti=
ve thing.=20
Do you think it is still necessary? Then I will update as you said.

>=20
> > +static u8 da7280_haptic_of_gpi_pol_str(struct device *dev,
> > +				       const char *str)
> > +{
> > +	if (!strcmp(str, "Rising-edge"))
> > +		return 0;
> > +	else if (!strcmp(str, "Falling-edge"))
> > +		return 1;
> > +	else if (!strcmp(str, "Both-edge"))
> > +		return 2;
> > +
> > +	dev_warn(dev, "Invalid string - set to default\n");
>=20
> Maybe mention "Rising-edge" being the default?

OK, I will change them to be clear.

>=20
> > +	return 0;
> > +}
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
