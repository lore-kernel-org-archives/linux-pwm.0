From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/1] pwm: meson: use the spin-lock only to protect
 register modifications
Date: Mon, 25 Mar 2019 09:48:22 +0100
Message-ID: <20190325084822.ozixel6bzi6xiw67@pengutronix.de>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
 <20190324220217.15813-2-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190324220217.15813-2-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: thierry.reding@gmail.com, narmstrong@baylibre.com, jbrunet@baylibre.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Sun, Mar 24, 2019 at 11:02:17PM +0100, Martin Blumenstingl wrote:
> Holding the spin-lock for all of the code in meson_pwm_apply() can
> result in a "BUG: scheduling while atomic". This can happen because
> clk_get_rate() (which is called from meson_pwm_calc()) may sleep.
> Only hold the spin-lock when modifying registers to solve this.
> 
> The reason why we need a spin-lock in the driver is because the
> REG_MISC_AB register is shared between the two channels provided by one
> PWM controller. The only functions where REG_MISC_AB is modified are
> meson_pwm_enable() and meson_pwm_disable() so the register reads/writes
> in there need to be protected by the spin-lock.
> 
> The original code also used the spin-lock to protect the values in
> struct meson_pwm_channel. This could be necessary if two consumers can
> use the same PWM channel. However, PWM core doesn't allow this so we
> don't need to protect the values in struct meson_pwm_channel with a
> lock.
> 
> Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Looks right.

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Bonus points for adding a comment to struct meson_pwm::lock. Something
like:

	/*
	 * Protects register access to the MISC_AB register that is
	 * shared between the two PWMs.
	 */

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
