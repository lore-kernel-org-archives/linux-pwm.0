From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle struct element
Date: Mon, 30 Mar 2020 16:18:22 +0300
Message-ID: <CAHp75Vc_=czuRtyqgnmnYfie50gDnzrNqq3Bt+Gp_42MikX6VA@mail.gmail.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com> <20200330130743.GB2431644@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200330130743.GB2431644@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Mar 30, 2020 at 4:09 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Feb 26, 2020 at 02:52:26PM +0100, Matthias Schiffer wrote:
> > duty_cycle was only set, never read.
> >
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 4 ----
> >  1 file changed, 4 deletions(-)
>
> Applied, thanks.

I'm not sure this patch is correct.
We already have broken GPIO in this driver. Do we need more breakage?

-- 
With Best Regards,
Andy Shevchenko
