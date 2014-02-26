From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 4/9] pwm: renesas-tpu: Remove unnecessary OOM messages
Date: Wed, 26 Feb 2014 11:34:54 +0900
Message-ID: <000201cf329b$55607c20$00217460$%han@samsung.com>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
 <000c01cf328f$376b8860$a6429920$%han@samsung.com> <1426883.W6NvH3R36B@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:25651 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbaBZCe7 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2014 21:34:59 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1L0082I0I71260@mailout2.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 26 Feb 2014 11:34:55 +0900 (KST)
In-reply-to: <1426883.W6NvH3R36B@avalon>
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Joe Perches' <joe@perches.com>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>
Cc: 'Thierry Reding' <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, 'Laurent Pinchart' <laurent.pinchart+renesas@ideasonboard.com>, 'Simon Horman' <horms@verge.net.au>, 'Jingoo Han' <jg1.han@samsung.com>

On Wednesday, February 26, 2014 11:22 AM, Laurent Pinchart wrote:
> On Wednesday 26 February 2014 10:08:10 Jingoo Han wrote:
> > The site-specific OOM messages are unnecessary, because they
> > duplicate the MM subsystem generic OOM message.
> 
> While an allocation failure for such a small piece of memory will mean that
> we're in trouble far too big for an error message to matter, have you made
> sure that all devm_kzalloc() error paths lead to an OOM message being printed
> ?

(+cc Joe Perches, Andrew Morton)

Hi Laurent Pinchart,
Long time no see! Thank you for your comment.
I am not sure that I understand your question exactly.
I believe that all devm_kzalloc() error paths lead to
an OOM message being printed, because k.alloc and v.alloc
failures use dump_stack().

Joe Perches,
Would you add some comments on this?
If I am wrong, please let me know.

Best regards,
Jingoo Han

> 
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/pwm/pwm-renesas-tpu.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> > index aff6ba9..cc13ff4 100644
> > --- a/drivers/pwm/pwm-renesas-tpu.c
> > +++ b/drivers/pwm/pwm-renesas-tpu.c
> > @@ -405,10 +405,8 @@ static int tpu_probe(struct platform_device *pdev)
> >  	int ret;
> >
> >  	tpu = devm_kzalloc(&pdev->dev, sizeof(*tpu), GFP_KERNEL);
> > -	if (tpu == NULL) {
> > -		dev_err(&pdev->dev, "failed to allocate driver data\n");
> > +	if (tpu == NULL)
> >  		return -ENOMEM;
> > -	}
> >
> >  	spin_lock_init(&tpu->lock);
> >  	tpu->pdev = pdev;

