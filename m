From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: MX28: leds/pwm: Using pwm driven led as heartbeat leads to
 kernel warning
Date: Fri, 4 Apr 2014 22:26:58 +0800
Message-ID: <20140404142656.GA16383@dragon>
References: <53345C93.9040005@i2se.com>
 <533EB9AC.6040708@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <533EB9AC.6040708@i2se.com>
Sender: linux-leds-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Thierry Reding <thierry.reding@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Apr 04, 2014 at 03:54:52PM +0200, Stefan Wahren wrote:
> the problem is still reproducable in Mainline 3.14.0 and gives the same
> warning message.
> Also i add linux-leds in CC.
> 
> Are there any advices to narrow down the problem?
> 
> Is this problem specific to i.MX28 PWM (i don't have other kind of
> hardware)?

I don't think it's specific to i.MX28 PWM.  Since the .config hook of
pwm_ops will be called from interrupt context in this case, any pwm
drivers that do sleeping calls in the hook will have this problem, e.g.
the clk APIs that hold mutex like clk_prepare() and clk_get_rate() etc.

Shawn
