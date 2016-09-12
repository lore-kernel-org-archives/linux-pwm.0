From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCHv6 0/3] pwm: imx: support output polarity inversion
Date: Mon, 12 Sep 2016 14:45:53 +0200
Message-ID: <20160912124553.aqgv7b4vsx4urogi@piout.net>
References: <20141009151605.GA8818@ulmo.nvidia.com>
 <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
 <6c896634c4d6446df0388da2c0228232@agner.ch>
 <20160909091857.7a263220@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55599 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758050AbcILMp4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Sep 2016 08:45:56 -0400
Content-Disposition: inline
In-Reply-To: <20160909091857.7a263220@ipc1.ka-ro>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

On 09/09/2016 at 09:18:57 +0200, Lothar Waßmann wrote :
> Hi,
> 
> On Thu, 08 Sep 2016 15:15:57 -0700 Stefan Agner wrote:
> > On 2014-10-10 07:22, Lothar Waßmann wrote:
> > > This patch series adds support for polarity inversion to the pwm-imx
> > > driver. The patches have been tested on i.MX6, i.MX53 and with the
> > > ti-ehrpwm.c driver.
> > 
> > Do you know what prevented this patchset from getting merged?
> > 
> No idea.
> 
> > We are looking for Polarity support in PWM for too, this is especially
> > useful for backlight control.
> > 
> Actually the PWM driver may be the wrong place to achieve this. When
> the backlight driver sets the brightness to 0 to switch the backlight
> off, it will disable the PWM. This will make the PWM pin go LOW and
> thus turn the backlight to full brightness rather than off (unless there
> is an additional GPIO that controls a backlight enable pin on the LCD).
> 

Isn't a properly designed PWM putting a high level on its pin when
disabled and configured with inversed polarity ?
If the HW is capable of it, the driver should be fixed.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
