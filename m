From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 4/9] pwm: renesas-tpu: Remove unnecessary OOM messages
Date: Wed, 26 Feb 2014 23:02:50 +0100
Message-ID: <3505521.zmSNmayePP@avalon>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com> <1426883.W6NvH3R36B@avalon> <000201cf329b$55607c20$00217460$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:46322 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880AbaBZWBa (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2014 17:01:30 -0500
In-Reply-To: <000201cf329b$55607c20$00217460$%han@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Joe Perches' <joe@perches.com>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Thierry Reding' <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, 'Laurent Pinchart' <laurent.pinchart+renesas@ideasonboard.com>, 'Simon Horman' <horms@verge.net.au>

Hi Jingoo,

On Wednesday 26 February 2014 11:34:54 Jingoo Han wrote:
> On Wednesday, February 26, 2014 11:22 AM, Laurent Pinchart wrote:
> > On Wednesday 26 February 2014 10:08:10 Jingoo Han wrote:
> > > The site-specific OOM messages are unnecessary, because they
> > > duplicate the MM subsystem generic OOM message.
> > 
> > While an allocation failure for such a small piece of memory will mean
> > that we're in trouble far too big for an error message to matter, have you
> > made sure that all devm_kzalloc() error paths lead to an OOM message being
> > printed ?
> 
> (+cc Joe Perches, Andrew Morton)
> 
> Hi Laurent Pinchart,
> Long time no see! Thank you for your comment.

You're welcome.

> I am not sure that I understand your question exactly.
> I believe that all devm_kzalloc() error paths lead to
> an OOM message being printed, because k.alloc and v.alloc
> failures use dump_stack().

There's so many error code paths in the slab allocator that I got a bit lost, 
I was just wondering if all of them ended up with a message being printed. 
It's very probably needless worrying from my side.

> Joe Perches,
> Would you add some comments on this?
> If I am wrong, please let me know.
> 
> Best regards,
> Jingoo Han
> 
> > > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > > ---
> > > 
> > >  drivers/pwm/pwm-renesas-tpu.c |    4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pwm/pwm-renesas-tpu.c
> > > b/drivers/pwm/pwm-renesas-tpu.c
> > > index aff6ba9..cc13ff4 100644
> > > --- a/drivers/pwm/pwm-renesas-tpu.c
> > > +++ b/drivers/pwm/pwm-renesas-tpu.c
> > > @@ -405,10 +405,8 @@ static int tpu_probe(struct platform_device *pdev)
> > >  	int ret;
> > >  	
> > >  	tpu = devm_kzalloc(&pdev->dev, sizeof(*tpu), GFP_KERNEL);
> > > -	if (tpu == NULL) {
> > > -		dev_err(&pdev->dev, "failed to allocate driver data\n");
> > > +	if (tpu == NULL)
> > >  		return -ENOMEM;
> > > -	}
> > > 
> > >  	spin_lock_init(&tpu->lock);
> > >  	tpu->pdev = pdev;

-- 
Regards,

Laurent Pinchart

