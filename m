From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] pwm_lpss: Add support for PCI devices
Date: Thu, 17 Apr 2014 13:45:48 +0100
Message-ID: <20140417134548.0ff5ffb4@alan.etchedpixels.co.uk>
References: <1397672338-3510-1-git-send-email-chiau.ee.chew@intel.com>
	<20140417110756.GB32603@ulmo>
	<20140417121643.2c07ecfc@alan.etchedpixels.co.uk>
	<20140417113458.GC32603@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140417113458.GC32603@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Chew Chiau Ee <chiau.ee.chew@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Cox <alan@linux.intel.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

> But if you prefer not to do the split that's fine with me too.

I'd prefer not to split it. The real fix is to have modm_ functions akin
to devm_ but that's another story 8)

> > > > +static const struct pwm_lpss_boardinfo byt_info = {
> > > 
> > > What does byt_ stand for?
> > 
> > Baytrail.
> 
> Okay, that could use a comment since it's not mentioned anywhere else
> and the PCI IDs don't give it away either.

Agreed (it's btw a general Intel thing that devices end up known by a TLA
but it's a good point that they are not entirely well known outside Intel)
> 
> > > > -static int pwm_lpss_probe(struct platform_device *pdev)
> > > > +static struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev,
> > > > +			struct resource *r, struct pwm_lpss_boardinfo *info)
> > > 
> > > Indentation is odd here. Please align arguments one subsequent lines
> > > with those of the first.
> > 
> > That doesn't appear to be present in CodingStyle or indeed most of the
> > kernel.
> 
> I'm used to it in the PWM subsystem and I'd like to keep it that way for
> consistency.

Fair enough

Alan
