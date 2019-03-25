From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
Date: Mon, 25 Mar 2019 18:41:57 +0100
Message-ID: <CAFBinCAn-9oETMKMfSXoJOMBrQyrCFN7AyHG02bQaoxG1px3YA@mail.gmail.com>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com> <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: thierry.reding@gmail.com, Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello Uwe,

On Mon, Mar 25, 2019 at 9:41 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Martin,
>
> On Sun, Mar 24, 2019 at 11:02:16PM +0100, Martin Blumenstingl wrote:
> > Back in January a "BUG: scheduling while atomic" error showed up during
> > boot on my Meson8b Odroid-C1 (which uses a PWM regulator as CPU supply)=
.
> > The call trace comes down to:
> >   __mutex_lock
> >   clk_prepare_lock
> >   clk_core_get_rate
> >   meson_pwm_apply
> >   ..
> >   dev_pm_opp_set_rate
> >   ..
> >
> > Jerome has also seen the same problem but from pwm-leds (instead of a
> > pwm-regulator). He posted a patch which replaces the spinlock with a
> > mutex. That works. I believe we can optimize this by reducing the time
> > where the lock is held - that also allows to keep the spin-lock.
> >
> > Analyzing this issue helped me understand the pwm-meson driver better.
> > My plan is to send some cleanups (with the goal of re-using more of the
> > goodies from the PWM core in the pwm-meson driver) after this single fi=
x
> > is merged (they can be found here: [1]).
>
> I didn't look over these in detail, but I see an issue that according
> to the shortlogs isn't addressed: In the .apply callback there is
> (simplified):
>
>         if (!state->enabled) {
>                 meson_pwm_disable(meson, pwm->hwpwm);
>                 return;
>         }
>
> This results in the wrong output after:
>
>         pwm_apply_state(pwm, { .enabled =3D true, .polarity =3D PWM_POLAR=
ITY_NORMAL, ...});
>         pwm_apply_state(pwm, { .enabled =3D false, .polarity =3D PWM_POLA=
RITY_INVERTED, ...});
>
> because the polarity isn't checked.
let me rephrase this to make sure I understand this correctly:
- applying a PWM state with .enabled =3D true and PWM_POLARITY_NORMAL
will enable the PWM output
- applying a PWM state with .enabled =3D false and PWM_POLARITY_NORMAL
will disable the PWM output
- applying a PWM state with .enabled =3D true and PWM_POLARITY_INVERTED
will disable the PWM output
- applying a PWM state with .enabled =3D false and PWM_POLARITY_INVERTED
will enable the PWM output

in other words: the polarity doesn't only apply to period and
duty_cycle but also to the enabled state.

> If you want to implement further cleanups, my questions and propositions
> are:
>
>  - Is there a publicly available manual for this hardware? If yes, you
>    can add a link to it in the header of the driver.
yes, it's documented in the public S912 datasheet [0] page 542 and followin=
g
I'll add a patch which adds the link to the driver

>  - Why do you handle reparenting of the PWM's clk in .request? Wouldn't
>    this be more suitable in .apply?
Jerome's answer (not long after yours) basically covers this:
- the assigned-clock-parents property could have been used but it wasn't
- the driver could automatically set the correct parent, but this
isn't implemented

(I assume this was done to keep it short and simple to for the first
version of the driver)

>  - Does stopping the PWM (i.e. clearing MISC_{A,B}_EN in the MISC_AB
>    register) freeze the output, or is the currently running period
>    completed first? (The latter is the right behaviour.)
I don't know, I would have to measure this with a logic analyzer.
can you please explain why this is important?

>  - Please point out in the header that for changing period/duty
>    cycle/polarity the hardware must be stopped. (I suggest to apply the
>    style used in https://www.spinics.net/lists/linux-pwm/msg09262.html
>    for some consistency.)
I'm not sure about this. Amlogic's vendor kernel uses a modified
version of this driver [1] which has an explicit comment not to
disable the PWM output when changing the period/duty cycle.
the PWM is configured with two separate registers (PWM_MISC_REG_AB
contains the divider and PWM_PWM_A contains the high/low count).
there's a short timeframe where the PWM output signal is neither the
"old setting" nor the "new setting" (but rather a mix of both). what
do other PWM drivers do in this case (if this is a common thing)?

> Another thing I just noted: The .get_state callback only sets .enabled
> but nothing of the remaining information is provided.
as far as I can see the PWM core uses .get_state only during registration:
this means we should read (and calculate) .duty_cycle and .period from
the register values. polarity always has to be "normal" since there's
no information about it in the registers.


Regards
Martin


[0] https://dl.khadas.com/Hardware/VIM2/Datasheet/S912_Datasheet_V0.2201703=
14publicversion-Wesion.pdf
[1] https://github.com/hardkernel/linux/blob/9a4a1f4b14fe66d7ebd73323b39fbf=
3bda9e1356/drivers/amlogic/pwm/pwm_meson.c#L381
