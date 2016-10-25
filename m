From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 6/6] pwm: imx: Introduce "polarity_supported" flag to
 PWMv2 driver
Date: Tue, 25 Oct 2016 08:37:00 +0200
Message-ID: <20161025083700.342f9abe@bbrezillon>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
        <1477259146-19167-7-git-send-email-l.majewski@majess.pl>
        <20161024172852.40662611@bbrezillon>
        <20161024173410.6e641b9c@bbrezillon>
        <20161024231458.075ea50b@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from up.free-electrons.com ([163.172.77.33]:33716 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932674AbcJYGhE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Oct 2016 02:37:04 -0400
In-Reply-To: <20161024231458.075ea50b@jawa>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de

Hi Lukasz,

On Mon, 24 Oct 2016 23:14:58 +0200
Lukasz Majewski <l.majewski@majess.pl> wrote:

> Hi Boris,
> 
> > On Mon, 24 Oct 2016 17:28:52 +0200
> > Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> >   
> > > On Sun, 23 Oct 2016 23:45:46 +0200
> > > Lukasz Majewski <l.majewski@majess.pl> wrote:
> > >   
> > > > The need for set_polarity() function has been removed by
> > > > implementing PWM atomic support (apply() callback).
> > > > 
> > > > To indicate that the PWMv2 supports polarity inversion, new flag -
> > > > "polarity_supported" has been introduced.
> > > > 
> > > > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > > > ---
> > > >  drivers/pwm/pwm-imx.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > > index 02d3dfd..be3034d 100644
> > > > --- a/drivers/pwm/pwm-imx.c
> > > > +++ b/drivers/pwm/pwm-imx.c
> > > > @@ -258,6 +258,7 @@ static struct pwm_ops imx_pwm_ops_v2 = {
> > > >  };
> > > >  
> > > >  struct imx_pwm_data {
> > > > +	bool polarity_supported;
> > > >  	struct pwm_ops *pwm_ops;
> > > >  };
> > > >  
> > > > @@ -266,6 +267,7 @@ static struct imx_pwm_data imx_pwm_data_v1 = {
> > > >  };
> > > >  
> > > >  static struct imx_pwm_data imx_pwm_data_v2 = {
> > > > +	.polarity_supported = true,
> > > >  	.pwm_ops = &imx_pwm_ops_v2,
> > > >  };
> > > >  
> > > > @@ -313,7 +315,7 @@ static int imx_pwm_probe(struct
> > > > platform_device *pdev) imx->chip.base = -1;
> > > >  	imx->chip.npwm = 1;
> > > >  	imx->chip.can_sleep = true;
> > > > -	if (data->pwm_ops->set_polarity) {
> > > > +	if (data->polarity_supported) {    
> > > 
> > > You're still breaking backward compatibility with DTs defining
> > > #pwm-cells = 2.
> > > 
> > > Please test the #pwm-cells value before deciding which of_xlate
> > > should be used.  
> > 
> > Nevermind, I didn't look at [1] and [2].  
> 
> Yes, some patches are required to make this code work. Especially, I
> wanted to explicitly reuse and credit work already done by
> Bhuvanchandra.
> 
> > But still, your series is not bisectable: this change should be part
> > of patch 5 where you remove the ->set_polarity implementation.
> > Otherwise, this means you don't support polarity setting between
> > patch 5 and 6.  
> 
> Frankly speaking, I did it on purpose, to have operations in commits
> logically separated.
> 
> I personally, do detest commits which blur the picture and are not
> corresponding to one single logical change - for example remove some
> large chunk of code and also add some tiny, new flag.
> 
> For me it is not a problem to have polarity disabled between patches 5
> and 6, since at the end of the day we have it enabled.

It's really simple to make this series bisectable, all you have to do
is move patch 6 before patch 5. This being said, I really think you
should follow Stefan's recommendation: base your changes on mainline
and switch to the atomic hook before supporting polarity setting.

Regards,

Boris
