From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 3/6] pwm: jz4740: Apply configuration atomically
Date: Tue, 23 Jul 2019 16:46:40 -0400
Message-ID: <1563914800.1918.0@crapouillou.net>
References: <20190607154410.10633-1-paul@crapouillou.net>
        <20190607154410.10633-4-paul@crapouillou.net>
        <20190722193456.h4hfte5cczucermd@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722193456.h4hfte5cczucermd@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,



Le lun. 22 juil. 2019 =E0 15:34, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello Paul,
>=20
> On Fri, Jun 07, 2019 at 05:44:07PM +0200, Paul Cercueil wrote:
>>  -static int jz4740_pwm_config(struct pwm_chip *chip, struct=20
>> pwm_device *pwm,
>>  -			     int duty_ns, int period_ns)
>>  +static int jz4740_pwm_apply(struct pwm_chip *chip, struct=20
>> pwm_device *pwm,
>>  +			    struct pwm_state *state)
>>   {
>>   	struct jz4740_pwm_chip *jz4740 =3D to_jz4740(pwm->chip);
>>   	unsigned long long tmp;
>>   	unsigned long period, duty;
>>   	unsigned int prescaler =3D 0;
>>   	uint16_t ctrl;
>>  -	bool is_enabled;
>>=20
>>  -	tmp =3D (unsigned long long)clk_get_rate(jz4740->clk) * period_ns;
>>  +	tmp =3D (unsigned long long)clk_get_rate(jz4740->clk) *=20
>> state->period;
>>   	do_div(tmp, 1000000000);
>>   	period =3D tmp;
>>=20
>>  @@ -96,16 +95,14 @@ static int jz4740_pwm_config(struct pwm_chip=20
>> *chip, struct pwm_device *pwm,
>>   	if (prescaler =3D=3D 6)
>>   		return -EINVAL;
>>=20
>>  -	tmp =3D (unsigned long long)period * duty_ns;
>>  -	do_div(tmp, period_ns);
>>  +	tmp =3D (unsigned long long)period * state->duty_cycle;
>>  +	do_div(tmp, state->period);
>>   	duty =3D period - tmp;
>>=20
>>   	if (duty >=3D period)
>>   		duty =3D period - 1;
>>=20
>>  -	is_enabled =3D jz4740_timer_is_enabled(pwm->hwpwm);
>>  -	if (is_enabled)
>>  -		jz4740_pwm_disable(chip, pwm);
>>  +	jz4740_pwm_disable(chip, pwm);
>=20
> I assume this stops the PWM. Does this complete the currently running
> period? How does the PWM behave then? (Does it still drive the output?
> If so, on which level?)

Some PWM channels work in one mode "TCU1" and others work in "TCU2". The
mode in which channels work depends on the version of the SoC.

When stopped, the pins of TCU1 channels will be driven to the inactive
level (which depends on the polarity). It is unknown whether or not the
currently running period is completed. We set a bit to configure for
"abrupt shutdown", so I expect that it's not, but somebody would need
to hook up a logic analyzer to see what's the exact behaviour with
and without that bit.

TCU2 channels on the other hand will stop in the middle of a period,
leaving the pin hanging at whatever level it was before the stop.
That's the rationale behind the trick in commit 6580fd173070 ("pwm:
jz4740: Force TCU2 channels to return to their init level").

Regards,
-Paul


>>=20
>>   	jz4740_timer_set_count(pwm->hwpwm, 0);
>>   	jz4740_timer_set_duty(pwm->hwpwm, duty);
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |

=
