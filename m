From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 5/9] pwm: spear: Remove unnecessary OOM messages
Date: Wed, 26 Feb 2014 13:57:20 +0900
Message-ID: <000501cf32af$3ad0ecf0$b072c6d0$%han@samsung.com>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
 <000d01cf328f$687d54b0$3977fe10$%han@samsung.com>
 <CAKohpo=xbZ4RNLDtdP3PokQwQksiKRBnuOTPL5z_zywwyOJC3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:33073 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbaBZE50 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2014 23:57:26 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1L0069A73KNQ60@mailout3.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 26 Feb 2014 13:57:21 +0900 (KST)
In-reply-to: <CAKohpo=xbZ4RNLDtdP3PokQwQksiKRBnuOTPL5z_zywwyOJC3w@mail.gmail.com>
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>
Cc: 'Thierry Reding' <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, 'Shiraz Hashim' <shiraz.hashim@st.com>, 'Jingoo Han' <jg1.han@samsung.com>, 'Joe Perches' <joe@perches.com>, 'Andrew Morton' <akpm@linux-foundation.org>

On Wednesday, February 26, 2014 1:49 PM, Viresh Kumar wrote:
> On 26 February 2014 06:39, Jingoo Han <jg1.han@samsung.com> wrote:
> > The site-specific OOM messages are unnecessary, because they
> > duplicate the MM subsystem generic OOM message.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/pwm/pwm-spear.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
> > index 8ad26b8..b4f6d0d 100644
> > --- a/drivers/pwm/pwm-spear.c
> > +++ b/drivers/pwm/pwm-spear.c
> > @@ -179,10 +179,8 @@ static int spear_pwm_probe(struct platform_device *pdev)
> >         u32 val;
> >
> >         pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> > -       if (!pc) {
> > -               dev_err(&pdev->dev, "failed to allocate memory\n");
> 
> Can you please pin point which/file line will print similar message ?

(+cc Joe Perches, Andrew Morton)

Sorry, I cannot pin point the exact file line.
As far as I know, the similar message will be printed,
because k.alloc and v.alloc failures use dump_stack(). 

Best regards,
Jingoo Han

