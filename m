From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
Date: Mon, 25 Mar 2019 19:04:05 +0100
Message-ID: <CAFBinCCPW8wAoiN4hjj9tAYSqQqChpSB6+urAiXU95VYaZZKGg@mail.gmail.com>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com> <47e944da1c3b0a11cf46fc5ad5678ba961b9f9d3.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <47e944da1c3b0a11cf46fc5ad5678ba961b9f9d3.camel@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: thierry.reding@gmail.com, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Jerome,

On Mon, Mar 25, 2019 at 10:35 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Sun, 2019-03-24 at 23:02 +0100, Martin Blumenstingl wrote:
> > Back in January a "BUG: scheduling while atomic" error showed up during
> > boot on my Meson8b Odroid-C1 (which uses a PWM regulator as CPU supply).
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
> > goodies from the PWM core in the pwm-meson driver) after this single fix
> > is merged (they can be found here: [1]).
>
> Thanks for fixing this Martin.
you're welcome!

> As for the future enhancement, I'd like to know what you have in mind.
> As I have told you previously, I think the clock bindings of this driver are
> not great.
>
> The global name of the input clocks are hard coded in this driver and it
> sucks. CCF is evolving to rely less on these global names.
I fully agree with you on the clock setup, but I'm not sure if we have
to break the dt-bindings for it.

the datasheet notes: "Each PWM is driven by a programmable divider
driven by a 4:1 clock selector".
In my own words this means that each PWM controller has up to 8 clock inputs:
- up to 4 inputs for the first channel (PWM_A)
- up to 4 inputs for the second channel (PWM_B)

the current pwm-meson driver assumes that both the inputs for both
channels are identical.
the "clock trees" section of the public S912 datasheet (page 65)
clearly documents the clock inputs per PWM channel, not per PWM
controller.

Thus I believe we should name our clock-names (the inputs to the PWM
controller) "pwm-a-clkin0", "pwm-a-clkin1", "pwm-b-clkin0", ...
That way we don't have a conflict with the existing bindings (which
already reserve "clkin0" and "clkin1").

> In addition, the 'clock' binding should be used to refer to the clock
> 'consumed' by the device, not to define a setting (as done now). 'assigned-
> clock' binding can be used for that.
using the assigned-clock* properties requires self-referencing the PWM
controller (which I'm not used to), for example:
  &pwm_ab {
      #clock-cells = <1>;
      assigned-clocks = <&pwm_ab 0>, <&pwm_ab 1>; /* references itself */
      assigned-clock-parents = <&xtal>, <&clkc CLKID_FCLK_DIV5>;
  };

if we want to auto-detect the parent clock (like you suggested below)
we need to consider if we can detect whether a .dts-author assigned a
specific parent.
I know that it's easy to detect this when the clock is passed in the
"clocks" property, but I'm not sure if it's easy to parse it from the
assigned-clocks/assigned-clock-parents properties.

[...]
> Last, instead of specifying the parent to be used, I think we should come up
> with some code to let the driver pick the most appropriate parent for the period/duty requested.
that will make it easier for .dts authors.
I would like to postpone this until we have solved the other topics though.


Regards
Martin


[0] https://dl.khadas.com/Hardware/VIM2/Datasheet/S912_Datasheet_V0.220170314publicversion-Wesion.pdf
