From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 3/4] pwm: mxs: add support for inverse polarity
Date: Mon, 23 Sep 2019 10:45:56 +0200
Message-ID: <d2b29144-3de8-4561-3292-49db7e697aca@rasmusvillemoes.dk>
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
 <20190923081348.6843-4-linux@rasmusvillemoes.dk>
 <20190923082735.tzxyhvjlnztsxhsc@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190923082735.tzxyhvjlnztsxhsc@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 23/09/2019 10.27, Uwe Kleine-König wrote:
> On Mon, Sep 23, 2019 at 10:13:47AM +0200, Rasmus Villemoes wrote:
>>
>>  
>> +	pol_bits = state->polarity == PWM_POLARITY_NORMAL ?
>> +		PERIOD_POLARITY_NORMAL : PERIOD_POLARITY_INVERSE;
>> +
>>  	writel(duty_cycles << 16,
>>  	       mxs->base + PWM_ACTIVE0 + pwm->hwpwm * 0x20);
>> -	writel(PERIOD_PERIOD(period_cycles) | PERIOD_POLARITY_NORMAL | PERIOD_CDIV(div),
>> +	writel(PERIOD_PERIOD(period_cycles) | pol_bits | PERIOD_CDIV(div),
> 
> When will this affect the output? Only on the next start of a period, or
> immediatly? Can it happen that this results in a mixed output (i.e. a
> period that has already the new duty cycle from the line above but not
> the new polarity (or period)?

The data sheet says "Also, when the user reprograms the channel in this
manner, the new register values will not take effect until the beginning
of a new output period. This eliminates the potential for output
glitches that could occur if the registers were updated while the
channel was enabled and in the middle of a cycle.". So I think this
should be ok. "this manner" refers to the registers being written in the
proper order (first ACTIVEn, then PERIODn).

Rasmus
