From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [RFC PATCH v3 2/2] pwm: imx: Configure output to GPIO in disabled
 state
Date: Wed, 30 Jan 2019 15:42:29 +0100
Message-ID: <72bad040-05f4-607f-f210-468e46ea3228@ysoft.com>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
 <20181212080154.kcfh57mulypwuscu@pengutronix.de>
 <52ed0614-d1f5-81cb-3b17-8eb137967872@ysoft.com>
 <20181212121255.yg6b4pw7qord7ebi@pengutronix.de>
 <4b0356b7-bc7d-a026-ac90-3f0c5754ed29@ysoft.com>
 <20190124092215.zbu62lhxf667rzvs@pengutronix.de>
 <4004896e-34fc-7160-2f21-30280d96f750@ysoft.com>
 <20190124104435.e6paqwcuz3hizwnv@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124104435.e6paqwcuz3hizwnv@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>, =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@karo-electronics.de>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

On 24.1.2019 11:44, Uwe Kleine-König wrote:
> On Thu, Jan 24, 2019 at 11:12:12AM +0100, Michal Vokáč wrote:
>> On 24.1.2019 10:22, Uwe Kleine-König wrote:
>>> I think it might be beneficial to allow (or require) that disable acts
>>> immediately. But this is not how it used to be and in my discussion with
>>> Thierry (IIRC) he required to complete the currently running period.
>>
>> I am confused here. IFAIK it always used to be that:
>>
>> 	pwm_apply_state(pwm, { .enabled = 0 });
>>
>> immediately stops the PWM with:
>>
>> 	writel(0, imx->mmio_base + MX3_PWMCR);
>>
>> regardless of the period (for pwm-imx).
> 
> Then is is a bug since forever (well, or a fact that resulted from the
> intended semantic not being documented and the driver author not caring
> or knowing better).

Hi Uwe, I skimmed all the PWM drivers trying to find out how others are
waiting for the end of a period before disabling PWM.

There is 50 PWM drivers in total and I could find only two drivers that
do something that resembles waiting for an end of a period:

  - pwm-atmel.c
    https://elixir.bootlin.com/linux/v5.0-rc3/source/drivers/pwm/pwm-atmel.c#L176
	
  - pwm-sun4i.c
    https://elixir.bootlin.com/linux/v5.0-rc3/source/drivers/pwm/pwm-sun4i.c#L284

I did not delve into that too much but I believe there are some HW
requirements on those platforms to stop the PWM that way. Others
simply stop the PWM straight away. So I am confused even more
and wonder where your requirements came from?

Anyway, as I could not find any real example I tried to solve it
according to your earlier suggestion. That is configure duty_cycle=0
and some time later disable PWM.

It generates additional problems. The PWM block has a FIFO with four
slots. Before adding the sample with duty cycle=0 into the FIFO it
is wise to wait for a free slot in the FIFO. Then when the sample is
added it may actually happen that the sample is the fourth in the
FIFO. So it may take up to four periods until we can disable the PWM.
These four periods can take up to 16s. Hmmm :(

Reconfigure the period is not an option. According to the TRM, once you
write new value into the period register, the counter is cleared and
new period is started. That means you can produce the spikes this way
as well..

I agree there are bugs in the driver and it is far from providing
complete support of the i.MX PWM HW. Still, I believe those are totally
independent problems from the pinctrl stuff and so should not block
the discussion/inclusion of this series.

I am sorry if this is getting on your nerves Uwe. I am doing my
best to test all your suggestions and possible solutions to find
a good compromise. At least I learned a lot from doing all that stuff.

Thank you for your time,
Michal
