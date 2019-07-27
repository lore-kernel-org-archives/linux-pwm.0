From: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 5/6] pwm: sun4i: Add support to output source clock
 directly
Date: Sat, 27 Jul 2019 12:50:08 +0200
Message-ID: <20190727105008.he35sixfvoyl2lm7@flea.home>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-6-jernej.skrabec@siol.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190726184045.14669-6-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: thierry.reding@gmail.com, wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-pwm@vger.kernel.org

On Fri, Jul 26, 2019 at 08:40:44PM +0200, Jernej Skrabec wrote:
> PWM core has an option to bypass whole logic and output unchanged source
> clock as PWM output. This is achieved by enabling bypass bit.
>
> Note that when bypass is enabled, no other setting has any meaning, not
> even enable bit.
>
> This mode of operation is needed to achieve high enough frequency to
> serve as clock source for AC200 chip, which is integrated into same
> package as H6 SoC.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

It doesn't seem to be available on the A10 (at least) though. The A13
seem to have it, so you should probably check that, and make that
conditional to the compatible if not available on all of them.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
