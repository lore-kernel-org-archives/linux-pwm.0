From: Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH v2 5/7] counter: add FlexTimer Module Quadrature decoder
 counter driver
Date: Mon, 11 Mar 2019 12:22:16 +0100
Message-ID: <CAKKE0ZHtFk=XvBLbUzZbdqjh-m5TewnH+P__=d=Yio8TinRFNQ@mail.gmail.com>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
 <20190306111208.7454-6-patrick.havelange@essensium.com> <20190307113147.GA7851@icarus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307113147.GA7851@icarus>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Esben Haabendal <esben@haabendal.dk>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, Mar 7, 2019 at 12:32 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> > +/*
> > + * take mutex
> > + * call ftm_clear_write_protection
> > + * update settings
> > + * call ftm_set_write_protection
> > + * release mutex
> > + */
>
> Jonathan mentioned it before in the previous review, and I think I agree
> too, that this comment block is superfluous: the context of this code is
> simple enough that the function call order is naturally obvious (i.e.
> write protection must be cleared before settings are modified).
>
> The only important thing to mention here is that the mutex must be held
> before the write protection state is modified so a comment along the
> following lines should suffice:
>
> /* hold mutex before modifying write protection state */

I think that keeping the more verbose comments is better. You directly see
what operations are needed, and is a good reminder, especially if you
are not familiar with the driver.
I'll use your comment on the next version if you insist (see below for
why new versoion).

> > +static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
> > +{
> > +     ftm_write(ftm, FTM_MODE, 0);
> > +}
>
> The ftm_quaddec_disable function is only used for cleanup when the
> driver is being removed. Is disabling the FTM counter on removal
> actually something we need to do?

It might provide some power-saving, so I would keep that function.

>
> While it's true that the register will keep updating, since the driver
> is no longer loaded, we don't care about that register value. Once we
> take control of the hardware again (by reloading our driver or via a new
> one), we reinitialize the counter and set the count value back to 0
> anyway -- so whatever value the register had no longer matters.
>
Indeed the previous values at start do not matter. It's there just to
shut down the device properly.
This discussion made me verify again the specs and in its current form
the disable doesn't even work at all :
 - That register should be written with write protection disabled (duh!)
 - It doesn't even stop the FTM from running, the clock must be
disabled for that.

So I'll probably provide a fix for that (in some days/weeks).

> > +
> > +enum ftm_quaddec_count_function {
> > +     FTM_QUADDEC_COUNT_ENCODER_MODE_1,
> > +};
>
> The FlexTimer Module supports more than just a quadrature counter mode
> doesn't it?
>
> We should keep this initial patch simple since we are still introducing
> the Counter subsystem, but it'll be nice to add support in the future
> for the other counter modes such as single-edge capture.

yes it provides more features, those are in a backlog ;). I would
prefer if this simple version(I mean, with the disable/shutdown fixed)
of the driver could be merged already before extending support.

>
> > +
> > +static struct counter_signal ftm_quaddec_signals[] = {
> > +     {
> > +             .id = 0,
> > +             .name = "Channel 1 Quadrature A"
> > +     },
> > +     {
> > +             .id = 1,
> > +             .name = "Channel 1 Quadrature B"
> > +     }
> > +};
>
> If possible, these names should match the FTM datasheet naming
> convention. The reason is to make it easier for users to match the
> input signals described in the datasheet with the Signal data provided
> by the Generic Counter interface.
>
> I think the FTM datasheet describes these signals as "Phase A" and
> "Phase B", so perhaps "Channel 1 Phase A" and "Channel 1 Phase B" may be
> more appropriate names in this case.

I'll verify those,

> > +static int ftm_quaddec_remove(struct platform_device *pdev)
> > +{
> > +     struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
> > +
> > +     counter_unregister(&ftm->counter);
> > +
> > +     ftm_quaddec_disable(ftm);
> > +
> > +     return 0;
> > +}
>
> If the ftm_quaddec_disable is not necessary, then we can eliminate the
> ftm_quaddec_remove function as well by replacing the counter_register
> call with a devm_counter_register call.

yes, but as stated before, I would keep it for potential energy saving.

Thanks for your feedback :)
