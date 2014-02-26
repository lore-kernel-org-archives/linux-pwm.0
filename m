From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 5/9] pwm: spear: Remove unnecessary OOM messages
Date: Tue, 25 Feb 2014 21:19:17 -0800
Message-ID: <1393391957.407.1.camel@joe-AO722>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
	 <000d01cf328f$687d54b0$3977fe10$%han@samsung.com>
	 <CAKohpo=xbZ4RNLDtdP3PokQwQksiKRBnuOTPL5z_zywwyOJC3w@mail.gmail.com>
	 <000501cf32af$3ad0ecf0$b072c6d0$%han@samsung.com>
	 <CAKohpon44tVo7K-tPQns1yfs4pBNy9-vY5UPocrHfSPbQ7M5_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:33367 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750732AbaBZFZ4 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2014 00:25:56 -0500
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 631D0212DB0
	for <linux-pwm@vger.kernel.org>; Wed, 26 Feb 2014 05:19:30 +0000 (UTC)
In-Reply-To: <CAKohpon44tVo7K-tPQns1yfs4pBNy9-vY5UPocrHfSPbQ7M5_A@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jingoo Han <jg1.han@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Wed, 2014-02-26 at 10:40 +0530, Viresh Kumar wrote:
> On 26 February 2014 10:27, Jingoo Han <jg1.han@samsung.com> wrote:
> > On Wednesday, February 26, 2014 1:49 PM, Viresh Kumar wrote:
> >> On 26 February 2014 06:39, Jingoo Han <jg1.han@samsung.com> wrote:
> >> > The site-specific OOM messages are unnecessary, because they
> >> > duplicate the MM subsystem generic OOM message.
> >> >
> >> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> >> > ---
> >> >  drivers/pwm/pwm-spear.c |    4 +---
> >> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >> >
> >> > diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
> >> > index 8ad26b8..b4f6d0d 100644
> >> > --- a/drivers/pwm/pwm-spear.c
> >> > +++ b/drivers/pwm/pwm-spear.c
> >> > @@ -179,10 +179,8 @@ static int spear_pwm_probe(struct platform_device *pdev)
> >> >         u32 val;
> >> >
> >> >         pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> >> > -       if (!pc) {
> >> > -               dev_err(&pdev->dev, "failed to allocate memory\n");
> >>
> >> Can you please pin point which/file line will print similar message ?
> >
> > (+cc Joe Perches, Andrew Morton)
> >
> > Sorry, I cannot pin point the exact file line.
> > As far as I know, the similar message will be printed,
> > because k.alloc and v.alloc failures use dump_stack().
> 
> I have tried tracing calls here and I am unable to find
> any such prints from these routines for majority of
> failure paths. So its better somebody tells me that I am
> wrong here :)

Look at warn_alloc_failed() in mm/page_alloc.c


