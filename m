From: Liu Ying <Ying.Liu@freescale.com>
Subject: Re: [PATCH v3] pwm: i.MX: Avoid sample FIFO overflow for i.MX PWM
 version2
Date: Mon, 19 May 2014 16:09:46 +0800
Message-ID: <5379BC4A.6080908@freescale.com>
References: <1400217068-22642-1-git-send-email-Ying.Liu@freescale.com>
 <20140519071105.GZ5858@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn1blp0189.outbound.protection.outlook.com ([207.46.163.189]:31820
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751215AbaESIHN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 19 May 2014 04:07:13 -0400
In-Reply-To: <20140519071105.GZ5858@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, shawn.guo@freescale.com, LW@KARO-electronics.de, linux-arm-kernel@lists.infradead.org

Hi Sascha,

Thanks for your comments.

On 05/19/2014 03:11 PM, Sascha Hauer wrote:
> On Fri, May 16, 2014 at 01:11:08PM +0800, Liu Ying wrote:
>> The i.MX PWM version2 is embedded in several i.MX SoCs,
>> such as i.MX27, i.MX51 and i.MX6SL.  There are four 16bit
>> sample FIFOs in this IP, each of which determines the duty
>> period of a PWM waveform in one full cycle.  The IP spec
>> mentions that we should not write a fourth sample because
>> the FIFOs will become full and trigger a FIFO write error
>> (FWE) which will prevent the PWM from starting once it is
>> enabled.  In order to avoid any sample FIFO overflow issue,
>> this patch clears all sample FIFOs or waits for a rollover
>> event to consume a FIFO slot when necessary.  In this way,
>> only the first FIFO slot will be loaded at most.
>>
>> Note that the PWM controller will not generate any rollover
>> event if the duty period is zero.  This makes the logic a
>> bit complicated to determine if we clear the sample FIFOs
>> or wait for a rollover event.
>>
>> The FIFO overflow issue can be reproduced by the following
>> commands on the i.MX6SL EVK platform, assuming we use PWM2
>> for the debug LED which is driven by the pin HSIC_STROBE
>> and the maximal brightness is 255.
>> echo 0   > /sys/class/leds/user/brightness
>> echo 0   > /sys/class/leds/user/brightness
>> echo 0   > /sys/class/leds/user/brightness
>> echo 0   > /sys/class/leds/user/brightness
>> echo 255 > /sys/class/leds/user/brightness
>> Here, FWE happens(PWMSR register reads 0x58) and the LED
>> can not be lighten.
> 
> I find this overly complicated. It adds 89 lines to a 300 lines driver
> for a single workaround. Wouldn't it be sufficient to add a delay
> of period_ns in imx_pwm_config_v2 when the FIFO is full?

The delay approach looks ok if the engine is enabled.
But, if the engine is disabled, adding delay does not make sense, since
the engine will not consume any FIFO slot.
So, two cases should be handled separately at least:
1) The engine is enabled and the FIFO is full, we delay for period_ns.
2) The engine is disabled and the FIFO is full, we reset the engine?

I like the rollover interrupt approach better, because it may avoid
the potential unnecessary lag the delay approach introduces(when the
engine is enabled, the FIFO is full and one FIFO slot is consumed at
the time we delay).
Moreover, IMHO, a delay approach is somewhat the last choice for a driver.

> 
> Sascha
> 

-- 
Liu Ying
