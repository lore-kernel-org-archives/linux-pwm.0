From: Roy Im <roy.im.opensource@diasemi.com>
Subject: RE: [PATCH V10 3/3] Input: new da7280 haptic driver
Date: Wed, 11 Mar 2020 10:15:06 +0000
Message-ID: <VE1PR10MB3085C1E1B24EF93BA13DCB6285FC0@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1583425388.git.Roy.Im@diasemi.com>
 <fd7066d21e994de56b331d9320f9671356fac408.1583425388.git.Roy.Im@diasemi.com>
 <20200306070544.7rj5y44e23kiz65e@pengutronix.de>
 <VE1PR10MB30852BA3A8166D475940694985E30@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <VE1PR10MB30852BA3A8166D475940694985E30@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


Friday, Mar 06, 2020 at 4:06 PM, Uwe Kleine-K=F6nig wrote
> On Fri, Mar 06, 2020 at 01:23:08AM +0900, Roy Im wrote:
> > +static int da7280_haptic_set_pwm(struct da7280_haptic *haptics,=20
> > +bool
> > +enabled) {
> > +	struct pwm_state state;
> > +	u64 period_mag_multi;
> > +	int error;
> > +
> > +	if (!haptics->gain) {
> > +		dev_err(haptics->dev,
> > +			"Please set the gain first for the pwm mode\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	pwm_get_state(haptics->pwm_dev, &state);
> > +	state.enabled =3D enabled;
> > +	if (enabled) {
> > +		period_mag_multi =3D state.period * haptics->gain;
> > +		period_mag_multi >>=3D MAX_MAGNITUDE_SHIFT;
> > +
> > +		/* The interpretation of duty cycle depends on the acc_en,
> > +		 * it should be form 50% to 100% for acc_en =3D 0.
>=20
> At least s/form/from/, but maybe better: it should be between 50% and 100=
% ...
Okay, got it and sorry for the typo, I will update as you advise..

> > +		 * See datasheet 'PWM mode' section.
> > +		 */
> > +		if (!haptics->acc_en) {
> > +			period_mag_multi +=3D state.period;
> > +			period_mag_multi /=3D 2;
> > +		}
> > +
> > +		state.duty_cycle  =3D (unsigned int)period_mag_multi;
>=20
> This cast is not needed. (Also it seems struct pwm_state::duty_cycle=20
> becomes u64 soon, after this happens the cast even
> hurts.)
Okay, I will remove the cast.

> > [...]
> > +	struct device *dev =3D &client->dev;
> > +	struct da7280_haptic *haptics;
> > +	struct input_dev *input_dev;
> > +	struct ff_device *ff;
> > +	struct pwm_state state;
> > +	unsigned int period2freq;
> > +	int error;
> > +
> > +	haptics =3D devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
> > +	if (!haptics)
> > +		return -ENOMEM;
> > +	haptics->dev =3D dev;
> > +
> > +	if (!client->irq) {
> > +		dev_err(dev, "No IRQ configured\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	da7280_parse_properties(dev, haptics);
> > +
> > +	if (haptics->const_op_mode =3D=3D DA7280_PWM_MODE) {
> > +		haptics->pwm_dev =3D devm_pwm_get(dev, NULL);
> > +		if (IS_ERR(haptics->pwm_dev)) {
> > +			dev_err(dev, "failed to get PWM device\n");
>=20
> Please use %pE to show the actual error and don't print if it is EPROBE_D=
EFER.
Okay, I will change as following:
		if (IS_ERR(haptics->pwm_dev)) {
			error =3D PTR_ERR(haptics->pwm_dev);
			if (error !=3D -EPROBE_DEFER)
				dev_err(dev, "unable to request PWM: %pE\n",
					ERR_PTR(error));
			return error;
		}
Do you still see anything on this changes?

> > +			return PTR_ERR(haptics->pwm_dev);
> > +		}
> > +
> > +		pwm_init_state(haptics->pwm_dev, &state);
> > +		state.enabled =3D false;
>=20
> This usuage is strange (which might be because pwm_init_state() is=20
> strange). I assume the goal here is to disable the PWM with the right=20
> polarity set, right? Ah, and initialize .period as this isn't touched lat=
er on. Hmm, no better idea, I guess we have to leave it as is for now.
Yes, that's right. I think so.

> Can it be that the PWM is already on at probe time and it might be useful=
l to keep it running as is?

I don't think it can be that the PWM is already on at probe time but it wou=
ld be useful to ensure that it is off.
Also I will add this comments on the pwm_init_state():

	/* Sync up PWM state and ensure it is off. */
	pwm_init_state(haptics->pwm_dev, &state);

Do you have any comments more on this?

> > +		error =3D pwm_apply_state(haptics->pwm_dev, &state);
> > +		if (error) {
> > +			dev_err(dev,
> > +				"failed to apply initial PWM state: %pE\n",
> > +				ERR_PTR(error));
> > +			return error;
> > +		}
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Hello Uwe,

Thanks for your comments.

Kind regards,
Roy
