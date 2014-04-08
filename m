From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: MX28: leds/pwm: Using pwm driven led as heartbeat leads to
 kernel warning
Date: Tue, 8 Apr 2014 16:18:49 +0800
Message-ID: <20140408081848.GH2438@dragon>
References: <53345C93.9040005@i2se.com>
 <533EB9AC.6040708@i2se.com>
 <20140404142656.GA16383@dragon>
 <20140404164446.GI4883@piout.net>
 <20140408073402.GC2438@dragon>
 <20140408075916.GA30127@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140408075916.GA30127@piout.net>
Sender: linux-leds-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <fabio.estevam@freescale.com>, Thierry Reding <thierry.reding@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Apr 08, 2014 at 09:59:16AM +0200, Alexandre Belloni wrote:
> The driver using the PWM should test the flag, have a look at:
> http://lxr.free-electrons.com/source/drivers/leds/leds-pwm.c#L183

Ah, right, that' how the flag works.  Thanks, Alexandre.  I send a patch
to set the flag for pwm-mxs driver shortly.

Shawn
