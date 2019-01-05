From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v9 12/27] pwm: jz4740: Use regmap from TCU driver
Date: Sat, 05 Jan 2019 17:46:18 -0300
Message-ID: <1546721178.28727.0@crapouillou.net>
References: <20181227181319.31095-1-paul@crapouillou.net>
        <20181227181319.31095-13-paul@crapouillou.net>
        <20190105194226.pe4huzynz4civ3lm@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105194226.pe4huzynz4civ3lm@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On Sat, Jan 5, 2019 at 4:42 PM, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> wrote:
> On Thu, Dec 27, 2018 at 07:13:04PM +0100, Paul Cercueil wrote:
>>  The ingenic-timer "TCU" driver provides us with a regmap, that we=20
>> can
>>  use to safely access the TCU registers.
>>=20
>>  While this driver is devicetree-compatible, it is never (as of now)
>>  probed from devicetree, so this change does not introduce a ABI=20
>> problem
>>  with current devicetree files.
>=20
> Does it change behaviour? If so, how?

No, it does not change the behaviour.

>>  @@ -113,26 +117,37 @@ static int jz4740_pwm_apply(struct pwm_chip=20
>> *chip, struct pwm_device *pwm,
>>=20
>>   	jz4740_pwm_disable(chip, pwm);
>>=20
>>  -	jz4740_timer_set_count(pwm->hwpwm, 0);
>>  -	jz4740_timer_set_duty(pwm->hwpwm, duty);
>>  -	jz4740_timer_set_period(pwm->hwpwm, period);
>>  +	/* Set abrupt shutdown */
>>  +	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
>>  +			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
>=20
> I think I already pointed that out before: abrupt mode is wrong. If
> .apply is called with a new set of parameters the currently running
> period with the old values is expected to complete before the new=20
> values
> take effect.

You pointed it, indeed; but I won't change it until I can verify that=20
the
behaviour is correct (which does not seem to be the case even if I leave
this bit cleared). Besides, this is the TCU patchset, fixes and patches
unrelated to the TCU don't belong here.

> Best regards
> Uwe

Kind regards,
-Paul
=
