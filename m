From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] pwm: improve args checking in pwm_apply_state()
Date: Wed, 22 Jun 2016 16:32:22 +0200
Message-ID: <CAMuHMdUUrYj_rwVPw2YXYUq_aPzQgUR=VEP0gRvH4n3C2uE_GA@mail.gmail.com>
References: <1464367549-111530-1-git-send-email-briannorris@chromium.org>
 <CAMuHMdUVgwb8QwKcORDuoJUCJJKE7Xmzg3R45S1VdnupAXUx0w@mail.gmail.com>
 <20160621183730.GA130978@google.com> <20160622100422.5c34f975@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160622100422.5c34f975@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Brian Norris <briannorris@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-renesas-soc@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-pwm@vger.kernel.org

Hi Boris,

On Wed, Jun 22, 2016 at 10:04 AM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> On Tue, 21 Jun 2016 11:37:31 -0700
> Brian Norris <briannorris@chromium.org> wrote:
>> On Tue, Jun 21, 2016 at 04:42:04PM +0200, Geert Uytterhoeven wrote:
>> > On Fri, May 27, 2016 at 6:45 PM, Brian Norris <briannorris@chromium.org> wrote:
>> > > It seems like in the process of refactoring pwm_config() to utilize the
>> > > newly-introduced pwm_apply_state() API, some args/bounds checking was
>> > > dropped.
>> > >
>> > > In particular, I noted that we are now allowing invalid period
>> > > selections. e.g.:
>> > >
>> > >   # echo 1 > /sys/class/pwm/pwmchip0/export
>> > >   # cat /sys/class/pwm/pwmchip0/pwm1/period
>> > >   100
>> > >   # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
>> > >   [... driver may or may not reject the value, or trigger some logic bug ...]
>> > >
>> > > It's better to see:
>> > >
>> > >   # echo 1 > /sys/class/pwm/pwmchip0/export
>> > >   # cat /sys/class/pwm/pwmchip0/pwm1/period
>> > >   100
>> > >   # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
>> > >   -bash: echo: write error: Invalid argument
>> > >
>> > > This patch reintroduces some bounds checks in both pwm_config() (for its
>> > > signed parameters; we don't want to convert negative values into large
>> > > unsigned values) and in pwm_apply_state() (which fix the above described
>> > > behavior, as well as other potential API misuses).
>> > >
>> > > Fixes: 5ec803edcb70 ("pwm: Add core infrastructure to allow atomic updates")
>> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
>> > > ---
>> > > v2:
>> > >  * changed subject, as this covers more scope now
>> > >  * add Fixes tag, as this is a v4.7-rc regression
>> > >  * add more bounds/args checks in pwm_apply_state() and pwm_config()
>> > >
>> > >  drivers/pwm/core.c  | 3 ++-
>> > >  include/linux/pwm.h | 3 +++
>> > >  2 files changed, 5 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>> > > index dba3843c53b8..ed337a8c34ab 100644
>> > > --- a/drivers/pwm/core.c
>> > > +++ b/drivers/pwm/core.c
>> > > @@ -457,7 +457,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
>> > >  {
>> > >         int err;
>> > >
>> > > -       if (!pwm)
>> > > +       if (!pwm || !state || !state->period ||
>> > > +           state->duty_cycle > state->period)
>> > >                 return -EINVAL;
>> >
>> > This check breaks the LCD backlight on r8a7740/armadillo.

>> I'm not sure I 100% understand this debug log, but I think maybe the
>> problem is in pwm_apply_args(), which calls pwm_disable() and
>> pwm_set_polarity() sequentially, without ever configuring a period? What
>> if pwm_apply_args() were to configure the period for us?
>>
>> Boris, any thoughts?
>>
>
> I had second thoughts and I think you're right: pwm_apply_args()
> should set the pargs.period period for us.
>
> Here is a patch addressing that.
>
> Geert, can you test it?
>
> --->8---
> From 0610f7e24976e176054bce20445ff42d8aea9513 Mon Sep 17 00:00:00 2001
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> Date: Wed, 22 Jun 2016 09:25:14 +0200
> Subject: [PATCH] pwm: Fix pwm_apply_args()
>
> Commit 5ec803edcb70 ("pwm: Add core infrastructure to allow atomic
> updates"), implemented pwm_disable() as a wrapper around
> pwm_apply_state(), and then, commit ef2bf4997f7d ("pwm: Improve args
> checking in pwm_apply_state()") added missing checks on the ->period
> value in pwm_apply_state() to ensure we were not passing inappropriate
> values to the ->config() or ->apply() methods.
>
> The conjunction of these 2 commits led to a case where pwm_disable()
> was no longer succeeding, thus preventing the polarity setting done
> in pwm_apply_args().
>
> Set a valid period in pwm_apply_args() to ensure polarity setting
> won't be rejected.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Brian Norris <briannorris@chromium.org>
> Fixes: 5ec803edcb70 ("pwm: Add core infrastructure to allow atomic updates")

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
