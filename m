From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/4] pwm: mxs: implement ->apply
Date: Mon, 23 Sep 2019 11:17:45 +0200
Message-ID: <20190923091745.ehvz4zi2riyanmug@pengutronix.de>
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
 <20190923081348.6843-2-linux@rasmusvillemoes.dk>
 <20190923082459.huqpbz5eseonkscv@pengutronix.de>
 <a6407644-0b5b-ba46-9435-0d14be9066a5@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a6407644-0b5b-ba46-9435-0d14be9066a5@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>
Cc: Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello,

[expanded the recipents to include RMK and the clk list]

On Mon, Sep 23, 2019 at 11:04:39AM +0200, Rasmus Villemoes wrote:
> On 23/09/2019 10.24, Uwe Kleine-König wrote:
> > Also there is a bug already in .config: You are not supposed to call
> > clk_get_rate if the clk might be off.
> 
> Interesting, I didn't know that. So the prepare_enable logic needs to be
> moved before we start computing the period/duty cycles. Do you know why
> it has apparently worked so far? I would have thought such a rule would
> be enforced by the clock framework, or at least produced a warning.

FTR: This is documented in the kerneldoc code comment to clk_get_rate in
include/linux/clk.h.

Assuming this is relevant, it might indeed make sense to add a
WARN_ONCE for this.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
