From: Olof Johansson <olof@lixom.net>
Subject: Re: PWM...
Date: Sun, 19 Jan 2014 11:03:24 -0800
Message-ID: <20140119190324.GC28056@quad.lixom.net>
References: <20140119164956.GR15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:37437 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbaASTFX (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jan 2014 14:05:23 -0500
Received: by mail-pb0-f43.google.com with SMTP id md12so6078338pbc.16
        for <linux-pwm@vger.kernel.org>; Sun, 19 Jan 2014 11:05:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140119164956.GR15937@n2100.arm.linux.org.uk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, arm@kernel.org, devicetree@vger.kernel.org

[Adding devicetree list since we're talking bindings]

On Sun, Jan 19, 2014 at 04:49:57PM +0000, Russell King - ARM Linux wrote:
> So, having looked at what else I can add support for on the cubox-i, I
> decided it would be nice and simple to add support for the front panel
> LED.  What could possibly go wrong with this.
> 
> Well, the hardware is wired such that the LED is connected between the
> PWM output and +3.3v.  So, a constant low turns the LED on full, whereas
> a constant high turns the LED off.
> 
> So, the polarity of the LED is inverted - but this _can't_ be specified
> in the totally and utterly fucked misdesigned crap that DT is:
> 
>         pwmleds {
>                 compatible = "pwm-leds";
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&pinctrl_cubox_i_pwm1>;
>                   
>                 front {
>                         label = "imx6:red:front";
>                         pwms = <&pwm1 0 50000>;
>                         max-brightness = <248>;
>                 };
>         };
> 
>                         pwm1: pwm@02080000 {
>                                 #pwm-cells = <2>;
>                                 compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
>                                 reg = <0x02080000 0x4000>;
>                                 interrupts = <0 83 0x04>;
>                                 clocks = <&clks 62>, <&clks 145>;
>                                 clock-names = "ipg", "per";
>                         };
> 
> Yes, because iMX6 specifies #pwm-cells as 2, there's no flags able to
> be specified in the pwms declaration in pwmleds.  So that doesn't work.
> There's no property to tell pwmleds that it should use inverted sense
> either.

Adding a property for active-low to the pwm-leds binding would be
easy, and backwards compatible. I'm surprised the original binding
didn't specify it. The leds-pwm driver already seems to support it for
C-configured instances.

I'm also surprised that the imx pwm driver even has a #pwm-cells of
two, since the driver only supports one output. It'd be nice if they
had allocated the extra cell for flags, but it's hard to change now,
unless you do a new binding/compatible value and deprecate the old one.

> Moreover, there's no way to specify a default brightness for the LED
> in the absence of any trigger, so this results in the LED being fully
> on.

That seems to be missing from the led-pwm driver altogether, not just the DT
bindings? Shouldn't be too bad to add a default-brightness property and plumb
that up through the driver in this case.

> So, something which _should_ be nice and simple is turned into a major
> fuckup because of the total and utter crappiness that DT is and the
> total misdesign that this shite is.

It's not a major fuckup. None of the above is unfixable.


-Olof

