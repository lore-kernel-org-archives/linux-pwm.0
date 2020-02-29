From: Roy Im <roy.im.opensource@diasemi.com>
Subject: RE: [PATCH V9 3/3] Input: new da7280 haptic driver
Date: Sat, 29 Feb 2020 00:59:20 +0000
Message-ID: <VE1PR10MB30859CB04A6F9DB58D921F7485E90@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1582270025.git.Roy.Im@diasemi.com>
 <1569958274d409298695cf86184c7b67aaf19bef.1582270025.git.Roy.Im@diasemi.com>
 <20200226161307.6tv5q2yh62cp7vk6@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20200226161307.6tv5q2yh62cp7vk6@pengutronix.de>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Roy Im <roy.im.opensource@diasemi.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Thursday, Feb 27, 2020 at 1:13 AM, Uwe Kleine-K=F6nig wrote:=20

> On Fri, Feb 21, 2020 at 04:27:05PM +0900, Roy Im wrote:
> > Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with multiple
> > mode and integrated waveform memory and wideband support.
> > It communicates via an I2C bus to the device.
> >
> > Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> >
> > ---
> > v9:
> > 	- Removed the header file and put the definitions into the c file.
> > 	- Updated the pwm code and error logs with %pE
> > +
> > +struct da7280_haptic {
> > +	struct regmap *regmap;
> > +	struct input_dev *input_dev;
> > +	struct device *dev;
> > +	struct i2c_client *client;
> > +	struct pwm_device *pwm_dev;
> > +
> > +	bool legacy;
> > +	int pwm_id;
>=20
> pwm_id is unused?

Okay, I will remove this.

[...]
> > +static int da7280_haptic_set_pwm(struct da7280_haptic *haptics, bool
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
> > +	period_mag_multi =3D enabled ? state.period * haptics->gain : 0;
>=20
> if .enabled is false .duty_cycle has no effect on the output. So there is=
 no good reason for setting the duty_cyle to
> something different for a disabled PWM.

Okay, I will add a condition for this.

> > +	state.duty_cycle  =3D (haptics->acc_en) ?
> > +		(unsigned int)(period_mag_multi >> 15) :
> > +		(unsigned int)((period_mag_multi >> 15)
> > +			+ state.period) / 2;
>=20
> This can be written in a more readable way:
>=20
> 	/* would be great to have a symbolic name for 15 */
> 	period_mag_multi >>=3D 15;
>=20
> 	/* comment with a rational here */
> 	if (!haptics->acc_en) {
> 		period_mag_multi +=3D state.period;
> 		period_mag_multi /=3D 2;
> 	}
>=20
> 	state.duty_cycle =3D period_mag_multi;

Okay, thanks. I have tried to update that as below.
Could I get your comment if you still see anything on this?

	/* Maximum gain is 0x7fff for PWM mode */
	#define MAX_MAGNITUDE_SHIFT		15
       [...]
	period_mag_multi >>=3D MAX_MAGNITUDE_SHIFT;

	/* The interpretation of duty cycle depends on the acc_en,
	* it should be from 50% to 100% for acc_en =3D 0.
	* See datasheet 'PWM mode' section for more details.
	*/
	if (!haptics->acc_en) {
		period_mag_multi +=3D state.period;
		period_mag_multi /=3D 2;
	}

> > [...]
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
> > +		period2freq =3D 1000000 / pwm_get_period(haptics->pwm_dev);
>=20
> You already know the return value of pwm_get_period(), it's state.period.

Right, I will replace that to state.period.

> > +		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> > +		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> > [...]
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Hi Uwe,

Thanks a lot for your comments.

Best regards,
Roy
