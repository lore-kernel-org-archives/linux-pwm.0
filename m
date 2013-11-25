Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20131125172904.GP14725@sirena.org.uk>
References: <20131122142231.GA1741@ulmo.nvidia.com>
	<20131122145224.GO14725@sirena.org.uk>
	<20131125031029.GC11613@S2101-09.ap.freescale.net>
	<CAOMZO5CtNnma8Sv35P3jeNYQiLV=jdmN0Q7w2_LFMOj-nTbPZg@mail.gmail.com>
	<20131125133659.GA30476@S2101-09.ap.freescale.net>
	<CAOMZO5DW3pSxPGe6N0CRiCEc+iVV9X_13JbzAvuFbb4jide+zw@mail.gmail.com>
	<20131125172904.GP14725@sirena.org.uk>
Date: Mon, 25 Nov 2013 18:37:42 -0200
Message-ID: <CAOMZO5D1qR8+RH=w67=2LVQVJXiuPSo7BDXWt+KaBf5sOUFuPQ@mail.gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
From: Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pwm.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, Thierry Reding <thierry.reding@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org

On Mon, Nov 25, 2013 at 3:29 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Nov 25, 2013 at 12:43:58PM -0200, Fabio Estevam wrote:
>
>> What commit provides this regulator core functionality?
>
> regulator: core: Provide a dummy regulator with full constraints
>
>> Looks like it has not reached 3.13-rc1.
>
> Yes, it did.

Ok, I see.

Another way to have LCD working is on a 3.13-rc1 (without passing the
fake regulator node in dt):

--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -284,7 +284,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)

        pb->power_supply = devm_regulator_get(&pdev->dev, "power");
        if (IS_ERR(pb->power_supply)) {
-               ret = PTR_ERR(pb->power_supply);
+               ret = -EPROBE_DEFER;
                goto err_gpio;
        }

At least mx28evk and mx6qsabresd have no LCD output in 3.13-rc1.

Not sure what is the proper fix though.

Regards,

Fabio Estevam
