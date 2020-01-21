From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: sun4i: Initialize variables before use
Date: Tue, 21 Jan 2020 15:31:25 +0100
Message-ID: <20200121143125.girqrg3hdhklgyor@pengutronix.de>
References: <20200120143206.710666-1-thierry.reding@gmail.com>
 <20200120200917.gvua5h2egoznwd4h@pengutronix.de>
 <20200121135011.GD899558@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45025 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgAUOb3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Jan 2020 09:31:29 -0500
Content-Disposition: inline
In-Reply-To: <20200121135011.GD899558@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, Jernej Skrabec <jernej.skrabec@siol.net>, =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>, linux-pwm@vger.kernel.org, kernel@pengutronix.de

Hello Thierry,

On Tue, Jan 21, 2020 at 02:50:11PM +0100, Thierry Reding wrote:
> On Mon, Jan 20, 2020 at 09:09:17PM +0100, Uwe Kleine-König wrote:
> > On Mon, Jan 20, 2020 at 03:32:06PM +0100, Thierry Reding wrote:
> > > GCC can't always determine that the duty, period and prescaler values
> > > are initialized when returning from sun4i_pwm_calculate(), so help out a
> > > little by initializing them to 0.
> > 
> > Is it worth mentioning the gcc version you're using?
> 
> I could, but what good is that going to be? I don't think this is
> something that's limited to one specific version but I don't know
> exactly which ones are impacted. Stating just one specific version
> isn't all that useful in that case.

I think something like:

	gcc 4.6 reports [...], newer gccs are fine.

is useful. If you read that in a few years, it helps you either to
reproduce the problem or determine it is not important any more.
 
> > > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > > ---
> > >  drivers/pwm/pwm-sun4i.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > index 0decc7cde133..3e3efa6c768f 100644
> > 
> > I don't find this object (0decc7cde133) in my tree or next. Which
> > version is this?
> 
> I made this on top of my local pwm/for-next when I was build-testing,
> which I usually do before pushing, so it's not surprising that you
> don't have this in your tree.

The reason I asked this (and also the gcc version) is to reproduce the
issue and work with it. With your reply I can only say that I expect
that uninitialized_var fixes the problem in a better way. If I knew the
exact circumstances, I could test them and claim that it indeed fixes it
(or see it doesn't and don't take your time with non-sense reviews).

> > > --- a/drivers/pwm/pwm-sun4i.c
> > > +++ b/drivers/pwm/pwm-sun4i.c
> > > @@ -234,9 +234,9 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > >  {
> > >  	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
> > >  	struct pwm_state cstate;
> > > -	u32 ctrl, duty, period, val;
> > > +	u32 ctrl, duty = 0, period = 0, val;
> > 
> > +     u32 ctrl, uninitialized_var(duty), uninitialized_var(period), val;
> > 
> > should fix the warnings, too, and additionally explicitly documents that
> > it's just the compiler that doesn't see there is no problem.
> 
> I haven't convinced myself fully yet that there really isn't a problem.
> I'm fairly sure it's safe, but always initializing to 0 doesn't hurt.

Yes, I agree that initializing the variable fixes the warning. Still
using uninitialized_var is the better way (assuming it indeed fixes the
problem, see above).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
