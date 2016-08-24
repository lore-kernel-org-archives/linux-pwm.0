From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH v2 1/1] pwm: sun4i: fix a possible NULL dereference
Date: Wed, 24 Aug 2016 13:42:45 +0200
Message-ID: <20160824114245.GA29212@Red>
References: <1471353486-11514-1-git-send-email-clabbe.montjoie@gmail.com>
 <1471353486-11514-2-git-send-email-clabbe.montjoie@gmail.com>
 <20160822065737.GA7104@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35230 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbcHXLmu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 Aug 2016 07:42:50 -0400
Content-Disposition: inline
In-Reply-To: <20160822065737.GA7104@lukather>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: thierry.reding@gmail.com, wens@csie.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

On Mon, Aug 22, 2016 at 08:57:37AM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Aug 16, 2016 at 03:18:06PM +0200, LABBE Corentin wrote:
> > of_match_device could return NULL, and so cause a NULL pointer
> > dereference later.
> > 
> > For fixing this problem, we use of_device_get_match_data(), this will
> > simplify the code a little by using a standard function for
> > getting the match data.
> > 
> > Reported-by: coverity (CID 1324139)
> > Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 03a99a5..72f0060 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -309,9 +309,6 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
> >  	struct resource *res;
> >  	u32 val;
> >  	int i, ret;
> > -	const struct of_device_id *match;
> > -
> > -	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
> >  
> >  	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> >  	if (!pwm)
> > @@ -326,7 +323,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
> >  	if (IS_ERR(pwm->clk))
> >  		return PTR_ERR(pwm->clk);
> >  
> > -	pwm->data = match->data;
> > +	pwm->data = of_device_get_match_data(&pdev->dev);
> 
> How does that fix anything?
> 
> If of_match_data fails, it will return NULL, and the NULL pointer
> dereference will occur in the exact same cases.
> 
> You should just check for match to be NULL, and return in this case.
> 
> Maxime
> 

I apologize for havent seen this subsuquent NULL deref.

I send an updated version soon.

Regards
