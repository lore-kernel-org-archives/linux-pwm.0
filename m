From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v9 14/27] pwm: jz4740: Improve algorithm of clock
 calculation
Date: Sat, 05 Jan 2019 18:05:38 -0300
Message-ID: <1546722339.30174.0@crapouillou.net>
References: <20181227181319.31095-1-paul@crapouillou.net>
        <20181227181319.31095-15-paul@crapouillou.net>
        <20190105195725.cuxfge6zkpbt3cyk@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105195725.cuxfge6zkpbt3cyk@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

On Sat, Jan 5, 2019 at 4:57 PM, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> wrote:
> On Thu, Dec 27, 2018 at 07:13:06PM +0100, Paul Cercueil wrote:
>>  The previous algorithm hardcoded details about how the TCU clocks=20
>> work.
>>  The new algorithm will use clk_round_rate to find the perfect clock=20
>> rate
>>  for the PWM channel.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>       v9: New patch
>>=20
>>   drivers/pwm/pwm-jz4740.c | 26 +++++++++++++++-----------
>>   1 file changed, 15 insertions(+), 11 deletions(-)
>>=20
>>  diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
>>  index c6136bd4434b..dd80a2cf6528 100644
>>  --- a/drivers/pwm/pwm-jz4740.c
>>  +++ b/drivers/pwm/pwm-jz4740.c
>>  @@ -110,23 +110,27 @@ static int jz4740_pwm_apply(struct pwm_chip=20
>> *chip, struct pwm_device *pwm,
>>   	struct jz4740_pwm_chip *jz4740 =3D to_jz4740(pwm->chip);
>>   	struct clk *clk =3D jz4740->clks[pwm->hwpwm],
>>   		   *parent_clk =3D clk_get_parent(clk);
>>  -	unsigned long rate, period, duty;
>>  +	unsigned long rate, new_rate, period, duty;
>>   	unsigned long long tmp;
>>  -	unsigned int prescaler =3D 0;
>>=20
>>   	rate =3D clk_get_rate(parent_clk);
>>  -	tmp =3D (unsigned long long)rate * state->period;
>>  -	do_div(tmp, 1000000000);
>>  -	period =3D tmp;
>>=20
>>  -	while (period > 0xffff && prescaler < 6) {
>>  -		period >>=3D 2;
>>  -		rate >>=3D 2;
>>  -		++prescaler;
>>  +	for (;;) {
>>  +		tmp =3D (unsigned long long)rate * state->period;
>>  +		do_div(tmp, 1000000000);
>=20
> NSEC_PER_SEC?

Ok, didn't know about it.

>>  +
>>  +		if (tmp <=3D 0xffff)
>>  +			break;
>>  +
>>  +		new_rate =3D clk_round_rate(clk, rate - 1);
>>  +
>>  +		if (new_rate < rate)
>>  +			rate =3D new_rate;
>>  +		else
>>  +			return -EINVAL;
>=20
> You are assuming stuff here about the parent clk which isn't=20
> guaranteed
> (AFAICT) by the clk framework: If you call clk_round_rate(clk, rate -=20
> 1)
> this might well return rate even if the clock could run slower than
> rate.

It may not be guaranteed by the clock framework itself, but it is=20
guaranteed
to behave like that on this family of SoCs.

> Wouldn't it make sense to start iterating with rate =3D 0xffff * 1e9 /
> period? Otherwise you get bad configurations if rate is considerable
> slower than necessary.

The algorithm will start with 'rate' being the parent clock's rate,=20
which
will always be the highest rate that the child clock will support.

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |
=
