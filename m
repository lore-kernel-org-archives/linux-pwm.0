From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3] pwm: i.MX: Avoid sample FIFO overflow for i.MX PWM
 version2
Date: Mon, 19 May 2014 09:11:05 +0200
Message-ID: <20140519071105.GZ5858@pengutronix.de>
References: <1400217068-22642-1-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400217068-22642-1-git-send-email-Ying.Liu@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liu Ying <Ying.Liu@freescale.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, shawn.guo@freescale.com, LW@KARO-electronics.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Fri, May 16, 2014 at 01:11:08PM +0800, Liu Ying wrote:
> The i.MX PWM version2 is embedded in several i.MX SoCs,
> such as i.MX27, i.MX51 and i.MX6SL.  There are four 16bit
> sample FIFOs in this IP, each of which determines the duty
> period of a PWM waveform in one full cycle.  The IP spec
> mentions that we should not write a fourth sample because
> the FIFOs will become full and trigger a FIFO write error
> (FWE) which will prevent the PWM from starting once it is
> enabled.  In order to avoid any sample FIFO overflow issue,
> this patch clears all sample FIFOs or waits for a rollover
> event to consume a FIFO slot when necessary.  In this way,
> only the first FIFO slot will be loaded at most.
> 
> Note that the PWM controller will not generate any rollover
> event if the duty period is zero.  This makes the logic a
> bit complicated to determine if we clear the sample FIFOs
> or wait for a rollover event.
> 
> The FIFO overflow issue can be reproduced by the following
> commands on the i.MX6SL EVK platform, assuming we use PWM2
> for the debug LED which is driven by the pin HSIC_STROBE
> and the maximal brightness is 255.
> echo 0   > /sys/class/leds/user/brightness
> echo 0   > /sys/class/leds/user/brightness
> echo 0   > /sys/class/leds/user/brightness
> echo 0   > /sys/class/leds/user/brightness
> echo 255 > /sys/class/leds/user/brightness
> Here, FWE happens(PWMSR register reads 0x58) and the LED
> can not be lighten.

I find this overly complicated. It adds 89 lines to a 300 lines driver
for a single workaround. Wouldn't it be sufficient to add a delay
of period_ns in imx_pwm_config_v2 when the FIFO is full?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
