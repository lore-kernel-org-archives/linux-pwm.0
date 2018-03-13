Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <TY1PR06MB0992451635511B45D8D7C345D8D20@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <1520596498-4801-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1520596498-4801-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdV-vutHutGJnOhqJ14_+-ig2jzFakeWzOxBy+5F6XRFXw@mail.gmail.com> <TY1PR06MB0992451635511B45D8D7C345D8D20@TY1PR06MB0992.apcprd06.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 Mar 2018 08:31:58 +0100
Message-ID: <CAMuHMdXoJNZBcgTvryd0a7FfAngR_dYBwxV5GewwFAuCHSuspg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: rcar: add suspend/resume support
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pwm.vger.kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Shimoda-san,

On Tue, Mar 13, 2018 at 8:04 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>> From: Geert Uytterhoeven, Sent: Friday, March 9, 2018 9:53 PM
>> On Fri, Mar 9, 2018 at 12:54 PM, Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh@renesas.com> wrote:
>> > This patch adds suspend/resume support for Renesas PWM driver.
>> >
>> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>
>> Thanks for your patch!
>
> Thank you for your review!
>
>> > --- a/drivers/pwm/pwm-rcar.c
>> > +++ b/drivers/pwm/pwm-rcar.c
>> > @@ -254,11 +254,38 @@ static int rcar_pwm_remove(struct platform_device *pdev)
>> >  };
>> >  MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
>> >
>> > +#ifdef CONFIG_PM_SLEEP
>> > +static int rcar_pwm_suspend(struct device *dev)
>> > +{
>> > +       pm_runtime_put(dev);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static int rcar_pwm_resume(struct device *dev)
>> > +{
>> > +       struct platform_device *pdev = to_platform_device(dev);
>> > +       struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
>> > +       struct pwm_chip *chip = &rcar_pwm->chip;
>> > +       struct pwm_device *pwm = &chip->pwms[0];
>> > +
>> > +       pm_runtime_get_sync(dev);
>>
>> This enables the module clock unconditionally, so you can restore the
>> register values below...
>>
>> > +       rcar_pwm_config(chip, pwm, pwm->state.duty_cycle, pwm->state.period);
>> > +       if (pwm_is_enabled(pwm))
>> > +               rcar_pwm_enable(chip, pwm);
>>
>> ... but shouldn't you disable the clock again if the PWM is not in use,
>> like below?
>>
>>         else
>>                 pm_runtime_put(dev);
>
> Thank you for the pointing out.
> I realize that this suspend/resume function should check PWMF_REQUESTED condition
> because this driver enables the clock after the .request(rcar_pwm_request) was called.
> So, I will fix this patch in v2.

OK.

> Also, reducing power point of view, this driver should call not pm_runtime_get_sync/put()
> in _request/_free(). But, I would like to implement such code as a next step :)

That makes sense.  I was already wondering whether those are the best
locations to call the pm_runtime_*() functions, but I'm not sufficiently
familiar with the PWM subsystem.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
