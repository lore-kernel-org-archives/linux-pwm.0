From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: mvebu: clear irq in edge cause register before
 unmask edge irq
Date: Wed, 15 Jan 2020 14:26:43 +0100
Message-ID: <CACRpkdbefJsH2km3p433NN2koNck7hgNqLWpD3q4r=Um75GZEw@mail.gmail.com>
References: <20200115073811.24438-1-bigunclemax@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200115073811.24438-1-bigunclemax@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Maxim <bigunclemax@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-pwm@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, Jan 15, 2020 at 8:40 AM Maxim <bigunclemax@gmail.com> wrote:

> From: Maxim Kiselev <bigunclemax@gmail.com>
>
> When input GPIO set from 0 to 1, the interrupt bit asserted in the GPIO
> Interrupt Cause Register (ICR) even if the corresponding interrupt
> masked in the GPIO Interrupt Mask Register.
>
> Because interrupt mask register only affects assertion of the interrupt
> bits in Main Interrupt Cause Register and it does not affect the
> setting of bits in the GPIO ICR.
>
> So, there is problem, when we unmask interrupt with already
> asserted bit in the GPIO ICR, then false interrupt immediately occurs
> even if GPIO don't change their value since last unmask.
>
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>

This looks correct to me, a review from the MVEBU maintainers
would be appreciated.

- Should it be applied to fixes as a regression fix?

- Should it be tagged for stable?

Yours.
Linus Walleij
