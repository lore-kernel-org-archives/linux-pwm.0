Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:50800
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754889Ab3IBCi5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Sun, 1 Sep 2013 22:38:57 -0400
From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: RE: [PATCHv2 4/4] Documentation: Add device tree bindings for
 Freescale FTM PWM.
Date: Mon, 2 Sep 2013 02:38:53 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F827F7831@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1377856132-11290-1-git-send-email-Li.Xiubo@freescale.com>
 <1377856132-11290-5-git-send-email-Li.Xiubo@freescale.com>
 <20130830173008.GC30069@pengutronix.de>
In-Reply-To: <20130830173008.GC30069@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Guo Shawn-R65073 <r65073@freescale.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

> Subject: Re: [PATCHv2 4/4] Documentation: Add device tree bindings for
> Freescale FTM PWM.
> 
...
> > +
> > +pwm0: pwm@40038000 {
> > +		compatible = "fsl,vf610-ftm-pwm";
> > +		reg = <0x40038000 0x1000>;
> > +		#pwm-cells = <3>;
> > +		clock-names = "ftm0", "ftm0_fix_sel", "ftm0_ext_sel";
> > +		clocks = <&clks VF610_CLK_FTM0>,
> > +			<&clks VF610_CLK_FTM0_FIX_SEL>,
> > +			<&clks VF610_CLK_FTM0_EXT_SEL>;
> > +		pinctrl-names = "ch0-active", "ch0-idle", "ch1-active", "ch1-
> idle",
> > +		....;
> > +		pinctrl-0 = <&pinctrl_pwm0_ch0_active>;
> > +		pinctrl-1 = <&pinctrl_pwm0_ch0_idle>;
> > +		pinctrl-2 = <&pinctrl_pwm0_ch1_active>;
> > +		pinctrl-3 = <&pinctrl_pwm0_ch1_idle>;
> > +		...
> > +		fsl,pwm-counter-clk = "ftm0_ext_sel";
> > +		fsl,pwm-avaliable-chs = <0 3 5 6>;
> 
> I don't think this proerty is useful. Just enable all channels. I think
> this was mentioned before.
> 
Yes.
Actully this property is located in board level dts file.
I have added and requested all the channels in SoC level dtsi file, and in board level dts file to tell the customer the limitation, I think is much safter and better.

--
Best Regards.
Xiubo

