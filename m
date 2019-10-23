Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40729 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731524AbfJWHX1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Oct 2019 03:23:27 -0400
Date: Wed, 23 Oct 2019 09:23:04 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20191023072304.7qmw4skssfm7iykm@pengutronix.de>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-6-git-send-email-jeff@labundy.com>
 <20191021073419.27r4xjqpz2wswerj@pengutronix.de>
 <20191022043649.GB2091@labundy.com>
 <20191022065415.2zxmpbsmogvgul7x@pengutronix.de>
 <20191023024525.GC3233@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191023024525.GC3233@labundy.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 5/8] pwm: Add support for Azoteq IQS620A PWM generator
To: Jeff LaBundy <jeff@labundy.com>
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com, linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com

Hello Jeff,

On Tue, Oct 22, 2019 at 09:45:25PM -0500, Jeff LaBundy wrote:
> On Tue, Oct 22, 2019 at 08:54:15AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Oct 21, 2019 at 11:36:49PM -0500, Jeff LaBundy wrote:
> > > On Mon, Oct 21, 2019 at 09:34:19AM +0200, Uwe Kleine-K=F6nig wrote:
> > > > > +{
> > > > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > > > +	struct iqs62x_core *iqs62x;
> > > > > +	int error;
> > > > > +	int duty_calc =3D state->duty_cycle * 256 / IQS620_PWM_PERIOD_N=
S - 1;
> > > > > +	u8 duty_clamp =3D clamp(duty_calc, 0, 0xFF);
> >=20
> > Another problem that we have here is that the period is fixed to 1 ms
> > and if a consumer requests for example:
> >=20
> > 	.period =3D 5000000,
> > 	.duty_cycle =3D 1000000,
> >=20
> > the hardware is actually configured for
> >=20
> > 	.period =3D 1000000,
> > 	.duty_cycle =3D 1000000,
> >=20
> > . I don't have a good suggestion how to fix this. We'd need to
> > draw a line somewhere and decline a request that is too far from the
> > result. But where this line should be is not obvious, it should
> > definitively not be implemented in the driver itself IMHO.
> >=20
> > (The only halfway sane approach would be to let lowlevel drivers
> > implement a .round_state callback and then let the framework judge. But
> > we're a long way from having that, so that's not a solution for today.)
> >=20
>=20
> Agreed on all counts. For now, I will mention in the 'Limitations' headin=
g that
> the period cannot be adjusted.

Ack. My longterm plan is to require .apply_state() to round down both
.period and .duty_cycle. This isn't wrong already today, so I suggest
you decline a request to set the period to something smaller than 1 ms
with an error code. (I think most drivers use -EINVAL here, conceptually
-EDOM might be sensible. I'd stick to EINVAL for now.)

> > > > > +	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, ch=
ip);
> > > > > +	iqs62x =3D iqs620_pwm->iqs62x;
> > > > > +
> > > > > +	error =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE, duty=
_clamp);
> > > > > +	if (error)
> > > > > +		return error;
> > > > > +
> > > > > +	state->period =3D IQS620_PWM_PERIOD_NS;
> > > > > +	state->duty_cycle =3D (duty_clamp + 1) * IQS620_PWM_PERIOD_NS /=
 256;
> > > >=20
> > > > This suggests that if the value in the IQS620_PWM_DUTY_CYCLE is 0 t=
he
> > > > duty cycle is 1/256 ms with a period of 1 ms and the output cannot =
be
> > > > constant inactive. If this is right please add a paragraph in the
> > > > driver's comment at the top:
> > > >=20
> > > > 	* Limitations:
> > > > 	* - The hardware cannot generate a 0% duty cycle
> > > >=20
> > > > (Please stick to this format, other drivers use it, too.)
> > >=20
> > > That's correct; the lowest duty cycle that can be achieved using only=
 the
> > > IQS620_PWM_DUTY_CYCLE register is 0.4%. We can, however, generate 0% =
duty
> > > cycle by disabling the output altogether using a separate register. W=
ould
> > > that be better than flat-out saying it's impossible?
> >=20
> > There is (maybe) a small difference between disabled and 0% duty cycle,
> > at least from the framework's POV: If you do:
> >=20
> > 	pwm_apply_state(pwm, { .enabled =3D true, .period =3D 1000000, .duty_c=
ycle =3D 1000000, });
> > 	pwm_apply_state(pwm, { .enabled =3D false, .period =3D $DC, .duty_cycl=
e =3D $DC, });
> > 	pwm_apply_state(pwm, { .enabled =3D true, .period =3D 1000000, .duty_c=
ycle =3D 1000000, });
> >=20
> > and compare it to the expected result of
> >=20
> > 	pwm_apply_state(pwm, { .enabled =3D true, .period =3D 1000000, .duty_c=
ycle =3D 1000000, });
> > 	pwm_apply_state(pwm, { .enabled =3D true, .period =3D 1000000, .duty_c=
ycle =3D 0, });
> > 	pwm_apply_state(pwm, { .enabled =3D true, .period =3D 1000000, .duty_c=
ycle =3D 1000000, });
> >=20
> > the difference is that the duration of the inactive phase in the latter
> > case is a multiple of 1 ms.
> >=20
> > There is no policy for lowlevel drivers what to do, but disabling when
> > 0% is requested is at least not unseen and probably more what consumers
> > expect.
> >=20
>=20
> With the change I am proposing, the output will be driven to zero if enab=
led =3D false
> OR duty_cycle < 4000 ns. Stated another way:
>=20
> enable duty_cycle IQS620_PWR_SETTINGS[7] IQS620_PWM_DUTY_CYCLE
> ------ ---------- ---------------------- ---------------------
>   0    don't care           0                  don't care
>   1    0 ... 3999           0                  don't care
>   1    4000 ... x           1                      0
>   1    x+1  ... y           1                      1
>=20
> ...and so on. For context, if IQS620_PWR_SETTINGS[7] =3D 0 then the outpu=
t is held to
> zero. If IQS620_PWR_SETTINGS[7] =3D 1 then the output toggles at a duty c=
ycle between
> 0.4% and 100% as a function of IQS620_PWM_DUTY_CYCLE.

Your table isn't accurate. IQS620_PWM_DUTY_CYCLE=3D0 results in a
duty_cycle of 3906.25 ns so the table should look as follows:

enable  duty_cycle  IQS620_PWR_SETTINGS[7] IQS620_PWM_DUTY_CYCLE
------ ------------ ---------------------- ---------------------
  0     don't care           0                  don't care
  1       [0, 3906]          0                  don't care
  1    [3907, 7812]          1                      0
  1    [7813,11718]          1                      1

In general:

	dc =3D state->duty_cycle * 256 / 1000000
	if state->enabled =3D=3D false or dc =3D=3D 0:
	    IQS620_PWR_SETTINGS[7] =3D 0

	else:
	    IQS620_PWM_DUTY_CYCLE =3D min(dc - 1, 0xff)
	    IQS620_PWR_SETTINGS[7] =3D 1

> Based on how the device behaves in response to its two available
> registers, I think your two examples will appear equal, but please let
> me know if I have understood.

Yeah, that's the expectation.

With the rounding as I suggested above this yields strange effects like
if

	.period =3D 1 s, .duty_cycle =3D 0.5 s

is requested you end up in

	.period =3D 1 ms, .duty_cycle =3D 1 ms

but I think there is nothing we can reasonably do about this.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
