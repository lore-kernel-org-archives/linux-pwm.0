From: oUwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: rockchip: simplify rockchip_pwm_get_state()
Date: Thu, 19 Sep 2019 13:11:15 +0200
Message-ID: <20190919111115.5oraof2bdl4627xv@pengutronix.de>
References: <20190919091728.24756-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190919091728.24756-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, David Wu <david.wu@rock-chips.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Sep 19, 2019 at 11:17:27AM +0200, Rasmus Villemoes wrote:
> The way state->enabled is computed is rather convoluted and hard to
> read - both branches of the if() actually do the exact same thing. So
> remove the if(), and further simplify "<boolean condition> ? true :
> false" to "<boolean condition>".
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> I stumbled on this while trying to understand how the pwm subsystem
> works. This patch is a semantic no-op, but it's also possible that,
> say, the first branch simply contains a "double negative" so either
> the != should be == or the "false : true" should be "true : false".

The change looks obviously right, it's a noop.

I share your doubts however. The construct was introduced in commit 
831b2790507b ("pwm: rockchip: Use same PWM ops for each IP") by David
Wu.

Before there were rockchip_pwm_get_state_v1 for the supports_polarity =
false case and rockchip_pwm_get_state_v2 for supports_polarity = true.

In both state->enabled was assigned true if ((val & enable_conf) ==
enable_conf). So I assume everything is fine.

A confirmation by David would be great though.

As a side note: Is there publicly available documentation for this IP?
If a link were added to the driver's header we could check easily
ourselves.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
