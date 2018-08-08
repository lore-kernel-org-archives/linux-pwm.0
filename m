From: Aditya Prayoga <aditya@kobol.io>
Subject: Re: [PATCH RESEND 1/2] gpio: mvebu: Add support for multiple PWM
 lines per GPIO chip
Date: Wed, 8 Aug 2018 17:27:16 +0700
Message-ID: <CAFTRUBcQ1Kj8sPVFv=mSc1hdcUOTj9GT8ZfZckNmvVwgJWPczA@mail.gmail.com>
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
 <1533522556-55055-2-git-send-email-aditya@kobol.io> <20180806033802.GA32450@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806033802.GA32450@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: andrew@lunn.ch
Cc: linux-gpio@vger.kernel.org, richard.genoud@gmail.com, gregory.clement@bootlin.com, Gauthier Provost <gauthier@kobol.io>, alban.browaeys@gmail.com, thierry.reding@gmail.com, linus.walleij@linaro.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>, ralph.sennhauser@gmail.com
List-Id: linux-pwm@vger.kernel.org

On Mon, Aug 6, 2018 at 10:38 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 06, 2018 at 10:29:15AM +0800, Aditya Prayoga wrote:
>
> Hi Aditya
>
> > +     item = kzalloc(sizeof(*item), GFP_KERNEL);
> > +     if (!item)
> > +             return -ENODEV;
>
> ENOMEM would be better, since it is a memory allocation which is
> failing.
>
> >
> > -             ret = gpiod_direction_output(desc, 0);
> > -             if (ret) {
> > -                     gpiochip_free_own_desc(desc);
> > -                     goto out;
> > -             }
> > +     spin_lock_irqsave(&mvpwm->lock, flags);
> > +     desc = gpiochip_request_own_desc(&mvchip->chip,
> > +                                      pwm->hwpwm, "mvebu-pwm");
> > +     if (IS_ERR(desc)) {
> > +             ret = PTR_ERR(desc);
> > +             goto out;
> > +     }
> >
> > -             mvpwm->gpiod = desc;
> > +     ret = gpiod_direction_output(desc, 0);
> > +     if (ret) {
> > +             gpiochip_free_own_desc(desc);
> > +             goto out;
> >       }
> > +     item->gpiod = desc;
> > +     item->device = pwm;
> > +     INIT_LIST_HEAD(&item->node);
> > +     list_add_tail(&item->node, &mvpwm->pwms);
> >  out:
> >       spin_unlock_irqrestore(&mvpwm->lock, flags);
> >       return ret;
>
> You don't cleanup item on the error path.
>
> > @@ -630,12 +639,20 @@ static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> >  static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> >  {
> >       struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
> > +     struct mvebu_pwm_item *item, *tmp;
> >       unsigned long flags;
> >
> > -     spin_lock_irqsave(&mvpwm->lock, flags);
> > -     gpiochip_free_own_desc(mvpwm->gpiod);
> > -     mvpwm->gpiod = NULL;
> > -     spin_unlock_irqrestore(&mvpwm->lock, flags);
> > +     list_for_each_entry_safe(item, tmp, &mvpwm->pwms, node) {
> > +             if (item->device == pwm) {
> > +                     spin_lock_irqsave(&mvpwm->lock, flags);
> > +                     gpiochip_free_own_desc(item->gpiod);
> > +                     item->gpiod = NULL;
> > +                     item->device = NULL;
>
> Since you are about to free item, these two lines are pointless.
>
> > +                     list_del(&item->node);
> > +                     spin_unlock_irqrestore(&mvpwm->lock, flags);
> > +                     kfree(item);
> > +             }
> > +     }
> >  }
>
>    Andrew

Hi Andrew,

Thanks, I will fix it on next version.

Regards,

Aditya
