From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Date: Thu, 12 Mar 2020 22:44:08 +0530
Message-ID: <b8750b79-8703-5d8f-eacf-b3a67cedd252@ti.com>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <f250549f-1e7c-06d6-b2a4-7ae01c06725b@ti.com>
 <20200312084739.isixgdo3txr6rjzg@pengutronix.de>
 <2a5a06cd-7aca-c450-b048-33329d058eca@ti.com>
 <20200312142126.GB2466@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20200312142126.GB2466@localhost>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Hi Richard,

On 12/03/20 7:51 PM, Richard Cochran wrote:
> On Thu, Mar 12, 2020 at 04:14:34PM +0530, Lokesh Vutla wrote:
>> But the problem here is that inactive breaks between two periods is not desired.
>> Because the pwm is used to generate a 1PPS signal and is continuously
>> synchronized with PTP clock.
> 
> The 1-PPS case is the "easy" one.  If the PWM is adjustable on the
> fly, then people will use it with higher frequency signals.

Yes, PWM can be adjusted on the fly. TRM does specify that corresponding
registers(TLDR, TMAR, TCRR) registers can be updated when timer is active.

>  
>> I am up if this can be solved generically. But updating period is very specific
>> to hardware implementation. Not sure what generic solution can be brought out of
>> this. Please correct me if I am wrong.
> 
> What happens today when the PWM frequency or duty cycle are changed
> while the signal is enabled?

Today, PWM is stopped and then period/duty_cycle are updated.

> 
> Do different PWM devices/drivers behave the same way?
> 
> Does this series change the behavior of the am335x and friends?

Yes, this series  is applicable on all TI OMAP2+ devices with DMTIMER.

[0] http://www.ti.com/lit/ug/spruh73q/spruh73q.pdf Section 20.1.1.1 DMTIMER
overview Page 4436.

Thanks and regards,
Lokesh
