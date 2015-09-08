From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: Add Broadcom BCM7038 PWM controller support
Date: Tue, 08 Sep 2015 09:56:57 -0700
Message-ID: <55EF1359.70109@gmail.com>
References: <1440811309-1289-1-git-send-email-f.fainelli@gmail.com> <1440811309-1289-3-git-send-email-f.fainelli@gmail.com> <55EDE24F.7020402@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55EDE24F.7020402@vanguardiasur.com.ar>
Sender: linux-kernel-owner@vger.kernel.org
To: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 07/09/15 12:15, Ariel D'Alessandro wrote:
> Hi Florian,
>=20
> I wrote some observations below that maybe can be useful.
>=20
> El 28/08/15 a las 22:21, Florian Fainelli escribi=C3=B3:
>> Add support for the BCM7038-style PWM controller found in all BCM7xx=
x STB SoCs.
>> This controller has a hardcoded 2 channels per controller, and casca=
des a
>> variable frequency generator on top of a fixed frequency generator w=
hich offers
>> a range of a 148ns period all the way to ~622ms periods.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

NB: you can trim your replies so we do not have to skip through lengthy
uncommented parts of the patch.

[snip]

>> +
>> +static inline u32 pwm_readl(struct brcmstb_pwm_dev *p, u32 off)
>=20
> The function name 'pwm_readl' sounds to be very common. It might be
> better to use a prefix here, don't you think? Maybe brcmstb_pwm_readl=
?

Sure, if that makes it clearer, these are local and inlined, so the
chances for getting a namespace conflict are very thin, but fair enough=
,
will rename to match the rest of the functions.

[snip]

>> +		/*
>> +		 * We can be called with separate duty and period updates,
>> +		 * so do not reject dc =3D=3D 0 right away
>> +		 */
>> +		if (pc =3D=3D PWM_PERIOD_MIN ||
>> +		   (dc < PWM_ON_MIN && duty_ns))
>=20
> No break needed here, this expression can be written on a single line
> increasing readability.
>=20
>> +			return -EINVAL;
>> +
>> +		/* We converged on a calculation */
>> +		if (pc <=3D PWM_ON_PERIOD_MAX && dc <=3D PWM_ON_PERIOD_MAX)
>> +			break;
>> +
>> +		/*
>> +		 * The cword needs to be a power of 2 for the variable
>> +		 * frequency generator to output a 50% duty cycle variable
>> +		 * frequency which is used as input clock to the fixed
>> +		 * frequency generator.
>> +		 */
>> +		cword >>=3D 1;
>> +
>> +		/*
>> +		 * Desired periods are too large, we do not have a divider
>> +		 * for them
>> +		 */
>> +		if (cword < CONST_VAR_F_MIN)
>> +			return -EINVAL;
>> +	}
>> +
>> +done:
>> +	/*
>> +	 * Configure the defined "cword" value to have the variable freque=
ncy
>> +	 * generator output a base frequency for the constant frequency
>> +	 * generator to derive from.
>> +	 */
>> +	pwm_writel(b, cword >> 8, PWM_CWORD_MSB + ch * PWM_CH_SIZE);
>> +	pwm_writel(b, cword & 0xff, PWM_CWORD_LSB + ch * PWM_CH_SIZE);
>> +
>> +	/* Select constant frequency signal output */
>> +	reg =3D pwm_readl(b, PWM_CTRL2);
>> +	reg |=3D (CTRL2_OUT_SELECT << (ch * CTRL_CHAN_OFFS));
>=20
> A nitpick here, outer parenthesis can be avoided.
>=20
>> +	pwm_writel(b, reg, PWM_CTRL2);
>=20
> This read-modify-write sequence may be protected by some locking
> mechanism. Notice that, as written in the docs: "PWM core does not
> enforce any locking to pwm_enable(), pwm_disable() and pwm_config()".

Right, I will add required locking here, thanks!

[snip]

>> +	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	p->base =3D devm_ioremap_resource(&pdev->dev, r);
>> +	if (!p->base)
>> +		return -ENOMEM;
>=20
> I think you're missing some cleanup routine here. You have a previous
> call to clk_prepare_enable(), so you may have a call to
> clk_disable_unprepare() here in order to exit cleanly.

Good catch yes.

>=20
>> +
>> +	ret =3D pwmchip_add(&p->chip);
>> +	if (ret)
>> +		dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);
>=20
> Cleanup needed here too.
>=20
>> +
>> +	return ret;
>> +}
>> +
>> +static int brcmstb_pwm_remove(struct platform_device *pdev)
>> +{
>> +	struct brcmstb_pwm_dev *p =3D platform_get_drvdata(pdev);
>> +
>> +	clk_disable_unprepare(p->clk);
>> +
>> +	return pwmchip_remove(&p->chip);
>=20
> AFAIK, pwmchip_remove() may return busy if the PWM chip provides a PW=
M
> device that is still requested, so you shouldn't disable the clock
> before you ensure the PWM chip has been successfuly removed.

Absolutely.

>=20
> It think you could do something like:
>=20
> 	ret =3D pwmchip_remove(&p->chip);
> 	if (ret)
> 		return ret;
>=20
> 	clk_disable_unprepare(p->clk);
> 	return 0;
>=20

--=20
=46lorian
