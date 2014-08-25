From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v5 3/3] pwm: i.MX: Avoid sample FIFO overflow for i.MX
 PWM version2
Date: Mon, 25 Aug 2014 19:59:01 +0800
Message-ID: <20140825115628.GA7008@dragon>
References: <1401274213-8954-1-git-send-email-Ying.Liu@freescale.com>
 <1401274213-8954-3-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-by2lp0242.outbound.protection.outlook.com ([207.46.163.242]:11758
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755314AbaHYL7X (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 25 Aug 2014 07:59:23 -0400
Content-Disposition: inline
In-Reply-To: <1401274213-8954-3-git-send-email-Ying.Liu@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Liu Ying <Ying.Liu@freescale.com>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, s.hauer@pengutronix.de, LW@KARO-electronics.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, May 28, 2014 at 06:50:13PM +0800, Liu Ying wrote:
> The i.MX PWM version2 is embedded in several i.MX SoCs,
> such as i.MX27, i.MX51 and i.MX6SL.  There is a 4-word(16bit)
> sample FIFO in this IP.  Each FIFO slot determines the duty
> period of a PWM waveform in one full cycle.  The IP spec
> mentions that we should not write a fourth sample because
> the FIFO will become full and triggers a FIFO write error
> (FWE) which will prevent the PWM from starting once it is
> enabled.  In order to avoid any sample FIFO overflow issue,
> this patch clears all sample FIFO by doing software reset
> in the configuration hook when the controller is disabled
> or waits for a full PWM cycle to get a relinquished FIFO
> slot when the controller is enabled and the FIFO is fully
> loaded.
>=20
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
>=20
> Another way to reproduce the FIFO overflow issue is to run
> this script:
> while true;
> 	do echo 255 > /sys/class/leds/user/brightness;
> done
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Lothar Wa=DFmann <LW@KARO-electronics.de>
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>

The whole series,

Acked-by: Shawn Guo <shawn.guo@freescale.com>

Thierry,

Can you pick them up if they look good to you?

Shawn
