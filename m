From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH v2] clk: Add PWM clock driver
Date: Tue, 09 Dec 2014 14:09:44 +0100
Message-ID: <5486F498.30309@elproma.com.pl>
References: <1415007078-7947-1-git-send-email-p.zabel@pengutronix.de>	 <5480A132.2010103@elproma.com.pl> <54860426.3020400@elproma.com.pl> <1418116533.3107.1.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:52717 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755234AbaLINJw (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Dec 2014 08:09:52 -0500
In-Reply-To: <1418116533.3107.1.camel@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

Hi Philipp,

W dniu 2014-12-09 o 10:15, Philipp Zabel pisze:
> Hi Janusz,
>
> Am Montag, den 08.12.2014, 21:03 +0100 schrieb Janusz U=C5=BCycki:
>> Hi,
>>
>> I've fixed my pwm driver and I can enable 12MHz 50% output using sys=
fs.
>> Then I rebased the pwm-clock to 3.14.
>> I have connected mcp2515 and it works with fixed clock. When I switc=
h
>> the chip's clock to pwm clock in dt
>> I get "mcp251x: probe of spi1.2 failed with error -2". I've also add=
ed
>> clock-frequency property
>> but it didn't help.
>> When I set the mcp2515 clock to fixed clock again but the clock is n=
ot
>> applied to mcp2515 I get
>> "mcp251x spi1.2: MCP251x didn't enter in conf mode after reset".
>> So it looks this is indeed probe error caused likely by dt.
> Did pwm-clock fail to probe already? Could you check with the patch
> below?

Added. clk_pwm_probe() is never called. The pwm-clk driver is built-in.=
=20
mcp251x is a module.
mcp251x doesn't trigger pwm-clock dt. I found fixed-clock uses=20
CLK_OF_DECLARE().
How does it work for you? What is missing?

The pwm-clock driver set CLK_IS_ROOT and no parents.
I think it fail the clock on suspend/resume race but I can be wrong.

>> The fixed and pwm clock in DT:
>>           clocks {
>>                   #address-cells =3D <1>;
>>                   #size-cells =3D <1>;
>>                   ranges;
>>                   mcp251x_xtal_clk: mcp2515_xtal {
>>                           compatible =3D "fixed-clock";
>>                           #clock-cells =3D <0>;
>>                           clock-frequency =3D <12000000>;
>>                   };
>>
>>                   mcp251x_pwm_clk: mcp2515_pwm {
>>                           compatible =3D "pwm-clock";
>>                           #clock-cells =3D <0>;
>>                           clock-frequency =3D <12000000>;
>>                           clock-output-names =3D "can_clk";
>>                           pwms =3D <&pwm 3 83>;     /* 12MHz =3D 1 /=
 ~83ns */
>>                   };
>>           };
>>
>> Also the mentioned frequency recalculation problem appears here.
>> In the case above recalc value is about 12.048MHz instead of 12.0MHz=
=2E
>> While PWM block is clocked 24MHz and the pwm generates exactly 12MHz
>> the pwm-clock driver returns drifted value. Using clock-frequency li=
ke
>> fixed-clock does could simply solve the binding problem.
> Yes, for this case it is very unfortunate that there's only nanosecon=
d
> resolution for the duty cycle. Adding a clock-frequency property to
> indicate the real frequency would solve this problem.

Yes but the property also must be supported by pwm-clock driver.

best regards
Janusz

>
> ------8<------
> diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> index 8f747b3..9c13856 100644
> --- a/drivers/clk/clk-pwm.c
> +++ b/drivers/clk/clk-pwm.c
> @@ -63,12 +63,16 @@ int clk_pwm_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>  =20
>   	pwm =3D devm_pwm_get(&pdev->dev, NULL);
> -	if (IS_ERR(pwm))
> +	if (IS_ERR(pwm)) {
> +		dev_err(&pdev->dev, "failed to get pwm: %ld\n", PTR_ERR(pwm));
>   		return PTR_ERR(pwm);
> +	}
>  =20
>   	ret =3D pwm_config(pwm, (pwm->period + 1) >> 1, pwm->period);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to configure pwm: %d\n", ret);
>   		return ret;
> +	}
>  =20
>   	init.name =3D "pwm-clock";
>   	init.ops =3D &clk_pwm_ops;
> @@ -78,11 +82,18 @@ int clk_pwm_probe(struct platform_device *pdev)
>   	clk_pwm->pwm =3D pwm;
>   	clk_pwm->hw.init =3D &init;
>   	clk =3D devm_clk_register(&pdev->dev, &clk_pwm->hw);
> -	if (IS_ERR(clk))
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "failed to register clock: %ld\n",
> +			PTR_ERR(clk));
>   		return PTR_ERR(clk);
> +	}
>  =20
> -	return of_clk_add_provider(pdev->dev.of_node,
> -				   of_clk_src_simple_get, clk);
> +	ret =3D of_clk_add_provider(pdev->dev.of_node,
> +				  of_clk_src_simple_get, clk);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to add clock provider: %d\n", ret);
> +
> +	return ret;
>   }
>  =20
>   int clk_pwm_remove(struct platform_device *pdev)
>
>

