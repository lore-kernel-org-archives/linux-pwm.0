From: Roy Im <roy.im.opensource@diasemi.com>
Subject: RE: [RESEND PATCH V11 3/3] Input: new da7280 haptic driver
Date: Sat, 2 May 2020 15:32:04 +0000
Message-ID: <DB6PR1001MB1077F44B22FD486B04AF21B185A80@DB6PR1001MB1077.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1587949032.git.Roy.Im@diasemi.com>
 <eb301aa028c877a71e60dc7493ee712e4599e8d9.1587949032.git.Roy.Im@diasemi.com>
 <20200430194603.ah3ytucf3fzxrfs5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200430194603.ah3ytucf3fzxrfs5@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Roy Im <roy.im.opensource@diasemi.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

Friday, May 1, 2020 4:46 AM, Uwe Kleine-K=F6nig wrote:
> On Mon, Apr 27, 2020 at 09:57:12AM +0900, Roy Im wrote:
> > +	/* It is recommended to update the patterns
> > +	 * during haptic is not working in order to avoid conflict
> > +	 */
>=20
> I thought only in net related code the comment style is like the above an=
d in all other areas the /* is on a line for itself.

OK, I will change the comment to a line.

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
>=20
> If enabled =3D=3D false haptics->gain is unused. Does it make sense to on=
ly error out for enabled =3D=3D true?

Yes, you are right and it make sense, I will add the condition(enabled =3D=
=3D true) into that.

[...]
> > +static int da7280_probe(struct i2c_client *client,
> > +			const struct i2c_device_id *id)
> > +{
> > +	struct device *dev =3D &client->dev;
> > +	struct da7280_haptic *haptics;
> > +	struct input_dev *input_dev;
> > +	struct ff_device *ff;
> > +	struct pwm_state state;
> > +	unsigned int period2freq;
>=20
> This variable could be local to the if body below.

Ok. That would be better. I will move it below(to Here).

>=20
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
		unsigned int period2freq;
Here.

> > +		haptics->pwm_dev =3D devm_pwm_get(dev, NULL);
> > +		if (IS_ERR(haptics->pwm_dev)) {
> > [...]

> > +	error =3D devm_request_threaded_irq(dev, client->irq, NULL,
> > +					  da7280_irq_handler,
> > +					  IRQF_ONESHOT,
> > +					  "da7280-haptics", haptics);
> > +	if (error)
> > +		dev_err(dev, "Failed to request IRQ : %d\n", client->irq);
>=20
> I'd say emitting the error code would be helpful here, the actual irq num=
ber not so.

I will do so

> > +static struct i2c_driver da7280_driver =3D {
> > +	.driver		=3D {
> > +		.name	=3D "da7280",
> > +		.of_match_table =3D of_match_ptr(da7280_of_match),
> > +		.pm	=3D &da7280_pm_ops,
> > +	},
> > +	.probe	=3D da7280_probe,
> > +	.id_table	=3D da7280_i2c_id,
>=20
> Inconsistent alignment of the =3D signs. My preference is a single space =
before the equal sign, but aligning them in the same
> column is another usual style.

I will align as your preference, it looks better in this case. Thanks for y=
our comments.

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Kind regards,
Roy
