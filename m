From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx6sl: correct PWM ipg clock source
Date: Wed, 19 Dec 2018 09:36:40 +0100
Message-ID: <20181219083640.42jmibqzn2t3i4t2@pengutronix.de>
References: <1545197799-9082-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1545197799-9082-1-git-send-email-Anson.Huang@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-pwm@vger.kernel.org, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

[Cc: +=3D linux-pwm]

Hello,

On Wed, Dec 19, 2018 at 05:41:31AM +0000, Anson Huang wrote:
> From i.MX6SL Reference Manual, the PWMx's ipg clock
> for registers access is from perclk, correct them.

I assume this is related to the patch "pwm: imx: add ipg clock
operation"? This patch doesn't fix a real problem because in practise
perclk is already enabled, right? (I don't question the patch, just
wonder how urgent it is.)

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sl.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index e7524e7..4b4813f 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -338,7 +338,7 @@
>  				compatible =3D "fsl,imx6sl-pwm", "fsl,imx27-pwm";
>  				reg =3D <0x02080000 0x4000>;
>  				interrupts =3D <0 83 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clks IMX6SL_CLK_PWM1>,
> +				clocks =3D <&clks IMX6SL_CLK_PERCLK>,
>  					 <&clks IMX6SL_CLK_PWM1>;
>  				clock-names =3D "ipg", "per";

It's a bit irritating that IMX6SL_CLK_PERCLK is used for the "ipg" clk,
not the "per" clk. Is this correct?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
