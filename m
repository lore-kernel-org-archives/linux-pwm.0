From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: Re: [PATCH v2 0/3] pwm: lpc32xx: Add support to control
 PWM_PIN_LEVEL bit
Date: Thu, 30 Jun 2016 09:25:19 -0400
Message-ID: <1467293119.32051.9.camel@localhost>
References: <1467032997-5340-1-git-send-email-slemieux.tyco@gmail.com>
	 <ce29f743-e481-64b0-8e05-0b610fa33fb3@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35170 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbcF3NZW (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Jun 2016 09:25:22 -0400
Received: by mail-it0-f66.google.com with SMTP id g127so8822224ith.2
        for <linux-pwm@vger.kernel.org>; Thu, 30 Jun 2016 06:25:22 -0700 (PDT)
In-Reply-To: <ce29f743-e481-64b0-8e05-0b610fa33fb3@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org

Hi Vladimir,

On Thu, 2016-06-30 at 11:43 +0300, Vladimir Zapolskiy wrote:
> Hi Sylvain,
> 
> On 27.06.2016 16:09, Sylvain Lemieux wrote:
> > From: Sylvain Lemieux <slemieux@tycoint.com>
> > 
> > The PWM_PIN_LEVEL bit is leave unset by the kernel PWM driver.
> > 
> > Prior to commit 08ee77b5a5de27ad63c92262ebcb4efe0da93b58,
> > the PWM_PIN_LEVEL bit was always clear when the PWM was disable
> > and a 0 logic level was apply to the output.
> > 
> > According to the LPC32x0 User Manual [1],
> > the default value for bit 30 (PWM_PIN_LEVEL) is 0.
> > 
> > First patch:
> > * initialize the pin level to 0 (default value) and update
> >   the register value accordingly.
> > 
> > Second anf third patches:
> > *  provide support to configure the pin output (i.e. PWM_PIN_LEVEL bit)
> >    when the PWM is disabled.
> 
> a short question, how do you use PWM? Does it serve as a backlight
> or something else?
> 
The PWM is used to control the LCD backlight intensity.

When we setup the backlight brightness level to 0, 
it should turn off the LCD display by disabling the PWM.

This is what was added to our board dts for it:
	backlight {
		compatible = "pwm-backlight";
		pwms = <&pwm1 0 1250000>;

		brightness-levels = <0 20 100>;
		default-brightness-level = <2>;
	};

> > Note:
> > * Follow this URL to access the discussion for version 1 of this
> >   patch: http://thread.gmane.org/gmane.linux.pwm/3882
> > 
> > [1] http://www.nxp.com/documents/user_manual/UM10326.pdf
> > 
> > Sylvain Lemieux (3):
> >   pwm: lpc32xx: Set PWM_PIN_LEVEL bit to default value
> >   pwm: lpc32xx: Add support for PWM_PIN_LEVEL bit configuration
> >   dt-bindings: pwm: lpc32xx: Add nxp,pwm-disabled-level-high property
> > 
> >  Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt |  3 +++
> >  drivers/pwm/pwm-lpc32xx.c                             | 11 +++++++++++
> >  2 files changed, 14 insertions(+)
> > 
> 
> --
> With best wishes,
> Vladimir

Sylvain
