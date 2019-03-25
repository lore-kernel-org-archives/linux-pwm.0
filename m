From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
Date: Mon, 25 Mar 2019 21:07:30 +0100
Message-ID: <20190325200730.cx73jgxfexz6ybzq@pengutronix.de>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
 <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
 <CAFBinCAn-9oETMKMfSXoJOMBrQyrCFN7AyHG02bQaoxG1px3YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFBinCAn-9oETMKMfSXoJOMBrQyrCFN7AyHG02bQaoxG1px3YA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: thierry.reding@gmail.com, Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Hello Martin,

On Mon, Mar 25, 2019 at 06:41:57PM +0100, Martin Blumenstingl wrote:
> On Mon, Mar 25, 2019 at 9:41 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Sun, Mar 24, 2019 at 11:02:16PM +0100, Martin Blumenstingl wrote:
> > > Analyzing this issue helped me understand the pwm-meson driver better.
> > > My plan is to send some cleanups (with the goal of re-using more of the
> > > goodies from the PWM core in the pwm-meson driver) after this single fix
> > > is merged (they can be found here: [1]).
> >
> > I didn't look over these in detail, but I see an issue that according
> > to the shortlogs isn't addressed: In the .apply callback there is
> > (simplified):
> >
> >         if (!state->enabled) {
> >                 meson_pwm_disable(meson, pwm->hwpwm);
> >                 return;
> >         }
> >
> > This results in the wrong output after:
> >
> >         pwm_apply_state(pwm, { .enabled = true, .polarity = PWM_POLARITY_NORMAL, ...});
> >         pwm_apply_state(pwm, { .enabled = false, .polarity = PWM_POLARITY_INVERTED, ...});
> >
> > because the polarity isn't checked.
> let me rephrase this to make sure I understand this correctly:
> - applying a PWM state with .enabled = true and PWM_POLARITY_NORMAL
> will enable the PWM output
> - applying a PWM state with .enabled = false and PWM_POLARITY_NORMAL
> will disable the PWM output
> - applying a PWM state with .enabled = true and PWM_POLARITY_INVERTED
> will disable the PWM output
> - applying a PWM state with .enabled = false and PWM_POLARITY_INVERTED
> will enable the PWM output
> 
> in other words: the polarity doesn't only apply to period and
> duty_cycle but also to the enabled state.

You're wrong (I think):

 - if .enabled = true, you should configure the output to repeat the
   following pattern: be active for $duty_cycle ns and then inactive for
   the rest of $period ns.

 - if .enabled = false, you should configure the output to be constant
   inactive.

 - if .polarity = PWM_POLARITY_NORMAL we have: inactive = low, active =
   high

 - if .polarity = PWM_POLARITY_INVERTED we have: inactive = high, active =
   low

So after the two pwm_apply_state above the expectation is that the
output is constant high. But as the meson driver's apply function
doesn't check for .polarity when .enabled = false is requested the
result is probably constant low. (Unless the driver is still more broken
and doesn't ensure the output gets inactive on .disable().)

> > If you want to implement further cleanups, my questions and propositions
> > are:
> >
> >  - Is there a publicly available manual for this hardware? If yes, you
> >    can add a link to it in the header of the driver.
> yes, it's documented in the public S912 datasheet [0] page 542 and following
> I'll add a patch which adds the link to the driver
> 
> >  - Why do you handle reparenting of the PWM's clk in .request? Wouldn't
> >    this be more suitable in .apply?
> Jerome's answer (not long after yours) basically covers this:
> - the assigned-clock-parents property could have been used but it wasn't
> - the driver could automatically set the correct parent, but this
> isn't implemented
> 
> (I assume this was done to keep it short and simple to for the first
> version of the driver)

I don't know how assigned-clock-parents works, but maybe it is even
simpler to use than the hardcoding that currently is used in the driver?
 
> >  - Does stopping the PWM (i.e. clearing MISC_{A,B}_EN in the MISC_AB
> >    register) freeze the output, or is the currently running period
> >    completed first? (The latter is the right behaviour.)
> I don't know, I would have to measure this with a logic analyzer.

In practise you can do this with a multimeter, too. Just do something
like:

	pwm_apply_state({ .enabled = true, .period = 5s, .duty_cycle = 5s, .polarity = PWM_POLARITY_NORMAL });
	pwm_apply_state({ .enabled = false, .period = 5s, .duty_cycle = 5s, .polarity = PWM_POLARITY_NORMAL });

(assuming the PWM supports periods that long). The expectation is that
the last command takes nearly 5 s to complete and while it waits the
output is high and on return it's low. If that isn't the case, there is
a bug somewhere.

> can you please explain why this is important?

Well, that's the semantic that the PWM API promises to its users.
Up to now this is poorly documented, there is an RFC patch waiting for
review that improves the situation.

> >  - Please point out in the header that for changing period/duty
> >    cycle/polarity the hardware must be stopped. (I suggest to apply the
> >    style used in https://www.spinics.net/lists/linux-pwm/msg09262.html
> >    for some consistency.)
> I'm not sure about this. Amlogic's vendor kernel uses a modified
> version of this driver [1] which has an explicit comment not to
> disable the PWM output when changing the period/duty cycle.

That would be better as stopping the driver also violates the API's
requirements. If this is not a hardware imposed limit, it would be great
to fix the driver accordingly.

> the PWM is configured with two separate registers (PWM_MISC_REG_AB
> contains the divider and PWM_PWM_A contains the high/low count).
> there's a short timeframe where the PWM output signal is neither the
> "old setting" nor the "new setting" (but rather a mix of both). what
> do other PWM drivers do in this case (if this is a common thing)?

If this cannot be prevented in hardware, I think this should be
documented clearly at the top of the driver. Up to now this kind of
problem isn't (TTBOMK) well tracked and questions like "How many drivers
suffer from $problem" cannot be easily answered.
(A bit unrelated: I think the violation that disabling a PWM doesn't
complete the currently running period is a common one. But because the
corresponding questions where not asked for new driver submissions until
recently, this is untracked and probably driver authors are not even
aware of this requirement.)

> > Another thing I just noted: The .get_state callback only sets .enabled
> > but nothing of the remaining information is provided.
> as far as I can see the PWM core uses .get_state only during registration:
> this means we should read (and calculate) .duty_cycle and .period from
> the register values. polarity always has to be "normal" since there's
> no information about it in the registers.

So you can change the polarity, but you cannot read that information
back? That's another item for the list of limitations.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
