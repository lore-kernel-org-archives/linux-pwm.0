From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered down
Date: Tue, 25 Jun 2019 00:02:02 +0200
Message-ID: <CACRpkdY4xgtYVto8fM-TSGWbDEsJpj=Fx2zXHPaZTJ6m1JuWQw@mail.gmail.com>
References: <20190522163428.7078-1-paul@crapouillou.net> <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
 <20190621135608.GB11839@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621135608.GB11839@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Paul Cercueil <paul@crapouillou.net>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, od@zcrc.me, linux-pwm@vger.kernel.org, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 21, 2019 at 3:56 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> I'm not sure this would actually work because I think the way that
> pinctrl handles states both "init" and "idle" would be the same pointer
> values and therefore pinctrl_init_done() would think the driver didn't
> change away from the "init" state because it is the same pointer value
> as the "idle" state that the driver selected.

Right.

> One way to work around
> that would be to duplicate the "idle" state definition and associate one
> instance of it with the "idle" state and the other with the "init"
> state. At that point both states should be different (different pointer
> values) and we'd get the init state selected automatically before probe,
> select "idle" during probe and then the core will leave it alone. That's
> of course ugly because we duplicate the pinctrl state in DT, but perhaps
> it's the least ugly solution.

If something needs special mockery and is not generic, I'd just
come up with whatever string PWM needs, like
"pwm-idle", "pwm-sleep", "pwm-init" etc instead of
complicating the stuff done before probe(). These states are
only handled there to make probe() simple in simple cases.

> Adding Linus for visibility. Perhaps he can share some insight.

I think Paul hashed it out. Or will.

> On that note, I'm wondering if perhaps it'd make sense for pinctrl to
> support some mode where a device would start out in idle mode. That is,
> where pinctrl_bind_pins() would select the "idle" mode as the default
> before probe. With something like that we could easily support this
> use-case without glitching.

I would say the driver can come up with whatever state it need for
that and handle it explicitly. When there are so many of them that
it warrants growing the device core, we can move it into
drivers/base/pinctrl.c. But no upfront design.

> I suppose yet another variant would be for the PWM backlight to not use
> any of the standard pinctrl states at all. Instead it could just define
> custom states, say "active" and "inactive".

I would suggest doing that.

> Looking at the code that
> would prevent pinctrl_bind_pins() from doing anything with pinctrl
> states and given the driver exact control over when each of the states
> will be selected. That's somewhat suboptimal because we can't make use
> of the pinctrl PM helpers and it'd require more boilerplate.

The helpers are just for the dirt-simple cases anyway.
At one point one developer thought that the "default" set up
before probe would be the only thing any system would ever
want to do with pin control. It seems like not.

Yours,
Linus Walleij
