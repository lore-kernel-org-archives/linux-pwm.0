From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx6qdl: Adjust the brightness setting for
 LVDS panel
Date: Thu, 22 Jan 2015 16:38:04 +0100
Message-ID: <1421941084.3084.45.camel@pengutronix.de>
References: <1421749355-23050-1-git-send-email-r63905@freescale.com>
	 <20150120113837.GC2766@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38500 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbbAVPiK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Jan 2015 10:38:10 -0500
In-Reply-To: <20150120113837.GC2766@dragon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Robby Cai <r63905@freescale.com>, linux-pwm@vger.kernel.org, Eric Nelson <eric.nelson@boundarydevices.com>, Tim Harvey <tharvey@gateworks.com>, jg1.han@samsung.com, Troy Kisky <troy.kisky@boundarydevices.com>, thierry.reding@gmail.com, kernel@pengutronix.de, lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org

Am Dienstag, den 20.01.2015, 19:38 +0800 schrieb Shawn Guo:
> Add LAKML and a few interested people.
> 
> Shawn
> 
> On Tue, Jan 20, 2015 at 06:22:35PM +0800, Robby Cai wrote:
> > Hannstar XGA panel is used by default on i.MX6QDL Sabre Auto/Lite/SD
> > or derived board.
> > 
> > According to its data sheet [1],
> > a) the dimming duty cycle is 20% - 100%.
> > This patch changes the brightness-level from 20 to 100 with step 10 to
> > make it straight-forward.
> > b) the typical dimming frequency is 20KHz.
> > The previous setting is 200Hz. This patch corrects it.
> > 
> > [1]
> > http://boundarydevices.com/wp-content/uploads/2013/06/HSD100PXN1-A00-C11-1.0.pdf
> > 
> > Signed-off-by: Robby Cai <r63905@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi     | 6 +++---
> >  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi     | 6 +++---
> >  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi     | 6 +++---
> >  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 6 +++---
> >  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi  | 6 +++---
> >  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 6 +++---
> >  arch/arm/boot/dts/imx6qdl-sabresd.dtsi    | 6 +++---
> >  7 files changed, 21 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> > index b5756c2..33484d8 100644
> > --- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> > @@ -29,9 +29,9 @@
> >  
> >  	backlight {
> >  		compatible = "pwm-backlight";
> > -		pwms = <&pwm4 0 5000000>;
> > -		brightness-levels = <0 4 8 16 32 64 128 255>;
> > -		default-brightness-level = <7>;
> > +		pwms = <&pwm4 0 50000>;
> > +		brightness-levels = <0 20 30 40 50 60 70 80 90 100>;
> > +		default-brightness-level = <9>;

I notice that the intervals are changed from exponential to linear.
Is this really wanted here?
I expect that the new settings result in huge steps in perceived
brightness at low levels and a nearly imperceptible change at the
last step.

regards
Philipp

