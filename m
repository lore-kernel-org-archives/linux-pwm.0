From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
Date: Tue, 26 Mar 2019 11:54:06 +0100
Message-ID: <20190326105405.p5appmjs2qdygkz3@pengutronix.de>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
 <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
 <CAFBinCAn-9oETMKMfSXoJOMBrQyrCFN7AyHG02bQaoxG1px3YA@mail.gmail.com>
 <ec428b82-f7d9-0f14-363c-a40d14ce4414@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ec428b82-f7d9-0f14-363c-a40d14ce4414@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, thierry.reding@gmail.com, jbrunet@baylibre.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Tue, Mar 26, 2019 at 10:06:31AM +0100, Neil Armstrong wrote:
> On 25/03/2019 18:41, Martin Blumenstingl wrote:
> > On Mon, Mar 25, 2019 at 9:41 AM Uwe Kleine-König
> > <u.kleine-koenig@pengutronix.de> wrote:
> >> On Sun, Mar 24, 2019 at 11:02:16PM +0100, Martin Blumenstingl wrote:
> >>> Back in January a "BUG: scheduling while atomic" error showed up during
> >>> boot on my Meson8b Odroid-C1 (which uses a PWM regulator as CPU supply).
> >>> The call trace comes down to:
> >>>   __mutex_lock
> >>>   clk_prepare_lock
> >>>   clk_core_get_rate
> >>>   meson_pwm_apply
> >>>   ..
> >>>   dev_pm_opp_set_rate
> >>>   ..
> >>>
> >>> Jerome has also seen the same problem but from pwm-leds (instead of a
> >>> pwm-regulator). He posted a patch which replaces the spinlock with a
> >>> mutex. That works. I believe we can optimize this by reducing the time
> >>> where the lock is held - that also allows to keep the spin-lock.
> >>>
> >>> Analyzing this issue helped me understand the pwm-meson driver better.
> >>> My plan is to send some cleanups (with the goal of re-using more of the
> >>> goodies from the PWM core in the pwm-meson driver) after this single fix
> >>> is merged (they can be found here: [1]).
> >>
> >> I didn't look over these in detail, but I see an issue that according
> >> to the shortlogs isn't addressed: In the .apply callback there is
> >> (simplified):
> >>
> >>         if (!state->enabled) {
> >>                 meson_pwm_disable(meson, pwm->hwpwm);
> >>                 return;
> >>         }
> >>
> >> This results in the wrong output after:
> >>
> >>         pwm_apply_state(pwm, { .enabled = true, .polarity = PWM_POLARITY_NORMAL, ...});
> >>         pwm_apply_state(pwm, { .enabled = false, .polarity = PWM_POLARITY_INVERTED, ...});
> >>
> >> because the polarity isn't checked.
> > let me rephrase this to make sure I understand this correctly:
> > - applying a PWM state with .enabled = true and PWM_POLARITY_NORMAL
> > will enable the PWM output
> > - applying a PWM state with .enabled = false and PWM_POLARITY_NORMAL
> > will disable the PWM output
> > - applying a PWM state with .enabled = true and PWM_POLARITY_INVERTED
> > will disable the PWM output
> > - applying a PWM state with .enabled = false and PWM_POLARITY_INVERTED
> > will enable the PWM output
> > 
> > in other words: the polarity doesn't only apply to period and
> > duty_cycle but also to the enabled state.
> 
> Sorry I don't understand your point.
> If the apply state is disable, well we disable the PWM output, I don't see why
> the polarity changes the enable state.

Martin's summary was at least misleading, I didn't understand what he
meant.

The relevant point is: When the PWM is disabled (either by pwm_disable
or equivalent by pwm_apply_state(pwm, { .enabled = false, ... })) the
expectation is that the output becomes "inactive". That means "constant
low" for a normal PWM and "constant high" for an inverted PWM.

Then as meson_pwm_apply doesn't check for state->polarity if
state->enabled == false there is a bug.

> I'd like to point out the architecture of the PWM.
> The PWM is only a set of Gates, Dividers and Counters.
> 
> We achieve a PWM output by calculating a clock that permits us to calculate
> 2 periods (low and high) and we set the counter to switch after N cycles
> for the first half period.
> 
> We do not have an explicit "polarity" setting, we simply reverse the period
> cycles (the low length is inversed with the high length).
> 
> To apply the dividers and counters, we need to disable the PWM input clock
> gate, set the dividers and counter and release the input gate.
> 
> So yes, we should maybe stop disabling the PWM for a long period of time
> when we calculate the new settings, it can be fixed easily by calculating
> the settings and applying in a separate code path.

If the hardware supports it the counter should not be stopped---most
other PWMs in my bubble can at least change the duty cycle as required.
(That is, complete the currently running period and that without delay
start a new period with the new settings.)
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
