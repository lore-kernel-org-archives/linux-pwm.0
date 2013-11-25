Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOMZO5D1qR8+RH=w67=2LVQVJXiuPSo7BDXWt+KaBf5sOUFuPQ@mail.gmail.com>
References: <20131122142231.GA1741@ulmo.nvidia.com>
	<20131122145224.GO14725@sirena.org.uk>
	<20131125031029.GC11613@S2101-09.ap.freescale.net>
	<CAOMZO5CtNnma8Sv35P3jeNYQiLV=jdmN0Q7w2_LFMOj-nTbPZg@mail.gmail.com>
	<20131125133659.GA30476@S2101-09.ap.freescale.net>
	<CAOMZO5DW3pSxPGe6N0CRiCEc+iVV9X_13JbzAvuFbb4jide+zw@mail.gmail.com>
	<20131125172904.GP14725@sirena.org.uk>
	<CAOMZO5D1qR8+RH=w67=2LVQVJXiuPSo7BDXWt+KaBf5sOUFuPQ@mail.gmail.com>
Date: Mon, 25 Nov 2013 18:58:30 -0200
Message-ID: <CAOMZO5BM5Tfyfi05D3cyYHAVeR5X9R_5H2ceo_tfcb7Qn_-W7A@mail.gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
From: Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pwm.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, Thierry Reding <thierry.reding@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org

On Mon, Nov 25, 2013 at 6:37 PM, Fabio Estevam <festevam@gmail.com> wrote:

> At least mx28evk and mx6qsabresd have no LCD output in 3.13-rc1.
>
> Not sure what is the proper fix though.

What about this?

--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3850,4 +3850,4 @@ unlock:

        return 0;
 }
-late_initcall(regulator_init_complete);
+core_initcall(regulator_init_complete);
