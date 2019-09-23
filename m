From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/4] pwm: mxs: implement ->apply
Date: Mon, 23 Sep 2019 11:04:39 +0200
Message-ID: <a6407644-0b5b-ba46-9435-0d14be9066a5@rasmusvillemoes.dk>
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
 <20190923081348.6843-2-linux@rasmusvillemoes.dk>
 <20190923082459.huqpbz5eseonkscv@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190923082459.huqpbz5eseonkscv@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 23/09/2019 10.24, Uwe Kleine-König wrote:
> Hello Rasmus,
> 
> On Mon, Sep 23, 2019 at 10:13:45AM +0200, Rasmus Villemoes wrote:
>> In preparation for supporting setting the polarity, switch the driver
>> to support the ->apply method.
>>
> 
> Maybe it would be easier to review when converting from .config +
> .enable + .disable to .apply in a single step. (Note this "maybe" is
> honest, I'm not entirely sure.)

I tried to make .apply do exactly what the old sequence of calls from
the core to the individual methods would do, and for that it seemed a
little easier to keep the old methods around - but yes, I do need to be
more careful than that to provide the atomicity guarantee that the
legacy methods did not. It's also much easier to squash than to split,
so for now I'll leave them separate - if somebody prefers them squashed,
I'll do that.

> There is a bug: If the PWM is running at (say) period=100ms, duty=0ms
> and we call
> pwm_apply_state(pwm, { .enabled = false, duty=100000, period=1000000 });
> the output might get high which it should not.

Ah, yes. So I suppose that if we're changing from enabled to disabled,
we should simply disable it in the CTRL register before changing the
duty/period.

> Also there is a bug already in .config: You are not supposed to call
> clk_get_rate if the clk might be off.

Interesting, I didn't know that. So the prepare_enable logic needs to be
moved before we start computing the period/duty cycles. Do you know why
it has apparently worked so far? I would have thought such a rule would
be enforced by the clock framework, or at least produced a warning.

Thanks for the fast review. I'll wait a day or two to see if there are
other comments before sending out a v2.

Rasmus
