From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH] pwm: pca9685: fix pwm/gpio inter-operation
Date: Tue, 4 Jun 2019 09:34:46 -0400
Message-ID: <CAGngYiUc5_A1umM=8f12BLejq-3aqHnExEQ2RxNABv8u3HdqnA@mail.gmail.com>
References: <20190603151223.5311-1-TheSven73@gmail.com> <20190604091425.GL2781@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604091425.GL2781@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-pwm@vger.kernel.org

Thank you for the review, Mika ! See comments below.

On Tue, Jun 4, 2019 at 5:14 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> > This approach will also prevent the request of the "all" pwm channel, if any
> > other pwm channel is already in use. Is this correct behaviour?
>
> Sounds correct to me.

Something that occurred to me right after I pressed the send button:

This patch will prevent a pwm 'all channels' request if at least one
of the pwm's is in use. But it will not guard against the opposite:
after the 'all channels' pwm is requested, it will still allow requests
for other pwms/gpios !

This is identical to the old behaviour. But maybe this is an oversight
and not a feature?

Proposal:
1. prevent request of 'all channel' if any of the pwms/gpios are in use
2. prevent request of all other pwms/gpios if 'all channels' is in use

>
> Can we call it pca9685_pwm_test_and_set_inuse() following naming of
> test_and_set_bit()?

Sounds good to me.

> >
> > +static void pca9685_pwm_clear_inuse(struct pca9685 *pca, struct pwm_device *pwm)
>
> I think it might be better if you provide __pca9685_pwm_clear_inuse()
> that does not take the lock and then pca9685_pwm_clear_inuse() that just
> calls the former. Then ->

I agree, this is much cleaner.
