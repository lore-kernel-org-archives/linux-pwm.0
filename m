From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx6sl: correct PWM ipg clock source
Date: Wed, 19 Dec 2018 09:51:56 +0100
Message-ID: <20181219085156.2o5xxrodrqrc62ba@pengutronix.de>
References: <1545197799-9082-1-git-send-email-Anson.Huang@nxp.com>
 <20181219083640.42jmibqzn2t3i4t2@pengutronix.de>
 <DB3PR0402MB39160D8B04AE55D1E2829067F5BE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39160D8B04AE55D1E2829067F5BE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Wed, Dec 19, 2018 at 08:44:13AM +0000, Anson Huang wrote:
> i.MX6SL current setting has no issue, because the ipg_clk_s is from perclk which is always
> ON, but it does NOT match the clock info in reference manual, while other i.MX6 SoCs
> are having correct clock settings for PWM IPG clock. 
> 
> It is just an improvement, NOT fix a real problem.

OK, so it's merge window material as I expected.
 
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  arch/arm/boot/dts/imx6sl.dtsi | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/imx6sl.dtsi
> > > b/arch/arm/boot/dts/imx6sl.dtsi index e7524e7..4b4813f 100644
> > > --- a/arch/arm/boot/dts/imx6sl.dtsi
> > > +++ b/arch/arm/boot/dts/imx6sl.dtsi
> > > @@ -338,7 +338,7 @@
> > >  				compatible = "fsl,imx6sl-pwm", "fsl,imx27-pwm";
> > >  				reg = <0x02080000 0x4000>;
> > >  				interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
> > > -				clocks = <&clks IMX6SL_CLK_PWM1>,
> > > +				clocks = <&clks IMX6SL_CLK_PERCLK>,
> > >  					 <&clks IMX6SL_CLK_PWM1>;
> > >  				clock-names = "ipg", "per";
> > 
> > It's a bit irritating that IMX6SL_CLK_PERCLK is used for the "ipg" clk, not the
> > "per" clk. Is this correct?
> 
> Yes, you can check the i.MX6SL CCM chapter for PWM clocks, the ipg_clk_s
> is from perclk and its enabled control is VCC which is always ON. The "per"
> clock is for PWM function, NOT register access, I tried disabling the PWM per clock,
> PWM registers still can be accessed.

OK, then Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

> > Industrial Linux Solutions                 |
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> > pengutronix.de%2F&amp;data=02%7C01%7Canson.huang%40nxp.com%7C7bf
> > fc7bad61545fb595508d6658d1d0f%7C686ea1d3bc2b4c6fa92cd99c5c301635
> > %7C0%7C0%7C636808054141733417&amp;sdata=dDv2spIwbQmkpu7mhEm
> > 8bRHyKKviSO%2BQ33ZU7nD1bJQ%3D&amp;reserved=0  |

haha, something between you and me mangles links. I bet it's on your
side.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
