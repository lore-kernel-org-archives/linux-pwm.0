From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
Date: Mon, 25 Mar 2019 09:41:53 +0100
Message-ID: <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, narmstrong@baylibre.com, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com
List-Id: linux-pwm@vger.kernel.org

Hello Martin,

On Sun, Mar 24, 2019 at 11:02:16PM +0100, Martin Blumenstingl wrote:
> Back in January a "BUG: scheduling while atomic" error showed up during
> boot on my Meson8b Odroid-C1 (which uses a PWM regulator as CPU supply).
> The call trace comes down to:
>   __mutex_lock
>   clk_prepare_lock
>   clk_core_get_rate
>   meson_pwm_apply
>   ..
>   dev_pm_opp_set_rate
>   ..
> =

> Jerome has also seen the same problem but from pwm-leds (instead of a
> pwm-regulator). He posted a patch which replaces the spinlock with a
> mutex. That works. I believe we can optimize this by reducing the time
> where the lock is held - that also allows to keep the spin-lock.
> =

> Analyzing this issue helped me understand the pwm-meson driver better.
> My plan is to send some cleanups (with the goal of re-using more of the
> goodies from the PWM core in the pwm-meson driver) after this single fix
> is merged (they can be found here: [1]).

I didn't look over these in detail, but I see an issue that according
to the shortlogs isn't addressed: In the .apply callback there is
(simplified):

	if (!state->enabled) {
		meson_pwm_disable(meson, pwm->hwpwm);
		return;
	}

This results in the wrong output after:

	pwm_apply_state(pwm, { .enabled =3D true, .polarity =3D PWM_POLARITY_NORMA=
L, ...});
	pwm_apply_state(pwm, { .enabled =3D false, .polarity =3D PWM_POLARITY_INVE=
RTED, ...});

because the polarity isn't checked.

If you want to implement further cleanups, my questions and propositions
are:

 - Is there a publicly available manual for this hardware? If yes, you
   can add a link to it in the header of the driver.

 - Why do you handle reparenting of the PWM's clk in .request? Wouldn't
   this be more suitable in .apply?

 - Does stopping the PWM (i.e. clearing MISC_{A,B}_EN in the MISC_AB
   register) freeze the output, or is the currently running period
   completed first? (The latter is the right behaviour.)

 - Please point out in the header that for changing period/duty
   cycle/polarity the hardware must be stopped. (I suggest to apply the
   style used in https://www.spinics.net/lists/linux-pwm/msg09262.html
   for some consistency.)

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
