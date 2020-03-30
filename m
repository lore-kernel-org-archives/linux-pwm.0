From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Date: Mon, 30 Mar 2020 16:19:55 +0300
Message-ID: <CAHp75VeY9ZGUD_=N=R2vsJFY-4P5-L1+ZzjKHU2cygcbML0zOw@mail.gmail.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com> <20200330130757.GC2431644@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200330130757.GC2431644@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Mar 30, 2020 at 4:10 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer wrote:
> > The interaction of the ALL_LED PWM channel with the other channels was
> > not well-defined. As the ALL_LED feature does not seem very useful and
> > it was making the code significantly more complex, simply remove it.
> >
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 115 ++++++--------------------------------
> >  1 file changed, 17 insertions(+), 98 deletions(-)
>
> Applied, thanks.

This seems to be ABI breakage.

Thierry, do you have hardware to test?


-- 
With Best Regards,
Andy Shevchenko
