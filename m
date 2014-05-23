From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] pwm: imx: set can_sleep flag for imx_pwm_v2
Date: Fri, 23 May 2014 15:05:07 +0800
Message-ID: <20140523070501.GE32184@dragon>
References: <1400824114-27148-1-git-send-email-shawn.guo@freescale.com>
 <537EED44.7030906@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn1blp0187.outbound.protection.outlook.com ([207.46.163.187]:19141
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752115AbaEWHFR (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 23 May 2014 03:05:17 -0400
Content-Disposition: inline
In-Reply-To: <537EED44.7030906@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Liu Ying <Ying.Liu@freescale.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

On Fri, May 23, 2014 at 02:40:04PM +0800, Liu Ying wrote:
> Hi Shawn,
> 
> On 05/23/2014 01:48 PM, Shawn Guo wrote:
> > The .config() hook of imx_pwm_data_v2 calls clk_get_rate() which might
> > sleep, so we need to set can_sleep flag on it.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> >  drivers/pwm/pwm-imx.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > index d797c7b84c3f..ab3809fb36a7 100644
> > --- a/drivers/pwm/pwm-imx.c
> > +++ b/drivers/pwm/pwm-imx.c
> > @@ -272,6 +272,9 @@ static int imx_pwm_probe(struct platform_device *pdev)
> >  	imx->config = data->config;
> >  	imx->set_enable = data->set_enable;
> >  
> > +	if (data == &imx_pwm_data_v2)
> > +		imx->chip.can_sleep = true;
> > +
> >  	ret = pwmchip_add(&imx->chip);
> >  	if (ret < 0)
> >  		return ret;
> > 
> 
> clk_prepare_enable()/clk_disable_unprepare() called in imx_pwm_config() may sleep.
> 
> So, the can_sleep flag should be true for both i.MX PWM v1 and v2, right?

Yes, you're right.  I missed that.  Thanks for pointing it out.

Will send v2 shortly.

Shawn
