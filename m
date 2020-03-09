From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] dts: imx6: Allow flags argument in pwms reference
Date: Mon, 9 Mar 2020 22:23:29 +0100
Message-ID: <20200309212329.j5y7j7s46fjjscv3@pengutronix.de>
References: <20200309145558.16098-1-pbarker@konsulko.com>
 <d1c950a83d3aa0520df696033bb0a038e2de1f66.camel@toradex.com>
 <20200309170751.vzffq5gmsaw3tsbp@pengutronix.de>
 <20200309173506.GA4916@pendragon.ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42921 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgCIVXc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Mar 2020 17:23:32 -0400
Content-Disposition: inline
In-Reply-To: <20200309173506.GA4916@pendragon.ideasonboard.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Philippe Schenker <philippe.schenker@toradex.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "pbarker@konsulko.com" <pbarker@konsulko.com>, "pantelis.antoniou@konsulko.com" <pantelis.antoniou@konsulko.com>, "laurent.pinchart+renesas@ideasonboard.com" <laurent.pinchart+renesas@ideasonboard.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "matt.ranostay@konsulko.com" <matt.ranostay@konsulko.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>

On Mon, Mar 09, 2020 at 07:35:06PM +0200, Laurent Pinchart wrote:
> On Mon, Mar 09, 2020 at 06:07:51PM +0100, Uwe Kleine-König wrote:
> > On Mon, Mar 09, 2020 at 04:45:05PM +0000, Philippe Schenker wrote:
> > > On Mon, 2020-03-09 at 14:55 +0000, Paul Barker wrote:
> > >> diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
> > >> b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
> > >> index 37f80ab8ccd0..f87ac95b70bc 100644
> > >> --- a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
> > >> +++ b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
> > >> @@ -14,7 +14,7 @@
> > >>  
> > >>  	backlight {
> > >>  		compatible = "pwm-backlight";
> > >> -		pwms = <&pwm1 0 5000000>;
> > >> +		pwms = <&pwm1 0 5000000 0>;
> > > 
> > > There is a header file existing that has PWM_POLARITY_INVERTED defined
> > > in include/dt-bindings/pwm/pwm.h. I feel we should add there a
> > > PWM_POLARITY_NORMAL instead of just using 0.
> > 
> > ack.
> > 
> > > But then I'm asking myself if we can't get rid of the file include/dt-
> > > bindings/pwm/pwm.h and instead use include/linux/pwm.h everywhere.
> > > 
> > > Or shouldn't we use defines in devicetrees from there?
> > 
> > devicetrees are supposed to be stand-alone. So yes indeed, no linux
> > includes in device tree files.
> 
> Correct. I don't mind adding PWM_POLARITY_NORMAL to
> include/dt-bindings/pwm/pwm.h, I think it would increase readability.

+1 from me. Who cares enough to come up with a patch?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
