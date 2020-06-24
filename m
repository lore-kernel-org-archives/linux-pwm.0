From: Roy Im <roy.im.opensource@diasemi.com>
Subject: RE: [RESEND PATCH V13 3/3] Input: new da7280 haptic driver
Date: Wed, 24 Jun 2020 12:04:24 +0000
Message-ID: <DB8PR10MB3356697B41C0FB97F5FD330185950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1592221223.git.Roy.Im@diasemi.com>
 <135761fd309eb9424faeb631b6e6c66147b57666.1592221223.git.Roy.Im@diasemi.com>
 <20200623144105.mxhcrtezbghjb2vb@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20200623144105.mxhcrtezbghjb2vb@taurus.defre.kleine-koenig.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Roy Im <roy.im.opensource@diasemi.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hello Uwe,

On Tue, June 23, 2020 11:41 PM, Uwe Kleine-K=F6nig wrote:
>=20
> Hello,
>=20
> On Mon, Jun 15, 2020 at 08:40:23PM +0900, Roy Im wrote:
> > Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with multiple
> > mode and integrated waveform memory and wideband support.
> > It communicates via an I2C bus to the device.
> >
> > Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
>=20
> Just some picky comments below.
>=20
> > +	error =3D pwm_apply_state(haptics->pwm_dev, &state);
> > +	if (error)
> > +		dev_err(haptics->dev,
> > +			"failed to apply pwm state: %pE\n",
> > +			ERR_PTR(error));
>=20
> You can save some horizontal space here by dropping the \n after the firs=
t comma. (There are a few more occurences.)
>=20
Ok, is this what you want?
	error =3D pwm_apply_state(haptics->pwm_dev, &state);
	if (error)
		dev_err(haptics->dev, "failed to apply pwm state: %pE\n",
			ERR_PTR(error));

> > +	return error;
> > +}
> > +[...]
> > +
> > +		/* Sync up PWM state and ensure it is off. */
> > +		pwm_init_state(haptics->pwm_dev, &state);
> > +		state.enabled =3D false;
> > +		error =3D pwm_apply_state(haptics->pwm_dev, &state);
> > +		if (error) {
> > +			dev_err(dev,
> > +				"failed to apply initial PWM state: %pE\n",
> > +				ERR_PTR(error));
> > +			return error;
> > +		}
> > +
> > +		/* Check PWM Period, it must be in 10k ~ 250kHz */
>=20
> The unit of a PWM period is in (nano)seconds, to it cannot be in the rang=
e [10kHz, 250kHz]. (Is this too picky?)

No, it isn't. The 'Period' should be changed to 'frequency', I will fix thi=
s as below.

		/* Check PWM frequency, valid range: 10k ~ 250kHz */

>=20
> > +		period2freq =3D 1000000 / state.period;
> > +		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> > +		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> > +			dev_err(dev, "Not supported PWM frequency(%d)\n",
> > +				period2freq);
>=20
> Doesn't the compiler warn here about period2freq being unsigned and %d be=
ing for signed int values?
>=20
> For my (non-native) English ear s/Not supported/Unsupported/ sounds bette=
r. Also my eyes would be pleases by a space
> before the opening brace.

I didn't see any warning message, but I will change/improve them to proper =
one and the log as below.

		period2freq =3D 1000000 / state.period;
		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
			dev_err(dev, "Unsupported PWM frequency (%u)\n",
				period2freq);
			return -EINVAL;
		}
If you look ok, let me update this so.

>=20
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +
> > +[...]
> > +static struct i2c_driver da7280_driver =3D {
> > +	.driver	=3D {
> > +		.name		=3D "da7280",
> > +		.of_match_table	=3D of_match_ptr(da7280_of_match),
> > +		.pm		=3D &da7280_pm_ops,
>=20
> I don't like alignment of =3D, but I'm aware this is a subjective thing.
> (The reason for me is that adding a new member that is longer than the al=
ready existing requires touching all lines. So I
> stick to a single space before a =3D.)

OK, I will do as you said.

>=20
> > +	},
> > +	.probe	  =3D da7280_probe,
> > +	.id_table =3D da7280_i2c_id,
> > +};
> > +module_i2c_driver(da7280_driver);
> > +
> > +MODULE_DESCRIPTION("DA7280 haptics driver"); MODULE_AUTHOR("Roy Im
> > +<Roy.Im.Opensource@diasemi.com>");
> > +MODULE_LICENSE("GPL");
> > --
> > end-of-patch for RESEND PATCH V13
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
